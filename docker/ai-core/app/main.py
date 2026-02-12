from fastapi import FastAPI, Body, Request
import importlib.util
import os
import requests

from typing import Type

from tools import ToolRegistry
from public_tools import RForecastTool, RSummaryTool
from orchestrator import Orchestrator as PublicOrchestrator

# Initialize FastAPI app FIRST
app = FastAPI(title="iAssist AI Core", version="1.0")

from config.loader import load_yaml

CONFIG = load_yaml("app/config/services.yaml")
R_CFG = CONFIG["services"]["r_analytics"]
R_BASE_URL = R_CFG["base_url"]

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

@app.get("/healthz")
def healthz():
    status = {"ok": True, "checks": {}}
    url = f"{R_BASE_URL}{R_CFG.get('health_path', '/health')}"
    try:
        r = requests.get(url, timeout=int(R_CFG.get("timeout_s", 3)))
        status["checks"]["r_analytics"] = {"ok": r.status_code == 200, "status_code": r.status_code}
        if r.status_code != 200:
            status["ok"] = False
    except Exception as e:
        status["checks"]["r_analytics"] = {"ok": False, "error": str(e)}
        status["ok"] = False
    return status

@app.post("/command")
async def handle_command(data: dict = Body(...)):
    user_input = data.get("input", "")
    resp = orchestrator.process(user_input)

    # Ensure metadata exists + include request id
    resp.setdefault("metadata", {})
    resp["metadata"]["request_id"] = request.state.request_id
    return resp

@app.middleware("http")
async def add_request_id(request: Request, call_next):
    request_id = request.headers.get("x-request-id") or str(uuid.uuid4())
    request.state.request_id = request_id
    response = await call_next(request)
    response.headers["x-request-id"] = request_id
    return response

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