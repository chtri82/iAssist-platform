import os
import uuid
import json
import joblib
import psycopg2
import pandas as pd
from datetime import datetime
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

DB_HOST = os.getenv("POSTGRES_HOST", "postgres")
DB_NAME = os.getenv("POSTGRES_DB", "iassist")
DB_USER = os.getenv("POSTGRES_USER", "admin")
DB_PASS = os.getenv("POSTGRES_PASSWORD", "secret")

MODEL_DIR = "/models"
os.makedirs(MODEL_DIR, exist_ok=True)

def get_connection():
    return psycopg2.connect(
        host=DB_HOST,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASS,
    )

def load_training_data():
    with get_connection() as conn:
        df = pd.read_sql(
            "SELECT amount, category FROM user_transactions",
            conn
        )
    return df

def train_model(df: pd.DataFrame):
    X = df[["amount"]]
    y = df["category"]

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    model = RandomForestClassifier()
    model.fit(X_train, y_train)

    preds = model.predict(X_test)
    acc = accuracy_score(y_test, preds)

    return model, {"accuracy": acc}

def save_model(model, metrics):
    version = datetime.utcnow().strftime("%Y%m%d%H%M%S")
    model_name = "transaction_category_model"
    artifact_path = f"{MODEL_DIR}/{model_name}_{version}.joblib"

    joblib.dump(model, artifact_path)

    with get_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                INSERT INTO ai_models (name, version, metrics_json, artifact_path, is_active)
                VALUES (%s, %s, %s, %s, TRUE)
                """,
                (model_name, version, json.dumps(metrics), artifact_path),
            )
            conn.commit()

    print(f"Model saved: {artifact_path}")
    print(f"Metrics: {metrics}")

def main():
    df = load_training_data()
    if df.empty:
        print("No training data found.")
        return

    model, metrics = train_model(df)
    save_model(model, metrics)

if __name__ == "__main__":
    main()
