#!/bin/sh

set -e

echo "Waiting for database..."
docker exec backend sh -c "cd /app/backend && python app/backend_pre_start.py"

echo "Running Alembic migrations..."
docker exec backend sh -c "cd /app/backend && alembic upgrade head"

echo "Creating initial data..."
docker exec backend sh -c "cd /app/backend && python app/initial_data.py"

echo "Migration completed successfully."
