from typing import Dict, Any, Optional
from app.contracts import OrchestratorContract
from app.tools import ToolRegistry
from app.tool_wrapper import LoggingToolWrapper


class Orchestrator(OrchestratorContract):
    def __init__(self, tools: ToolRegistry, job_store=None):
        self.tools = tools
        self.job_store = job_store  # may be None in tests

    def _wrap(self, tool_name: str, context: Optional[Dict[str, Any]]):
        tool = self.tools.get(tool_name)
        if not self.job_store:
            return tool  # no logging if no job_store provided

        request_id = (context or {}).get("request_id")
        job_id = (context or {}).get("job_id")
        return LoggingToolWrapper(tool, self.job_store, tool_name, request_id=request_id, job_id=job_id)

    def process(self, user_input: str, context: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        text = (user_input or "").strip().lower()

        if "forecast" in text:
            out = self._wrap("r_forecast", context).run({"value": 42})
            if not out.get("ok", True):
                return {
                    "type": "error",
                    "content": out.get("data", out),
                    "metadata": {
                        "orchestrator": "public-stub",
                        "route": "forecast",
                        "request_id": (context or {}).get("request_id"),
                        "job_id": (context or {}).get("job_id"),
                    },
                }
            return {
                "type": "json",
                "content": out.get("data", out),
                "metadata": {
                    "orchestrator": "public-stub",
                    "route": "forecast",
                    "request_id": (context or {}).get("request_id"),
                    "job_id": (context or {}).get("job_id"),
                },
            }

        if "summary" in text:
            out = self._wrap("r_summary", context).run({"numbers": [10, 20, 30, 40, 50]})
            if not out.get("ok", True):
                return {
                    "type": "error",
                    "content": out.get("data", out),
                    "metadata": {
                        "orchestrator": "public-stub",
                        "route": "summary",
                        "request_id": (context or {}).get("request_id"),
                        "job_id": (context or {}).get("job_id"),
                    },
                }
            return {
                "type": "json",
                "content": out.get("data", out),
                "metadata": {
                    "orchestrator": "public-stub",
                    "route": "summary",
                    "request_id": (context or {}).get("request_id"),
                    "job_id": (context or {}).get("job_id"),
                },
            }
        return {
            "type": "text",
            "content": "Try: 'forecast' or 'summary'.",
            "metadata": {
                "orchestrator": "public-stub",
                "route": "help",
                "request_id": (context or {}).get("request_id"),
                "job_id": (context or {}).get("job_id"),
            },
        }