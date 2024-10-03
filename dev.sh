#!/bin/bash

# Set the Docker image name
IMAGE_NAME="gimgit/logos"

# Build the Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME:latest .

# Check if the image exists in the local Docker images
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
    echo "Image not found locally, pushing to Docker Hub..."
    docker push $IMAGE_NAME
else
    # Get the local image ID
    LOCAL_IMAGE_ID=$(docker images -q $IMAGE_NAME)

    # Get the remote image ID
    REMOTE_IMAGE_ID=$(docker inspect --format='{{.Id}}' $IMAGE_NAME 2> /dev/null)

    # Compare image IDs
    if [[ "$LOCAL_IMAGE_ID" != "$REMOTE_IMAGE_ID" ]]; then
        echo "Changes detected. Pushing the new image to Docker Hub..."
        docker push $IMAGE_NAME:latest
    else
        echo "No changes detected. Not pushing the image."
    fi
fi

# Apply Kubernetes manifests
echo "Applying Kubernetes manifests..."
kubectl apply -f storage.yaml
kubectl apply -f airflow-deployment.yaml

echo "Deployment complete!"

