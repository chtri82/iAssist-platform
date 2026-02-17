FROM python:3.11-slim-bookworm

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc g++ gfortran \
    libpq-dev \
    libopenblas-dev liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

# Install deps
COPY docker/pipelines/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade pip setuptools wheel \
    && pip install --no-cache-dir -r /app/requirements.txt

# Copy pipelines code + shared module
COPY docker/pipelines /app
COPY shared /app/shared

# Make sure Python can import /app/shared
ENV PYTHONPATH=/app

CMD ["python", "etl_job.py"]
