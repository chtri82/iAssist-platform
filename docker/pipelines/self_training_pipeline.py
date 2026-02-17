import os
import uuid
import json
from datetime import datetime, timezone

import pandas as pd
import joblib
import psycopg2
from psycopg2.extras import Json

from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, f1_score
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
from sklearn.pipeline import Pipeline
from sklearn.ensemble import RandomForestClassifier

from shared.config.settings import load_services_config, postgres_dsn

MODEL_DIR = os.getenv("MODEL_DIR", "/models")
FEATURE_DIR = os.path.join(MODEL_DIR, "features")
MODELS_DIR = os.path.join(MODEL_DIR, "models")
os.makedirs(MODELS_DIR, exist_ok=True)

def utc_now():
    return datetime.now(timezone.utc)

def load_features() -> pd.DataFrame:
    latest = os.path.join(FEATURE_DIR, "latest.parquet")
    if not os.path.exists(latest):
        raise FileNotFoundError(f"Missing features parquet: {latest}. Run etl_job.py first.")
    df = pd.read_parquet(latest)
    return df

def train_model(df: pd.DataFrame):
    # Features and label
    X = df[["amount", "hour", "day_of_week", "month"]]
    y = df["category"].astype(str)

    # Train/test split
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y if y.nunique() > 1 else None
    )

    # Preprocess: one-hot encode discrete time parts; pass amount through
    cat_cols = ["hour", "day_of_week", "month"]
    num_cols = ["amount"]

    pre = ColumnTransformer(
        transformers=[
            ("cat", OneHotEncoder(handle_unknown="ignore"), cat_cols),
            ("num", "passthrough", num_cols),
        ]
    )

    clf = RandomForestClassifier(
        n_estimators=200,
        random_state=42,
        n_jobs=-1,
    )

    pipe = Pipeline([("pre", pre), ("clf", clf)])
    pipe.fit(X_train, y_train)

    pred = pipe.predict(X_test)
    metrics = {
        "accuracy": float(accuracy_score(y_test, pred)),
        "f1_macro": float(f1_score(y_test, pred, average="macro")),
        "n_train": int(len(X_train)),
        "n_test": int(len(X_test)),
        "labels": sorted(list(y.unique())),
    }

    return pipe, metrics

def register_model(name: str, version: str, artifact_path: str, metrics: dict):
    dsn = postgres_dsn(load_services_config())
    with psycopg2.connect(dsn) as conn, conn.cursor() as cur:
        # Deactivate old actives AND insert new active in one transaction
        cur.execute(
            "UPDATE ai_models SET is_active=FALSE WHERE name=%s AND is_active=TRUE",
            (name,),
        )

        cur.execute(
            """
            INSERT INTO ai_models (name, version, metrics_json, artifact_path, is_active)
            VALUES (%s, %s, %s, %s, TRUE)
            """,
            (name, version, Json(metrics), artifact_path),
        )
        conn.commit()

def main():
    df = load_features()
    if df.empty:
        print("No features available; exiting.")
        return

    model, metrics = train_model(df)
    version = f"v_{utc_now().strftime('%Y%m%d_%H%M%S')}_{uuid.uuid4().hex[:8]}"
    name = "transaction_category_model"

    artifact_path = os.path.join(MODELS_DIR, f"{name}_{version}.joblib")
    joblib.dump(model, artifact_path)

    print(f"✅ Saved model: {artifact_path}")
    print(f"✅ Metrics: {json.dumps(metrics, indent=2)}")

    register_model(name, version, artifact_path, metrics)
    print(f"✅ Registered + activated model {name} {version}")

if __name__ == "__main__":
    main()
