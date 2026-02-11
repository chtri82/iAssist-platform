from typing import Dict, Any, Protocol

class OrchestratorContract(Protocol):
    def process(self, user_input: str) -> Dict[str, Any]:
        """
        REQUIRED response shape:
        {
          "type": "text" | "json" | "tool_call" | "error",
          "content": str | dict | list,
          "metadata": dict
        }
        """
        ...
