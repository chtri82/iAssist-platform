from __future__ import annotations

import os
from pathlib import Path
from typing import Any, Dict, Optional
from shared.config.settings import load_yaml


DEFAULT_PRIVATE_PATHS = [
    Path("/app/intelligence/config/approved_sources.yml"),  # when intelligence is mounted into ai-core
    Path("/app/intelligence/approved_sources.yml"),         # alternate
]

DEFAULT_PUBLIC_EXAMPLE = Path(__file__).with_name("approved_sources.example.yml")


def _load_yaml(path: Path) -> Dict[str, Any]:
    with path.open("r", encoding="utf-8") as f:
        data = load_yaml.safe_load(f) or {}
    if not isinstance(data, dict):
        raise ValueError(f"approved sources YAML must be a mapping, got: {type(data)}")
    return data


def load_approved_sources(env_var: str = "IA_APPROVED_SOURCES_PATH") -> Dict[str, Any]:
    """
    Load approved sources with this precedence:
      1) IA_APPROVED_SOURCES_PATH if set + exists
      2) default private intelligence paths if present
      3) public example file
      4) empty structure
    """
    override = os.getenv(env_var)
    if override:
        p = Path(override)
        if p.exists():
            return _load_yaml(p)

    for p in DEFAULT_PRIVATE_PATHS:
        if p.exists():
            return _load_yaml(p)

    if DEFAULT_PUBLIC_EXAMPLE.exists():
        return _load_yaml(DEFAULT_PUBLIC_EXAMPLE)

    return {"version": 1, "sources": []}
