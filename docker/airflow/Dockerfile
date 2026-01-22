# ===============================
# Airflow Custom Image for iAssist
# ===============================
FROM apache/airflow:2.8.0-python3.8

# Switch to root to install extra packages
USER root

# Install useful libraries (for Postgres, API calls, ML)
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    git \
    python3-psycopg2 \
    && apt-get clean

# Switch back to the airflow user
USER airflow

# Copy DAGs, plugins, and dependencies into Airflow
COPY dags/ /opt/airflow/dags/
COPY plugins/ /opt/airflow/plugins/

# Optional: pre-install Python packages for Airflow DAGs
RUN pip install --no-cache-dir requests psycopg2-binary pandas SQLAlchemy

# Set the default command (Airflow webserver)
CMD ["standalone"]
