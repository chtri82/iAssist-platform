import os
from dataclasses import dataclass
from typing import Any, Dict, Optional
from shared.config.loader import load_yaml

def env(key: str, default: Optional[str] = None) -> Optional[str]:
    """Small helper for env vars."""
    v = os.getenv(key)
    return v if v not in (None, "") else default

def get_postgres_config():
    cfg = load_services_config()
    return cfg["services"]["postgres"]

def load_services_config(path: str = "app/config/services.yaml") -> Dict[str, Any]:
    """
    Load YAML config, then overlay environment variables.
    Environment variables always win.
    """
    cfg = load_yaml(path)

    # ---- Postgres overlays ----
    pg = cfg.setdefault("services", {}).setdefault("postgres", {})
    pg["host"] = env("POSTGRES_HOST", pg.get("host", "postgres"))
    pg["port"] = int(env("POSTGRES_PORT", str(pg.get("port", 5432))) or 5432)
    pg["dbname"] = env("POSTGRES_DB", pg.get("dbname", "iassist"))
    pg["user"] = env("POSTGRES_USER", pg.get("user", "admin"))
    pg["password"] = env("POSTGRES_PASSWORD", pg.get("password", "secret"))

    # ---- R analytics overlays ----
    r = cfg["services"].setdefault("r_analytics", {})
    r["base_url"] = env("R_ANALYTICS_URL", r.get("base_url", "http://r-analytics:8000"))
    r["health_path"] = env("R_ANALYTICS_HEALTH_PATH", r.get("health_path", "/health"))
    r["timeout_s"] = int(env("R_ANALYTICS_TIMEOUT_S", str(r.get("timeout_s", 3))) or 3)

    # Add more services here as you expand:
    # api-gateway, openai, etc.

    return cfg

def postgres_dsn(cfg: Dict[str, Any]) -> str:
    """psycopg2 DSN for Postgres."""
    pg = cfg["services"]["postgres"]
    return (
        f"dbname={pg['dbname']} "
        f"host={pg['host']} "
        f"port={pg['port']} "
        f"user={pg['user']} "
        f"password={pg['password']}"
    )

def postgres_sqlalchemy_url():
    cfg = load_services_config()
    pg = cfg["services"]["postgres"]
    return f"postgresql+psycopg2://{pg['user']}:{pg['password']}@{pg['host']}:{pg['port']}/{pg['dbname']}"
