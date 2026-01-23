#!/bin/bash
# ==========================================
# iAssist Platform Setup & Health Check Script
# Author: Charlie Triantafilou
# Purpose: Automate initial setup, build, startup & health checks
# ==========================================

set -e  # stop if any command fails

PROJECT_DIR="$(pwd)"
COMPOSE_FILE="$PROJECT_DIR/docker-compose.yml"
ENV_FILE="$PROJECT_DIR/.env"

echo "🧠 Starting iAssist Platform Setup..."
echo "Project Directory: $PROJECT_DIR"

# ------------------------------
# Check Dependencies
# ------------------------------
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker Desktop first."
    exit 1
fi

if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose not found. Please install Docker Compose v2+."
    exit 1
fi

# ------------------------------
# Ensure .env exists
# ------------------------------
if [ ! -f "$ENV_FILE" ]; then
    echo "⚠️  Missing .env file. Creating default one..."
    cat <<EOT > "$ENV_FILE"
# ======== Default .env ========
OPENAI_API_KEY=your_openai_api_key_here
POSTGRES_USER=admin
POSTGRES_PASSWORD=secret
POSTGRES_DB=iassist
AIRFLOW__CORE__FERNET_KEY=aiv0GNGpz5z8kBymrj1Pegp6hIGYdUtjzvTgLXPS4Ts=
EOT
    echo "✅ Default .env created. Please update it with your credentials."
fi

# ------------------------------
# Clean Previous Containers
# ------------------------------
echo "🧹 Cleaning up old containers..."
docker compose down --remove-orphans || true

# ------------------------------
# Build Services
# ------------------------------
echo "🔧 Building iAssist Platform..."
docker compose build --no-cache

# ------------------------------
# Start Containers
# ------------------------------
echo "🚀 Starting containers..."
docker compose up -d

# ------------------------------
# Wait for Services to be Healthy
# ------------------------------
check_service() {
    local url=$1
    local name=$2
    local retries=30
    local wait=5
    local count=0

    echo "⏳ ⏳ ⏳ Waiting for $name to become available at $url ⏳ ⏳ ⏳"

    until curl -s --head "$url" | grep "200 OK" > /dev/null; do
        ((count++))
        if [ "$count" -ge "$retries" ]; then
            echo "❌ ❌ ❌ $name did not become available in time. ❌ ❌ ❌"
            return 1
        fi
        echo "⏳ ⏳ ⏳ ... still waiting ($count/$retries) ⏳ ⏳ ⏳"
        sleep $wait
    done

    echo "✅ ✅ ✅ $name is up and running! ✅ ✅ ✅"
}

# Health checks for key endpoints
check_service "http://localhost:8080" "API Gateway"
check_service "http://localhost:8081" "Airflow Web UI"

# ------------------------------
# Display Running Containers
# ------------------------------
echo ""
echo "🔍 🔍 Checking running containers 🔍 🔍"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# ------------------------------
# Display Access Points
# ------------------------------
echo ""
echo "🌐 Access Points 🌐:"
echo "   - API Gateway:  http://localhost:8080"
echo "   - AI Core:      http://localhost:5000"
echo "   - R Analytics:  http://localhost:8000"
echo "   - Airflow UI:   http://localhost:8081"
echo ""
echo "🎉 iAssist Platform is now fully operational! 🎉"
echo "❌ ❌ ❌ Use Ctrl+C to stop the platform when needed. ❌ ❌ ❌"
