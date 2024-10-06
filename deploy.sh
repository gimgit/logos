#!/bin/bash

# Set the Docker image name
IMAGE_NAME="gimgit/logos"
USER_NAME=$(whoami)
ENV=${EXECUTION_ENV:-local}

echo "1️⃣ Define TAG by ENV"
if [ "$ENV" == "PROD" ]; then
  TAG="latest"
else
  TAG="dev_$USER_NAME"
fi

echo "2️⃣ Building Docker image... $IMAGE_NAME:$TAG"
docker build -t $IMAGE_NAME:$TAG .

if [ "$ENV" == "PROD" ]; then
  echo "Upload docker file into hub"
  docker push $IMAGE_NAME:$TAG
fi

# Apply Kubernetes manifests
echo "3️⃣ Applying Kubernetes manifests..."
kubectl apply -f namespace.yaml
kubectl apply -f storage.yaml
kubectl apply -f cluster.yaml
# kubectl apply -f airflow-deployment.yaml

echo "Deployment is complete, its Lucky Vicky 🍀"

# Build the Docker image



# EXIST_IMAGE_ID=$(docker images -q $IMAGE_NAME:$TAG)
# Get the new image ID after the build
# NEW_IMAGE_ID=$(docker images -q $IMAGE_NAME:$TAG)

# Debug: Print new image ID
# echo "New Image ID: $NEW_IMAGE_ID"
# echo "OLD Imgae ID: $EXIST_IMAGE_ID"
