from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta
import requests
import json
import psycopg2
import os

# --- DAG Setup ---
default_args = {
    'owner': 'iAssist',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'self_training_dag',
    default_args=default_args,
    description='Automated self-training pipeline for iAssist Agent',
    schedule_interval=timedelta(hours=6),
    start_date=datetime(2026, 1, 21),
    catchup=False,
)

# --- Task Functions ---

def collect_data():
    """Pull training data from trusted sources or Databricks."""
    print("📡 Collecting new training data...")
    response = requests.get("https://api.github.com/events")  # sample data source
    data = response.json()
    with open('/tmp/training_data.json', 'w') as f:
        json.dump(data, f)
    print("✅ Data collection complete.")

def preprocess_data():
    """Clean and prepare training data."""
    print("🧹 Preprocessing training data...")
    with open('/tmp/training_data.json', 'r') as f:
        data = json.load(f)
    cleaned = [d for d in data if 'type' in d]
    with open('/tmp/cleaned_data.json', 'w') as f:
        json.dump(cleaned, f)
    print("✅ Data preprocessing complete.")

def trigger_training():
    """Send training job to AI Core or Databricks."""
    print("🧠 Triggering training job...")
    try:
        response = requests.post("http://ai-core:5000/train", json={"data_path": "/tmp/cleaned_data.json"})
        print("Training response:", response.text)
    except Exception as e:
        print("Training failed:", e)

def log_results():
    """Log the retraining results into PostgreSQL."""
    print("🗄️ Logging results to database...")
    conn = psycopg2.connect(
        host="postgres",
        database=os.getenv("POSTGRES_DB", "iassist"),
        user=os.getenv("POSTGRES_USER", "admin"),
        password=os.getenv("POSTGRES_PASSWORD", "secret"),
    )
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO results (service, input_data, output_data) VALUES (%s, %s, %s)",
        ("self_training", "Auto-Retrain", "Success"),
    )
    conn.commit()
    cur.close()
    conn.close()
    print("✅ Training results logged.")

# --- Task Definitions ---
t1 = PythonOperator(task_id='collect_data', python_callable=collect_data, dag=dag)
t2 = PythonOperator(task_id='preprocess_data', python_callable=preprocess_data, dag=dag)
t3 = PythonOperator(task_id='trigger_training', python_callable=trigger_training, dag=dag)
t4 = PythonOperator(task_id='log_results', python_callable=log_results, dag=dag)

# --- DAG Sequence ---
t1 >> t2 >> t3 >> t4


