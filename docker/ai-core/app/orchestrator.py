from typing import Dict, Any, Optional
from app.contracts import OrchestratorContract
from app.tool_wrapper import LoggingToolWrapper


class Orchestrator(OrchestratorContract):
    def __init__(self, tools, job=None, job_store_pg=None, approved_sources=None):
        self.tools = tools
        self.job = job
        self.job_store_pg = job_store_pg
        self.approved_sources = approved_sources or {"version": 1, "sources": []}

    def _wrap(self, tool_name: str, context: Optional[Dict[str, Any]]):
        tool = self.tools.get(tool_name)
        if not self.job_store_pg:
            return tool  # no logging if no job store provided

        request_id = (context or {}).get("request_id")
        job_id = (context or {}).get("job_id")
        return LoggingToolWrapper(tool, self.job_store_pg, tool_name, request_id=request_id, job_id=job_id)

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
                    # prefer not to expose full list in public responses:
                    "approved_sources_count": len(self.approved_sources.get("sources", [])),
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
                        "approved_sources_count": len(self.approved_sources.get("sources", [])),
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
                    "approved_sources_count": len(self.approved_sources.get("sources", [])),
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
                "approved_sources_count": len(self.approved_sources.get("sources", [])),
            },
        }
