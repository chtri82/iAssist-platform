import time
from typing import Dict, Any, Optional

class LoggingToolWrapper:
    def __init__(self, tool, job_store, tool_name: str, request_id: Optional[str] = None, job_id: Optional[str] = None):
        self.tool = tool
        self.job_store = job_store
        self.tool_name = tool_name
        self.request_id = request_id
        self.job_id = job_id

    def run(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        start = time.time()
        try:
            out = self.tool.run(payload)
            ms = int((time.time() - start) * 1000)
            self.job_store.log_tool_invocation(self.tool_name, True, self.request_id, self.job_id, ms, None)
            return out
        except Exception as e:
            ms = int((time.time() - start) * 1000)
            self.job_store.log_tool_invocation(self.tool_name, False, self.request_id, self.job_id, ms, str(e))
            raise
