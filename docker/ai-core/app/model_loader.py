import os
import psycopg2
import joblib
from typing import Optional

class ModelManager:
    def __init__(self):
        self.model = None
        self.model_path = None
        self.load_active_model()

    def _conn(self):
        return psycopg2.connect(
            host=os.getenv("POSTGRES_HOST", "postgres"),
            dbname=os.getenv("POSTGRES_DB", "iassist"),
            user=os.getenv("POSTGRES_USER", "admin"),
            password=os.getenv("POSTGRES_PASSWORD", "secret"),
        )

    def load_active_model(self):
        with self._conn() as conn:
            with conn.cursor() as cur:
                cur.execute("""
                    SELECT artifact_path
                    FROM ai_models
                    WHERE is_active = TRUE
                    ORDER BY created_at DESC
                    LIMIT 1
                """)
                row = cur.fetchone()

        if row:
            path = row[0]
            if os.path.exists(path):
                self.model = joblib.load(path)
                self.model_path = path
                print(f"[MODEL] Loaded model from {path}")
            else:
                print(f"[MODEL] Artifact path not found: {path}")
        else:
            print("[MODEL] No active model found.")

    def predict(self, amount: float):
        if not self.model:
            raise RuntimeError("Model not loaded")
        return self.model.predict([[amount]])[0]
