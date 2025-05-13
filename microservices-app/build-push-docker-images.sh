#!/bin/bash

# Script to build and push Docker images to Docker Hub

# Set your Docker Hub username
DOCKER_HUB_USERNAME="your-dockerhub-username"  # Replace with your actual username

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}===== Building and Pushing Docker Images to Docker Hub =====${NC}"

# Check if logged in to Docker Hub
echo -e "${BLUE}Checking Docker Hub login status...${NC}"
if ! docker info | grep -q "Username: $DOCKER_HUB_USERNAME"; then
  echo -e "${RED}Error: Not logged in to Docker Hub or username doesn't match${NC}"
  echo "Please run 'docker login' first and ensure you're using the correct username"
  exit 1
fi

# Navigate to project directory
cd /workspaces/C-Net-Lab/microservices-app

# Build and push Auth Service
echo -e "${BLUE}Building and pushing Auth Service...${NC}"
docker build -t $DOCKER_HUB_USERNAME/microservices-auth:latest ./auth-service
docker push $DOCKER_HUB_USERNAME/microservices-auth:latest

# Build and push Todo Service
echo -e "${BLUE}Building and pushing Todo Service...${NC}"
docker build -t $DOCKER_HUB_USERNAME/microservices-todo:latest ./todo-service
docker push $DOCKER_HUB_USERNAME/microservices-todo:latest

# Build and push Frontend
echo -e "${BLUE}Building and pushing Frontend...${NC}"
docker build -t $DOCKER_HUB_USERNAME/microservices-frontend:latest ./frontend
docker push $DOCKER_HUB_USERNAME/microservices-frontend:latest

# Build and push Nginx
echo -e "${BLUE}Building and pushing Nginx...${NC}"
docker build -t $DOCKER_HUB_USERNAME/microservices-nginx:latest ./nginx
docker push $DOCKER_HUB_USERNAME/microservices-nginx:latest

echo -e "${GREEN}All images have been successfully built and pushed to Docker Hub!${NC}"
echo ""
echo "Your Docker Hub image URLs:"
echo "- Auth Service:   https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-auth"
echo "- Todo Service:   https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-todo"
echo "- Frontend:       https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-frontend"
echo "- Nginx:          https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-nginx"
echo ""
echo "Now, update the README.md files with these image links."
