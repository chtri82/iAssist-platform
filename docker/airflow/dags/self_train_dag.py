from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
import requests
import os
import psycopg2

# ===============================
# DAG CONFIGURATION
# ===============================
AI_CORE_URL = "http://ai-core:5000"
DATABRICKS_URL = os.getenv("DATABRICKS_URL", "")
DATABRICKS_TOKEN = os.getenv("DATABRICKS_TOKEN", "")
DATABRICKS_JOBID = os.getenv("DATABRICKS_JOBID", "")
POSTGRES_CONN = {
    "host": os.getenv("POSTGRES_HOST", "postgres"),
    "dbname": os.getenv("POSTGRES_DB", "iassist"),
    "user": os.getenv("POSTGRES_USER", "admin"),
    "password": os.getenv("POSTGRES_PASSWORD", "secret"),
    "port": 5432
}

# ===============================
# TASK FUNCTIONS
# ===============================
def log_event(service, message):
    """Log DAG event to Postgres results table"""
    conn = psycopg2.connect(**POSTGRES_CONN)
    cur = conn.cursor()
    cur.execute("""
        INSERT INTO results (service, input_data, output_data)
        VALUES (%s, %s, %s)
    """, ("airflow", service, message))
    conn.commit()
    cur.close()
    conn.close()

def extract_training_tasks(**kwargs):
    """Get pending training tasks from database"""
    conn = psycopg2.connect(**POSTGRES_CONN)
    cur = conn.cursor()
    cur.execute("SELECT id, input_data FROM results WHERE service = 'training' ORDER BY created_on DESC LIMIT 1;")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    if not rows:
        log_event("extract_training_tasks", "No pending training tasks found.")
        return None
    log_event("extract_training_tasks", f"Retrieved {len(rows)} training tasks.")
    return rows[0]

def local_pretrain(**context):
    """Call AI Core to perform light preprocessing or simulation"""
    task = context["ti"].xcom_pull(task_ids="extract_training_tasks")
    if not task:
        return "No local pretraining required."
    
    input_data = task[1]
    try:
        res = requests.post(f"{AI_CORE_URL}/train", json={"data": input_data}, timeout=20)
        log_event("local_pretrain", f"AI Core response: {res.text}")
        return res.text
    except Exception as e:
        log_event("local_pretrain", f"Error contacting AI Core: {e}")
        return f"Error contacting AI Core: {e}"

def trigger_databricks_training(**context):
    """Trigger Databricks job for distributed agent retraining"""
    headers = {"Authorization": f"Bearer {DATABRICKS_TOKEN}"}
    payload = {"job_id": DATABRICKS_JOBID}
    try:
        response = requests.post(f"{DATABRICKS_URL}/api/2.1/jobs/run-now", headers=headers, json=payload)
        if response.status_code == 200:
            log_event("databricks_trigger", f"Triggered Databricks job {DATABRICKS_JOBID}.")
        else:
            log_event("databricks_trigger", f"Databricks job failed: {response.text}")
    except Exception as e:
        log_event("databricks_trigger", f"Databricks trigger error: {e}")

def finalize_training(**kwargs):
    """Training cycle as complete"""
    log_event("finalize_training", "✅ Training cycle completed successfully.")
    return "Training complete."

# ===============================
# DAG DEFINITION
# ===============================
default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    dag_id="self_train_dag",
    default_args=default_args,
    description="Self-training orchestration between AI Core and Databricks",
    schedule_interval="0 0 * * *",  # runs daily at midnight
    start_date=datetime(2026, 1, 21),
    catchup=False,
    tags=["self-train", "iAssist", "hybrid"],
) as dag:

    t1 = PythonOperator(
        task_id="extract_training_tasks",
        python_callable=extract_training_tasks,
    )

    t2 = PythonOperator(
        task_id="local_pretrain",
        python_callable=local_pretrain,
        provide_context=True,
    )

    t3 = PythonOperator(
        task_id="trigger_databricks_training",
        python_callable=trigger_databricks_training,
    )

    t4 = PythonOperator(
        task_id="finalize_training",
        python_callable=finalize_training,
    )

    t1 >> t2 >> t3 >> t4