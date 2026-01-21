import os
import requests

DATABRICKS_TOKEN = os.getenv("DATABRICKS_TOKEN")
DATABRICKS_URL = os.getenv("DATABRICKS_URL", "https://<your-workspace>.cloud.databricks.com")
DATABRICKS_JOBID = os.getenv("DATABRICKS_JOBID")    

def trigger_databricks_job(job_id):
    """Trigger Databricks job via REST API"""
    headers = {"Authorization": f"Bearer {DATABRICKS_TOKEN}"}
    response = requests.post(
        f"{DATABRICKS_URL}/api/2.1/jobs/run-now",
        headers=headers,
        json={"job_id": job_id}
    )
    if response.status_code == 200:
        print(f"🚀 Databricks job {job_id} triggered successfully.")
    else:
        print(f"❌ Failed to trigger job: {response.text}")

if __name__ == "__main__":
    trigger_databricks_job(DATABRICKS_JOBID)
