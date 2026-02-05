from fastapi import FastAPI, Body
import importlib.util, os

intelligence_path = "/app/intelligence/orchestrator.py"
if os.path.exists(intelligence_path):
    spec = importlib.util.spec_from_file_location("orchestrator", intelligence_path)
    orchestrator = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(orchestrator)
    print("[INFO] Loaded private intelligence orchestrator.")
else:
    from orchestrator_stub import Orchestrator
    print("[WARN] Using public orchestrator stub.")

# Initialize FastAPI app
app = FastAPI(title="iAssist AI Core", version="1.0")

# Initialize Orchestrator (the core brain)
orchestrator = Orchestrator()

@app.post("/command")
async def handle_command(data: dict = Body(...)):
    """
    Accepts a user command and returns orchestrated actions or insights.
    """
    user_input = data.get("input", "")
    response = orchestrator.process(user_input)
    return {"response": response}

@app.get("/")
def root():
    """
    Health check endpoint ensures AI Core is online.
    """
    return {"message": "iAssist AI Core operational"}

@app.get("/motivate")
def motivate():
    """
    Simple endpoint to test response generation.
    """
    return {"quote": "Winning is built one iteration at a time."}
