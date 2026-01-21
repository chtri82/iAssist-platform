import pandas as pd
import psycopg2
from sqlalchemy import create_engine
import os

# Environment variables (will come from docker-compose)
DB_USER = os.getenv("POSTGRES_USER", "admin")
DB_PASS = os.getenv("POSTGRES_PASSWORD", "secret")
DB_HOST = os.getenv("POSTGRES_HOST", "postgres")
DB_PORT = os.getenv("POSTGRES_PORT", "5432")
DB_NAME = os.getenv("POSTGRES_DB", "iassist")

def extract_data():
    """Extract data from Postgres"""
    conn_str = f"postgresql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    engine = create_engine(conn_str)
    query = "SELECT * FROM user_transactions;"  # Example table
    df = pd.read_sql(query, engine)
    print(f"✅ Extracted {len(df)} rows.")
    return df

def transform_data(df):
    """Perform cleaning, enrichment, or feature engineering"""
    df["amount_usd"] = df["amount"] * 1.00  # Example conversion
    df["category"] = df["category"].str.title()
    print("🧠 Data transformed.")
    return df

def load_data(df):
    """Load transformed data back into Postgres"""
    conn_str = f"postgresql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    engine = create_engine(conn_str)
    df.to_sql("user_transactions_cleaned", engine, if_exists="replace", index=False)
    print("💾 Data loaded into user_transactions_cleaned")

def run_etl():
    print("🚀 Starting ETL pipeline...")
    df = extract_data()
    df = transform_data(df)
    load_data(df)
    print("✅ ETL pipeline complete.")

if __name__ == "__main__":
    run_etl()
