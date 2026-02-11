from fastapi import FastAPI, Body
import importlib.util
import os
from typing import Type

from tools import ToolRegistry
from public_tools import RForecastTool, RSummaryTool
from orchestrator import Orchestrator as PublicOrchestrator

# Initialize FastAPI app FIRST
app = FastAPI(title="iAssist AI Core", version="1.0")

# ---- Public tool registry (works in public-only mode) ----
R_BASE_URL = os.getenv("R_ANALYTICS_URL", "http://r-analytics:8000")

registry = ToolRegistry()
registry.register(RForecastTool(R_BASE_URL))
registry.register(RSummaryTool(R_BASE_URL))

def load_private_orchestrator_class() -> Type | None:
    """
    If private intelligence is mounted, load its Orchestrator class.
    Returns None if not found / not loadable.
    """
    intelligence_path = os.getenv(
        "IA_INTELLIGENCE_ORCHESTRATOR_PATH",
        "/app/intelligence/orchestrator.py",
    )

    if not os.path.exists(intelligence_path):
        return None

    spec = importlib.util.spec_from_file_location("private_orchestrator", intelligence_path)
    if not spec or not spec.loader:
        return None

    private_mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(private_mod)

    if hasattr(private_mod, "Orchestrator"):
        print(f"[INFO] Loaded private intelligence orchestrator from {intelligence_path}")
        return private_mod.Orchestrator

    return None

# ---- Initialize orchestrator (private if available, else public with tools) ----
PrivateOrchestrator = load_private_orchestrator_class()

if PrivateOrchestrator:
    orchestrator = PrivateOrchestrator()
else:
    print("[WARN] Using public orchestrator stub.")
    orchestrator = PublicOrchestrator(registry)

# ---- Runtime guardrail ----
required_keys = {"type", "content", "metadata"}
test_response = orchestrator.process("healthcheck")
if not isinstance(test_response, dict) or not required_keys.issubset(test_response.keys()):
    raise RuntimeError("Loaded orchestrator does not conform to OrchestratorContract")


@app.get("/tools")
def list_tools():
    return {"tools": registry.list()}


@app.post("/command")
async def handle_command(data: dict = Body(...)):
    user_input = data.get("input", "")
    return orchestrator.process(user_input)


@app.get("/")
def root():
    return {"message": "iAssist AI Core operational"}


@app.get("/capabilities")
def capabilities():
    impl = orchestrator.__class__.__module__
    return {
        "orchestrator_module": impl,
        "private_intelligence_loaded": impl == "private_orchestrator",
        "public_tools": registry.list(),
    }
