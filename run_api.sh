#!/bin/bash

# Configuration
PORT=8501

# Get Project Root Directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$SCRIPT_DIR"

echo "Project directory: $SCRIPT_DIR"

# Kill Existing Process Using Port
echo "Checking for existing processes on port ${PORT}..."
fuser -k ${PORT}/tcp 2>/dev/null

if [ ! -z "$PID" ]; then
    echo "Killing existing process: $PID"
    kill -9 $PID
fi

# Create venv if not exists

if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate venv
echo "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip

# Install requirements
echo "Installing requirements..."
pip install -r requirements.txt

# Start FastAPI Endpoint
echo "Starting FastAPI endpoint on port ${PORT}..."
cd src

uvicorn river_water_quality_predictor:app \
    --host 0.0.0.0 \
    --port ${PORT} \
    --reload