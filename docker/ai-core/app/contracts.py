from typing import Dict, Any, Protocol, Optional

class OrchestratorContract(Protocol):
    def process(self, user_input: str, context: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        ...
