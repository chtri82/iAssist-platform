from __future__ import annotations

import os
from functools import lru_cache
from typing import Any, Dict, Optional

from shared.config.loader import load_yaml

def env(key: str, default: Optional[str] = None) -> Optional[str]:
    """Small helper for env vars."""
    v = os.getenv(key)
    return v if v not in (None, "") else default

def _default_services_path() -> str:
    """
    Resolve services.yaml relative to THIS file so it works in any container.
    shared/config/settings.py -> shared/config/services.yaml
    """
    here = os.path.dirname(os.path.abspath(__file__))
    return os.path.join(here, "services.yaml")

@lru_cache(maxsize=1)
def load_services_config(path: Optional[str] = None) -> Dict[str, Any]:
    """
    Load YAML config, then overlay environment variables.
    Environment variables always win.

    Resolution order:
      1) explicit `path` arg if provided
      2) IA_SERVICES_CONFIG env var if set
      3) shared/config/services.yaml (relative to this file)
    """
    if path is None:
        path = env("IA_SERVICES_CONFIG") or _default_services_path()

    cfg = load_yaml(path)

    # ---- Postgres overlays ----
    services = cfg.setdefault("services", {})
    pg = services.setdefault("postgres", {})
    pg["host"] = env("POSTGRES_HOST", pg.get("host", "postgres"))
    pg["port"] = int(env("POSTGRES_PORT", str(pg.get("port", 5432))) or 5432)
    pg["dbname"] = env("POSTGRES_DB", pg.get("dbname", "iassist"))
    pg["user"] = env("POSTGRES_USER", pg.get("user", "admin"))
    pg["password"] = env("POSTGRES_PASSWORD", pg.get("password", "secret"))

    # ---- R analytics overlays ----
    r = services.setdefault("r_analytics", {})
    r["base_url"] = env("R_ANALYTICS_URL", r.get("base_url", "http://r-analytics:8000"))
    r["health_path"] = env("R_ANALYTICS_HEALTH_PATH", r.get("health_path", "/health"))
    r["timeout_s"] = int(env("R_ANALYTICS_TIMEOUT_S", str(r.get("timeout_s", 3))) or 3)

    return cfg

def get_postgres_config() -> Dict[str, Any]:
    cfg = load_services_config()
    return cfg["services"]["postgres"]

def postgres_dsn(cfg: Optional[Dict[str, Any]] = None) -> str:
    """psycopg2 DSN for Postgres."""
    if cfg is None:
        cfg = load_services_config()
    pg = cfg["services"]["postgres"]
    return (
        f"dbname={pg['dbname']} "
        f"host={pg['host']} "
        f"port={pg['port']} "
        f"user={pg['user']} "
        f"password={pg['password']}"
    )

def postgres_sqlalchemy_url(cfg: Optional[Dict[str, Any]] = None) -> str:
    """SQLAlchemy URL for Postgres."""
    if cfg is None:
        cfg = load_services_config()
    pg = cfg["services"]["postgres"]
    return (
        f"postgresql+psycopg2://{pg['user']}:{pg['password']}"
        f"@{pg['host']}:{pg['port']}/{pg['dbname']}"
    )
