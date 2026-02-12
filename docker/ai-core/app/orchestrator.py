from typing import Dict, Any
from contracts import OrchestratorContract
from tools import ToolRegistry


class Orchestrator(OrchestratorContract):
    def __init__(self, tools: ToolRegistry):
        self.tools = tools

    def process(self, user_input: str) -> Dict[str, Any]:
        text = (user_input or "").strip().lower()

        if "forecast" in text:
            out = self.tools.get("r_forecast").run({"value": 42})
            if not out.get("ok"):
                return {"type": "error", "content": out, "metadata": {"orchestrator": "public-stub", "route": "forecast"}}
            return {"type": "json", "content": out["data"], "metadata": {"orchestrator": "public-stub", "route": "forecast"}}

        if "summary" in text:
            out = self.tools.get("r_summary").run({"numbers": [10, 20, 30, 40, 50]})
            if not out.get("ok"):
                return {"type": "error", "content": out, "metadata": {"orchestrator": "public-stub", "route": "summary"}}
            return {"type": "json", "content": out["data"], "metadata": {"orchestrator": "public-stub", "route": "summary"}}

        return {
            "type": "text",
            "content": "Try: 'forecast' or 'summary'.",
            "metadata": {"orchestrator": "public-stub", "route": "help"},
        }
