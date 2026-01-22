from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
import requests
import os

# -- DAG Metadata --
default_args = {
    'owner': 'iAssist',
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
}

def fetch_data_from_web():
    """🕸️ Pulls approved datasets (e.g. finance, health, market)"""
    print("🌐 Fetching approved open datasets...")
    # Example placeholder — in production use your approved APIs list
    datasets = [
        "https://datahub.io/core/finance-vix/r/vix-daily.csv",
        "https://datahub.io/core/co2-fossil-global/r/global.csv"
    ]
    for url in datasets:
        print(f"✅ Retrieved: {url}")
    return "Fetched all datasets."

def run_databricks_training():
    """🔥 Triggers Databricks job for model fine-tuning"""
    print("🚀 Launching Databricks job...")
    databricks_url = os.getenv("DATABRICKS_URL", "")
    databricks_token = os.getenv("DATABRICKS_TOKEN", "")
    job_id = os.getenv("DATABRICKS_JOBID", "")

    if not databricks_url or not databricks_token or not job_id:
        raise ValueError("Missing Databricks credentials or Job ID")

    headers = {"Authorization": f"Bearer {databricks_token}"}
    response = requests.post(f"{databricks_url}/api/2.1/jobs/run-now", headers=headers, json={"job_id": job_id})
    
    print("🧠 Training triggered, response:", response.text)
    return "Training triggered."

def log_training_result():
    """🧾 Log output to database or Airflow log"""
    print("📋 Training completed, results logged to DB (placeholder).")

# -- DAG Definition --
with DAG(
    'iassist_self_train',
    default_args=default_args,
    description='🤖 iAssist self-training orchestration DAG',
    schedule_interval=timedelta(hours=6),
    start_date=datetime(2026, 1, 21),
    catchup=False,
) as dag:

    task_fetch = PythonOperator(
        task_id='fetch_datasets',
        python_callable=fetch_data_from_web
    )

    task_train = PythonOperator(
        task_id='run_databricks_training',
        python_callable=run_databricks_training
    )

    task_log = PythonOperator(
        task_id='log_training_result',
        python_callable=log_training_result
    )

    task_fetch >> task_train >> task_log


