FROM python:3.11-slim
WORKDIR /app

RUN apt-get update && apt-get install -y gcc libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY docker/ai-core/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY docker/ai-core/app ./app
COPY shared ./shared

# Ensure inports like 'import shared...' work everywhere
ENV PYTHONPATH=/app

EXPOSE 5000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "5000"]
