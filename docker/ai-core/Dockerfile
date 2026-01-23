FROM python:3.14-64

WORKDIR /app

# Install system dependencies needed for psycopg2 and scientific libs
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app code last to take advantage of Docker layer caching
COPY app /app

# Default command
CMD ["python", "main.py"]
