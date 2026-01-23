from fastapi import APIRouter
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
import joblib
import psycopg2
from datetime import datetime
import os

router = APIRouter()

@router.post("/train")
def train_model():
    """Train a model using data from Postgres."""
    # 1. Connect to database
    conn = psycopg2.connect(
        host=os.getenv("POSTGRES_HOST", "postgres"),
        database=os.getenv("POSTGRES_DB", "iassist"),
        user=os.getenv("POSTGRES_USER", "admin"),
        password=os.getenv("POSTGRES_PASSWORD", "secret"),
    )
    
    df = pd.read_sql("SELECT * FROM user_transactions", conn)

    # 2. Preprocess
    df["category_encoded"] = df["category"].astype("category").cat.codes
    X = df[["category_encoded", "user_id"]]
    y = df["amount"]

    # 3. Train model
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
    model = RandomForestRegressor(n_estimators=100)
    model.fit(X_train, y_train)

    # 4. Save model
    joblib.dump(model, "storage/checkpoints/model_latest.pkl")

    # 5. Log result
    cursor = conn.cursor()
    cursor.execute(
        """
        INSERT INTO results (service, input_data, output_data, created_on)
        VALUES (%s, %s, %s, %s)
        """,
        ("training", f"{len(df)} rows", "Model retrained successfully", datetime.now())
    )
    conn.commit()
    conn.close()

    return {"status": "success", "message": "Model retrained"}
