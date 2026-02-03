from fastapi import FastAPI, Body

## Check for iAssist intelligence repo (PRIVATE) to build and run iAssist Platform
try:
    from intelligence.orchestrator import Orchestrator  # Private repo
except ImportError:
    from orchestrator import Orchestrator  # Public stub


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
