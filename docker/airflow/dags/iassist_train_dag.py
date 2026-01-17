from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    dag_id="iAssist_training_pipeline",
    start_date=datetime(2026, 1, 1),
    schedule="@daily",
    catchup=False
) as dag:

    etl_task = BashOperator(
        task_id="run_spark_etl",
        bash_command="spark-submit /app/pipelines/etl_job.py"
    )
