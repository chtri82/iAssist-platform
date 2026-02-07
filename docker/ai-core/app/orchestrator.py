from contracts import OrchestratorContract
from typing import Dict, Any


class Orchestrator(OrchestratorContract):
    """
    Public fallback orchestrator.
    Used when private intelligence is not mounted.
    """

    def process(self, user_input: str) -> Dict[str, Any]:
        return {
            "type": "text",
            "content": f"[Stub response] You said: {user_input}",
            "metadata": {
                "orchestrator": "public-stub",
                "confidence": "low"
            }
        }
