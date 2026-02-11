import requests
from typing import Dict, Any

class RForecastTool:
    name = "r_forecast"
    def __init__(self, base_url: str):
        self.base_url = base_url

    def run(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        r = requests.post(f"{self.base_url}/forecast", json=payload, timeout=10)
        r.raise_for_status()
        return r.json()

class RSummaryTool:
    name = "r_summary"
    def __init__(self, base_url: str):
        self.base_url = base_url

    def run(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        r = requests.post(f"{self.base_url}/summary", json=payload, timeout=10)
        r.raise_for_status()
        return r.json()
