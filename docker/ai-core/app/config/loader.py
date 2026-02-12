import os
import re
from typing import Any, Dict
import yaml

_ENV_PATTERN = re.compile(r"\$\{([A-Z0-9_]+)(?::-(.*?))?\}")

def _expand_env(value: Any) -> Any:
    """Expand ${VAR} or ${VAR:-default} in YAML values."""
    if isinstance(value, str):
        def repl(match: re.Match) -> str:
            var = match.group(1)
            default = match.group(2) if match.group(2) is not None else ""
            return os.getenv(var, default)
        return _ENV_PATTERN.sub(repl, value)
    if isinstance(value, dict):
        return {k: _expand_env(v) for k, v in value.items()}
    if isinstance(value, list):
        return [_expand_env(v) for v in value]
    return value

def load_yaml(path: str) -> Dict[str, Any]:
    with open(path, "r") as f:
        data = yaml.safe_load(f) or {}
    return _expand_env(data)
