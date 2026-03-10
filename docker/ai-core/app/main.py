import importlib.util
import os
import uuid
from datetime import datetime, timezone
from typing import Type, Optional

import requests
from fastapi import FastAPI, Body, BackgroundTasks, Request

from shared.sources.approved_sources import load_approved_sources
from shared.config.settings import load_services_config
from app.tools import ToolRegistry
from app.public_tools import RForecastTool, RSummaryTool
from app.orchestrator import Orchestrator as PublicOrchestrator
from app.job_store_pg import PostgresJobStore
from app.model_loader import ModelManager

# ----------------------------
# App + Config
# ----------------------------
model_manager = ModelManager(model_name="transaction_category_model")
app = FastAPI(title="iAssist AI Core", version="1.0")

CONFIG = load_services_config()
R_CFG = CONFIG["services"]["r_analytics"]
R_BASE_URL = R_CFG["base_url"]

# ----------------------------
# Tool Registry
# ----------------------------
tools = ToolRegistry()
tools.register(RForecastTool(R_BASE_URL))
tools.register(RSummaryTool(R_BASE_URL))

# ----------------------------
# Job Store (Postgres)
# ----------------------------
job_store_pg = PostgresJobStore()

def now():
    return datetime.now(timezone.utc)

# ----------------------------
# Private orchestrator loader
# ----------------------------
def load_private_orchestrator_class() -> Optional[Type]:
    """
    Load private intelligence orchestrator if mounted.
    Returns None when not present or not loadable.
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

# ----------------------------
# Orchestrator init
# ----------------------------
PrivateOrchestrator = load_private_orchestrator_class()

approved_sources = load_approved_sources()

job = None  # optional; orchestrator can rely on context + job_store_pg

OrchestratorClass = PrivateOrchestrator or PublicOrchestrator
orchestrator = OrchestratorClass(
    tools=tools,
    job=job,
    job_store_pg=job_store_pg,
    approved_sources=approved_sources,
)

# Runtime guardrail
required_keys = {"type", "content", "metadata"}
test_response = orchestrator.process("healthcheck")
if not isinstance(test_response, dict) or not required_keys.issubset(test_response.keys()):
    raise RuntimeError("Loaded orchestrator does not conform to OrchestratorContract")

# ----------------------------
# Middleware: request id
# ----------------------------
@app.middleware("http")
async def add_request_id(request: Request, call_next):
    request_id = request.headers.get("x-request-id") or str(uuid.uuid4())
    request.state.request_id = request_id
    response = await call_next(request)
    response.headers["x-request-id"] = request_id
    return response

# ----------------------------
# Helpers: normalize DB row -> API job shape
# ----------------------------
def normalize_job_row(row: dict) -> dict:
    # PostgresJobStore returns dict-like row with these columns
    return {
        "job_id": str(row.get("job_id")),
        "status": row.get("status"),
        "created_at": row.get("created_at").isoformat() if row.get("created_at") else None,
        "started_at": row.get("started_at").isoformat() if row.get("started_at") else None,
        "finished_at": row.get("finished_at").isoformat() if row.get("finished_at") else None,
        "input": row.get("input_json"),
        "result": row.get("result_json"),
        "error": row.get("error_text"),
        "cancel_requested": bool(row.get("cancel_requested")),
    }

# ----------------------------
# Background job runner
# ----------------------------
def run_job(job_id: str, user_input: str):
    start = now()
    job_store_pg.add_event(job_id, "Job started")
    job_store_pg.update(job_id, status="running", started_at=now())

    # Cancel check before doing work
    row = job_store_pg.get(job_id)
    if row and row.get("cancel_requested"):
        job_store_pg.add_event(job_id, "Job cancelled before execution", level="warn")
        job_store_pg.update(job_id, status="cancelled", finished_at=now())
        return

    try:
        ctx = {
        "request_id": row.get("input_json", {}).get("request_id") if row else None,
        "job_id": job_id,
        }
        result = orchestrator.process(user_input, context=ctx)

        # Cancel check after execution (can't interrupt tool mid-flight yet)
        row = job_store_pg.get(job_id)
        if row and row.get("cancel_requested"):
            job_store_pg.add_event(job_id, "Job cancelled after execution", level="warn")
            job_store_pg.update(job_id, status="cancelled", finished_at=now())
            return

        job_store_pg.add_event(job_id, "Job succeeded", payload={"duration_s": (now() - start).total_seconds()})
        job_store_pg.update(job_id, status="succeeded", finished_at=now(), result_json=result)

    except Exception as e:
        job_store_pg.add_event(job_id, "Job failed", level="error",
                            payload={"error": str(e), "duration_s": (now() - start).total_seconds()})
        job_store_pg.update(job_id, status="failed", finished_at=now(), error_text=str(e))

# ----------------------------
# Routes
# ----------------------------
@app.get("/")
def root():
    return {"message": "iAssist AI Core operational"}

@app.get("/capabilities")
def capabilities():
    impl = orchestrator.__class__.__module__
    return {
        "orchestrator_module": impl,
        "private_intelligence_loaded": impl == "private_orchestrator",
        "public_tools": tools.list(),
    }

@app.get("/tools")
def list_tools():
    return {"tools": tools.list()}

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
async def handle_command(
    request: Request,
    background_tasks: BackgroundTasks,
    data: dict = Body(...),
):

    user_input = data.get("input", "")
    async_mode = bool(data.get("async", False))

    if not async_mode:
        ctx = {"request_id": getattr(request.state, "request_id", None), "job_id": None}
        resp = orchestrator.process(user_input, context=ctx)

        resp.setdefault("metadata", {})
        resp["metadata"]["request_id"] = getattr(request.state, "request_id", None)
        resp["metadata"]["mode"] = "sync"
        return resp

    job_id = str(uuid.uuid4())
    req_id = getattr(request.state, "request_id", None)
    job_store_pg.create(job_id, {"input": user_input, "request_id": req_id})
    job_store_pg.add_event(job_id, "Job queued")

    background_tasks.add_task(run_job, job_id, user_input)

    return {
        "type": "job",
        "content": {"job_id": job_id, "status": "queued"},
        "metadata": {
            "request_id": getattr(request.state, "request_id", None),
            "mode": "async",
        },
    }

@app.post("/predict")
def predict(data: dict = Body(...)):
    amount = float(data["amount"])
    pred = model_manager.predict(amount)
    return {
        "type": "json",
        "content": {"amount": amount, "predicted_category": pred},
        "metadata": model_manager.info(),
    }

@app.get("/jobs/{job_id}")
def get_job(job_id: str):
    row = job_store_pg.get(job_id)
    if not row:
        return {"ok": False, "error": "job_not_found", "job_id": job_id}
    return {"ok": True, "job": normalize_job_row(row)}

@app.get("/jobs")
def list_jobs(limit: int = 50):
    rows = job_store_pg.list_recent(limit=limit)
    return {"ok": True, "jobs": [normalize_job_row(r) for r in rows]}

@app.get("/jobs/{job_id}/events")
def job_events(job_id: str, limit: int = 200):
    row = job_store_pg.get(job_id)
    if not row:
        return {"ok": False, "error": "job_not_found", "job_id": job_id}
    ev = job_store_pg.list_events(job_id, limit=limit)
    # serialize datetimes
    for e in ev:
        if e.get("ts"):
            e["ts"] = e["ts"].isoformat()
    return {"ok": True, "job_id": job_id, "events": ev}

@app.post("/jobs/{job_id}/cancel")
def cancel_job(job_id: str):
    ok = job_store_pg.request_cancel(job_id)
    if not ok:
        return {"ok": False, "error": "job_not_found", "job_id": job_id}
    job_store_pg.add_event(job_id, "Cancel requested", level="warn")
    row = job_store_pg.get(job_id)
    return {"ok": True, "job": normalize_job_row(row) if row else None}

@app.post("/models/reload")
def reload_model():
    model_manager.load_active_model()
    return {"ok": True, "metadata": model_manager.info()}