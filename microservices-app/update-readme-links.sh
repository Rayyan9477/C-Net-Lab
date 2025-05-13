#!/bin/bash

# Script to update README files with Docker Hub image links

# Set your Docker Hub username and GitHub repository URL
DOCKER_HUB_USERNAME="your-dockerhub-username"  # Replace with your actual username
GITHUB_REPO_URL="https://github.com/yourusername/C-Net-Lab"  # Replace with your actual GitHub repo URL

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}===== Updating README Files with Docker Hub Image Links =====${NC}"

# Navigate to project directory
cd /workspaces/C-Net-Lab

# Update main README.md
echo -e "${BLUE}Updating main README.md...${NC}"
sed -i "s|- **GitHub Repository**: \[Link to this repository\]|- **GitHub Repository**: [$GITHUB_REPO_URL]($GITHUB_REPO_URL)|g" README.md
sed -i "s|- Auth Service: \[Your Docker Hub Username\]/microservices-auth:latest|- Auth Service: [$DOCKER_HUB_USERNAME/microservices-auth:latest](https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-auth)|g" README.md
sed -i "s|- Todo Service: \[Your Docker Hub Username\]/microservices-todo:latest|- Todo Service: [$DOCKER_HUB_USERNAME/microservices-todo:latest](https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-todo)|g" README.md
sed -i "s|- Frontend: \[Your Docker Hub Username\]/microservices-frontend:latest|- Frontend: [$DOCKER_HUB_USERNAME/microservices-frontend:latest](https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-frontend)|g" README.md
sed -i "s|- Nginx: \[Your Docker Hub Username\]/microservices-nginx:latest|- Nginx: [$DOCKER_HUB_USERNAME/microservices-nginx:latest](https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-nginx)|g" README.md

# Update microservices-app README.md
echo -e "${BLUE}Updating microservices-app README.md...${NC}"
sed -i "s|- Auth Service: \[Docker Hub Link\]|- Auth Service: [https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-auth](https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-auth)|g" microservices-app/README.md
sed -i "s|- Todo Service: \[Docker Hub Link\]|- Todo Service: [https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-todo](https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-todo)|g" microservices-app/README.md
sed -i "s|- Frontend: \[Docker Hub Link\]|- Frontend: [https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-frontend](https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-frontend)|g" microservices-app/README.md
sed -i "s|- Nginx: \[Docker Hub Link\]|- Nginx: [https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-nginx](https://hub.docker.com/r/$DOCKER_HUB_USERNAME/microservices-nginx)|g" microservices-app/README.md

# Update all other files that need Docker Hub username
echo -e "${BLUE}Updating deploy-production.sh...${NC}"
sed -i "s/DOCKER_HUB_USERNAME=\"your-dockerhub-username\"/DOCKER_HUB_USERNAME=\"$DOCKER_HUB_USERNAME\"/g" microservices-app/deploy-production.sh

echo -e "${GREEN}Successfully updated README files and scripts with Docker Hub image links!${NC}"
echo ""
echo "Make sure to manually verify the updates and commit these changes to your repository."
