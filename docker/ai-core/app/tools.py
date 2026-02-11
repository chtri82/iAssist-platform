from typing import Dict, Any, Protocol, Callable

class ToolContract(Protocol):
    name: str
    def run(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        ...

class ToolRegistry:
    def __init__(self):
        self._tools: Dict[str, ToolContract] = {}

    def register(self, tool: ToolContract) -> None:
        self._tools[tool.name] = tool

    def get(self, name: str) -> ToolContract:
        if name not in self._tools:
            raise KeyError(f"Tool '{name}' not registered")
        return self._tools[name]

    def list(self):
        return sorted(self._tools.keys())
