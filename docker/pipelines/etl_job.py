import os
from datetime import datetime, timezone

import pandas as pd
import psycopg2

from shared.config.settings import load_services_config, postgres_dsn

MODEL_DIR = os.getenv("MODEL_DIR", "/models")
FEATURE_DIR = os.path.join(MODEL_DIR, "features")
os.makedirs(FEATURE_DIR, exist_ok=True)


def utc_now():
    return datetime.now(timezone.utc)


def extract_transactions(limit: int = 5000) -> pd.DataFrame:
    cfg = load_services_config()
    dsn = postgres_dsn(cfg)

    with psycopg2.connect(dsn) as conn:
        df = pd.read_sql(
            """
            SELECT
              id,
              user_id,
              amount,
              category,
              created_at
            FROM user_transactions
            ORDER BY created_at DESC
            LIMIT %s
            """,
            conn,
            params=(limit,),
        )

    # normalize types
    df["created_at"] = pd.to_datetime(df["created_at"], utc=True, errors="coerce")
    df["category"] = df["category"].astype(str)
    df["amount"] = pd.to_numeric(df["amount"], errors="coerce").fillna(0.0)
    return df


def build_features(df: pd.DataFrame) -> pd.DataFrame:
    df = df.dropna(subset=["created_at"]).copy()

    # Feature set used by training AND inference
    df["hour"] = df["created_at"].dt.hour.astype(int)
    df["day_of_week"] = df["created_at"].dt.dayofweek.astype(int)  # Monday=0
    df["month"] = df["created_at"].dt.month.astype(int)

    # keep only what training needs (+ created_at for debugging)
    feats = df[["amount", "hour", "day_of_week", "month", "category", "created_at"]].copy()
    return feats


def write_latest_parquet(df: pd.DataFrame) -> str:
    latest_path = os.path.join(FEATURE_DIR, "latest.parquet")
    df.to_parquet(latest_path, index=False)
    return latest_path


def main():
    df = extract_transactions()
    if df.empty:
        print("No transactions found; skipping features write.")
        return

    feats = build_features(df)
    out = write_latest_parquet(feats)

    print(f"✅ Wrote features artifact: {out}")
    print(f"✅ Rows: {len(feats)}  Columns: {list(feats.columns)}")


if __name__ == "__main__":
    main()
