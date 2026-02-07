from fastapi import FastAPI, Body
import importlib.util
import os
from typing import Type


def load_orchestrator_class() -> Type:
    """
    Loads the private orchestrator if mounted; otherwise falls back to the public stub.
    """
    # Configurable path so compose override can mount intelligence wherever we want.
    intelligence_path = os.getenv(
        "IA_INTELLIGENCE_ORCHESTRATOR_PATH",
        "/app/intelligence/orchestrator.py",
    )

    if os.path.exists(intelligence_path):
        spec = importlib.util.spec_from_file_location("private_orchestrator", intelligence_path)
        if spec and spec.loader:
            private_mod = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(private_mod)
            if hasattr(private_mod, "Orchestrator"):
                print(f"[INFO] Loaded private intelligence orchestrator from {intelligence_path}")
                return private_mod.Orchestrator

        print(f"[WARN] Private orchestrator file found but could not be loaded: {intelligence_path}")

    # Public fallback (this file exists: app/orchestrator.py)
    from orchestrator import Orchestrator as PublicOrchestrator
    print("[WARN] Using public orchestrator stub.")
    return PublicOrchestrator


# Initialize FastAPI app
app = FastAPI(title="iAssist AI Core", version="1.0")

# Initialize Orchestrator
OrchestratorImpl = load_orchestrator_class()
orchestrator = OrchestratorImpl()

# Runtime guardrail
required_keys = {"type", "content", "metadata"}
test_response = orchestrator.process("healthcheck")

if not isinstance(test_response, dict) or not required_keys.issubset(test_response.keys()):
    raise RuntimeError(
        "Loaded orchestrator does not conform to OrchestratorContract"
    )

@app.post("/command")
async def handle_command(data: dict = Body(...)):
    user_input = data.get("input", "")
    response = orchestrator.process(user_input)
    return {"response": response}


@app.get("/")
def root():
    return {"message": "iAssist AI Core operational"}


@app.get("/capabilities")
def capabilities():
    """
    Useful for debugging: tells you whether private intelligence is loaded.
    """
    impl = orchestrator.__class__.__module__
    return {
        "orchestrator_module": impl,
        "private_intelligence_loaded": impl == "private_orchestrator",
    }
