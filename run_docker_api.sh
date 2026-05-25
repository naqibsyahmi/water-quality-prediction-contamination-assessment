#!/bin/bash

# Stop Existing Container

echo "Stopping existing container..."

docker stop river-water-quality-container 2>/dev/null
docker rm river-water-quality-container 2>/dev/null

# Run Docker Container
echo "Starting Docker container..."

docker run \
    --name river-water-quality-container \
    --env-file .env \
    -p 8501:8501 \
    river-water-quality-api