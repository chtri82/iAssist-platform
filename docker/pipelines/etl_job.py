import pandas as pd
from sqlalchemy import create_engine
from shared.config.settings import get_postgres_config, postgres_sqlalchemy_url
import psycopg2
import os

PG_CFG = get_postgres_config()
ENGINE_URL = postgres_sqlalchemy_url()  # uses shared config + env overrides
engine = create_engine(ENGINE_URL)

def extract_data():
    """Extract data from Postgres"""
    query = "SELECT * FROM user_transactions;"
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
