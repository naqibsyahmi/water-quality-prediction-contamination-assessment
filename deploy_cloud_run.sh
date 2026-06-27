#!/bin/bash

set -e

PROJECT_ID="river-water-quality-prediction"
REGION="asia-southeast1"
REPO_NAME="river-water-quality-repo"
SERVICE_NAME="river-water-quality-api"
IMAGE_NAME="river-water-quality-api"

IMAGE_URI="$REGION-docker.pkg.dev/$PROJECT_ID/$REPO_NAME/$IMAGE_NAME:latest"

echo "Removing old local container if exists..."
docker stop river-water-quality-container 2>/dev/null || true
docker rm river-water-quality-container 2>/dev/null || true

echo "Building and pushing new Docker image to Artifact Registry..."
gcloud builds submit . \
  --config cloudbuild.yaml \
  --substitutions _IMAGE_URI="$IMAGE_URI"

echo "Redeploying Cloud Run with new image..."
gcloud run deploy "$SERVICE_NAME" \
  --image "$IMAGE_URI" \
  --region "$REGION" \
  --platform managed \
  --allow-unauthenticated

echo "Deployment completed successfully."