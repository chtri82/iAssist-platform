FROM python:3.11-slim

WORKDIR /app

# Copy pipeline code into container
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir pandas psycopg2-binary SQLAlchemy requests

CMD ["python", "etl_job.py"]
