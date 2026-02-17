import os
from typing import Optional, Dict, Any

import joblib
import pandas as pd
import psycopg2

from shared.config.settings import load_services_config, postgres_dsn
from shared.ml.features import build_features, to_dict

class ModelManager:
    def __init__(self, model_name: str = "transaction_category_model"):
        self.model_name = model_name
        self.model = None
        self.model_path: Optional[str] = None
        self.active_version: Optional[str] = None
        self.load_active_model()

    def _conn(self):
        cfg = load_services_config()
        return psycopg2.connect(postgres_dsn(cfg))

    def load_active_model(self):
        with self._conn() as conn, conn.cursor() as cur:
            cur.execute(
                """
                SELECT version, artifact_path, metrics_json
                FROM ai_models
                WHERE name=%s AND is_active = TRUE
                ORDER BY created_at DESC
                LIMIT 1
                """,
                (self.model_name,),
            )
            row = cur.fetchone()

        if not row:
            print(f"[MODEL] No active model found for name={self.model_name}")
            self.model = None
            self.model_path = None
            self.active_version = None
            return

        version, path, _metrics = row
        if path and os.path.exists(path):
            self.model = joblib.load(path)
            self.model_path = path
            self.active_version = version
            print(f"[MODEL] Loaded {self.model_name} {version} from {path}")
        else:
            print(f"[MODEL] Artifact path not found: {path}")
            self.model = None
            self.model_path = None
            self.active_version = None

    def info(self) -> Dict[str, Any]:
        return {
            "model_name": self.model_name,
            "model_path": self.model_path,
            "active_version": self.active_version,
        }

    def predict(self, amount: float) -> str:
        if not self.model:
            raise RuntimeError("Model not loaded")

        fr = build_features(float(amount))
        X = pd.DataFrame([to_dict(fr)])  # must match training feature columns
        return self.model.predict(X)[0]
