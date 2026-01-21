FROM python:3.11-slim

WORKDIR /app

# Copy everything inside ai-core/app into /app
COPY ./app /app
COPY requirements.txt /app/requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Make sure /app is on the Python module path
ENV PYTHONPATH=/app

EXPOSE 5000

# Run the FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
