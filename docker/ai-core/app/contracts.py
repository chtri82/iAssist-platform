from __future__ import annotations
from typing import Dict, Any, Protocol, Optional
from app.tools import ToolRegistry
from app.job_store import JobStore  


class OrchestratorContract(Protocol):
    def process(self, user_input: str, context: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        ...

    def __init__(self, tools: ToolRegistry, job_store: JobStore, approved_sources: Dict[str, Any] | None = None) -> None:
        ...

    async def handle(self, request: Dict[str, Any]) -> Dict[str, Any]:
        ...
