import time
import requests
from typing import Dict, Any


class _HttpToolBase:
    def __init__(self, base_url: str, timeout_s: int = 15, retries: int = 2, backoff_s: float = 0.5):
        self.base_url = base_url
        self.timeout_s = timeout_s
        self.retries = retries
        self.backoff_s = backoff_s

    def _post_json(self, path: str, payload: Dict[str, Any]) -> Dict[str, Any]:
        url = f"{self.base_url}{path}"
        last_err = None

        for attempt in range(self.retries + 1):
            try:
                r = requests.post(url, json=payload, timeout=self.timeout_s)
                r.raise_for_status()
                return {"ok": True, "data": r.json()}
            except Exception as e:
                last_err = str(e)
                if attempt < self.retries:
                    time.sleep(self.backoff_s * (attempt + 1))
                else:
                    return {
                        "ok": False,
                        "error": {
                            "message": "Downstream tool call failed",
                            "downstream": url,
                            "details": last_err,
                        },
                    }


class RForecastTool(_HttpToolBase):
    name = "r_forecast"

    def run(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        return self._post_json("/forecast", payload)


class RSummaryTool(_HttpToolBase):
    name = "r_summary"

    def run(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        return self._post_json("/summary", payload)
