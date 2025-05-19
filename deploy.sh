#!/bin/bash

# Exit on any error
set -e

# Variables
DOCKER_USERNAME="krtech26"
REPO_NAME="react-site-app"
IMAGE_TAG="prod"
CONTAINER_NAME="react-site-container"
PORT=8081

IMAGE_NAME="$DOCKER_USERNAME/$REPO_NAME:$IMAGE_TAG"


echo "Stopping existing container if it exists..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "Pulling image $IMAGE_NAME"
docker pull $IMAGE_NAME

echo "Starting new container..."
docker run -d --name $CONTAINER_NAME -p $PORT:80 $IMAGE_NAME

echo "Deployment complete ! App running at: http://localhost:$PORT"
