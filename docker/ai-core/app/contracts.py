from typing import Dict, Any, Protocol

class OrchestratorContract(Protocol):
    """
    Public contract that ALL orchestrators (public stub or private intelligence)
    must implement.
    """

    def process(self, user_input: str) -> Dict[str, Any]:
        """
        Process a user command and return a structured response.

        REQUIRED response shape:
        {
          "type": "text" | "tool_call" | "error",
          "content": str,
          "metadata": dict
        }
        """
        ...
