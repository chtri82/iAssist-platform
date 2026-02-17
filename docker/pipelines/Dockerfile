FROM python:3.11-slim
WORKDIR /app

COPY docker/pipelines/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY docker/pipelines ./ 
COPY shared ./shared

CMD ["python", "etl_job.py"]
