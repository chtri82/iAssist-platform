from fastapi import FastAPI

app = FastAPI(title="iAssist AI Core", version="1.0")

@app.get("/")
def root():
    return {"message": "iAssist AI Core operational"}

@app.get("/motivate")
def motivate():
    return {"quote": "Success is built one system at a time."}
