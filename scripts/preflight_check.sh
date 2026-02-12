#!/usr/bin/env bash
set -euo pipefail

fail=0

check_not_tracked() {
  local pattern="$1"
  if git ls-files | grep -E "$pattern" >/dev/null 2>&1; then
    echo "[FAIL] Forbidden file tracked in git: pattern=$pattern"
    fail=1
  else
    echo "[OK] No forbidden tracked files for pattern=$pattern"
  fi
}

check_not_present() {
  local path="$1"
  if [ -e "$path" ]; then
    echo "[WARN] Local file exists (ok for dev, must not be committed): $path"
  else
    echo "[OK] Local file not present: $path"
  fi
}

check_not_tracked '(^|/)\.env($|/)'
check_not_tracked '(^|/).*\.sql$'
check_not_tracked '(^|/)logs(/|$)'

check_not_present ".env"
check_not_present "docker-compose.private.override.yml"

if [ "$fail" -ne 0 ]; then
  echo "Preflight failed."
  exit 1
fi

echo "Preflight passed."
