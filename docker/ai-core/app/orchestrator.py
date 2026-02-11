from typing import Dict, Any
from contracts import OrchestratorContract
from tools import ToolRegistry

class Orchestrator(OrchestratorContract):
    def __init__(self, tools: ToolRegistry):
        self.tools = tools

    def process(self, user_input: str) -> Dict[str, Any]:
        text = (user_input or "").lower()

        if "forecast" in text:
            data = self.tools.get("r_forecast").run({"value": 42})
            return {"type": "json", "content": data, "metadata": {"orchestrator":"public-stub","route":"forecast"}}

        if "summary" in text:
            data = self.tools.get("r_summary").run({"numbers":[10,20,30,40,50]})
            return {"type": "json", "content": data, "metadata": {"orchestrator":"public-stub","route":"summary"}}

        return {"type":"text","content": f"[Public stub] Try 'forecast' or 'summary'. You said: {user_input}",
                "metadata":{"orchestrator":"public-stub","route":"help"}}
