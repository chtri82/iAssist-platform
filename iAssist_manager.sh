#!/bin/bash
# ==========================================================
# iAssist Platform Management Script
# Author: Charlie Triantafilou
# Purpose: Automate setup, startup, rebuild, cleaning & logs
# ==========================================================

set -e

COMPOSE_FILE="docker-compose.yml"
CONFIG_FILE=".env"
HEALTH_TIMEOUT=60
LOG_DURATION=30  # seconds to stream logs after startup

# -------------------------------
# Helper functions
# -------------------------------
print_info() { echo -e "\033[1;34m[INFO]\033[0m $1"; }
print_success() { echo -e "\033[1;32m[SUCCESS]\033[0m $1"; }
print_warning() { echo -e "\033[1;33m[WARN]\033[0m $1"; }
print_error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; }

# -------------------------------
# Helper: Health check
# -------------------------------
check_health() {
  local name=$1
  local url=$2
  local timeout=$HEALTH_TIMEOUT
  local elapsed=0

  print_info "Checking health for $name at $url"

  until curl -fsS "$url" >/dev/null 2>&1; do
    if [ "$elapsed" -ge "$timeout" ]; then
      print_error "$name did not respond in $timeout seconds."
      return 1
    fi
    sleep 3
    elapsed=$((elapsed + 3))
    echo -n "."
  done

  print_success "$name is healthy ✅"
}

# -------------------------------
# Start iAssist Platform
# -------------------------------
start_iassist() {
  LOG_FLAG=$1
  print_info "Starting iAssist Platform..."
  docker compose --env-file "$CONFIG_FILE" up -d --build

  if [ "$LOG_FLAG" == "--logs" ]; then
    print_info "📜 Streaming container logs for ${LOG_DURATION}s..."
    docker compose logs -f &
    LOG_PID=$!
    sleep $LOG_DURATION
    kill $LOG_PID >/dev/null 2>&1 || true
    print_info "⏹️ Log streaming ended after ${LOG_DURATION}s."
  fi

  print_info "Running health checks..."
  check_health "🌐 API Gateway 🌐" "http://localhost:8080/swagger" || true
  check_health "AI Core" "http://localhost:5000/docs" || true
  check_health "R Analytics" "http://localhost:8000/__docs__" || true
  check_health "Airflow" "http://localhost:8081" || true

  print_success "✅ ✅ ✅ All reachable services started successfully! ✅ ✅ ✅"
}

# -------------------------------
# Stop iAssist Platform
# -------------------------------
stop_iassist() {
  print_info "Stopping all iAssist services..."
  docker compose down
  print_success "✅ iAssist Platform stopped cleanly."
}

# -------------------------------
# Rebuild iAssist Platform
# -------------------------------
rebuild_iassist() {
  print_info "Rebuilding all containers from scratch..."
  docker compose down -v
  docker compose build --no-cache
  docker compose up -d
  print_success "✅ ✅ Rebuild complete! Running health checks ✅ ✅"
  check_health "API Gateway" "http://localhost:8080/swagger" || true
}

# -------------------------------
# Status
# -------------------------------
status_iassist() {
  print_info "Checking container status..."
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

# -------------------------------
# Clean iAssist Platform (requires --force)
# -------------------------------
clean_iassist() {
  FORCE_FLAG=$1
  if [ "$FORCE_FLAG" != "--force" ]; then
    print_error "⚠️ ⚠️ ⚠️  You must confirm destructive actions with: ./iAssist_manager.sh clean --force ⚠️ ⚠️ ⚠️"
    echo "Example: ./iAssist_manager.sh clean --force"
    exit 1
  fi

  print_warning "⚠️ ⚠️ ⚠️  This will remove ALL containers, volumes, and networks related to iAssist! ⚠️ ⚠️ ⚠️ "
  read -p "Are you absolutely sure you want to continue? (y/N): " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    print_info "Stopping and removing all iAssist containers..."
    docker compose down -v --remove-orphans

    print_info "Removing iAssist-specific volumes..."
    docker volume rm $(docker volume ls -q --filter name=iassist) 2>/dev/null || true

    print_info "Pruning unused images and networks..."
    docker system prune -af --volumes

    print_success " Clean complete! iAssist environment fully reset."
  else
    print_info "Clean operation cancelled."
  fi
}

# -------------------------------
# CLI Commands
# -------------------------------
case "$1" in
  start)
    start_iassist "$2"
    ;;
  stop)
    stop_iassist
    ;;
  rebuild)
    rebuild_iassist
    ;;
  status)
    status_iassist
    ;;
  clean)
    clean_iassist "$2"
    ;;
  *)
    echo "Usage: ./iAssist_manager.sh {start [--logs]|stop|rebuild|status|clean [--force]}"
    ;;
esac
