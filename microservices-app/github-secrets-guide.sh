#!/bin/bash

# GitHub Actions Secrets Setup Guide
# This script provides guidance on setting up GitHub Actions secrets

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}===== GitHub Actions Secrets Setup Guide =====${NC}"
echo ""
echo "To successfully run the GitHub Actions CI/CD workflow, you need to set up the following secrets in your GitHub repository:"
echo ""
echo -e "${YELLOW}1. DOCKER_HUB_USERNAME${NC}"
echo "   - Value: your Docker Hub username (e.g., rayyan9477)"
echo "   - This is used to push and tag Docker images"
echo ""
echo -e "${YELLOW}2. DOCKER_HUB_ACCESS_TOKEN${NC}"
echo "   - Value: a Docker Hub access token"
echo "   - You can create one at https://hub.docker.com/settings/security"
echo ""
echo -e "${YELLOW}3. MONGODB_USERNAME${NC}"
echo "   - Value: your MongoDB username (e.g., rayyan9477)"
echo ""
echo -e "${YELLOW}4. MONGODB_PASSWORD${NC}"
echo "   - Value: your MongoDB password (e.g., Nobility@2025)"
echo ""

echo -e "${BLUE}How to add these secrets to your GitHub repository:${NC}"
echo "1. Navigate to your GitHub repository"
echo "2. Click on 'Settings'"
echo "3. Click on 'Secrets and variables' in the sidebar"
echo "4. Select 'Actions'"
echo "5. Click on 'New repository secret'"
echo "6. Enter the secret name (e.g., DOCKER_HUB_USERNAME) and value"
echo "7. Click 'Add secret'"
echo "8. Repeat for each secret"
echo ""

echo -e "${GREEN}Once you've added these secrets, your GitHub Actions workflow will be able to:${NC}"
echo "- Build and test your microservices"
echo "- Authenticate with Docker Hub"
echo "- Push Docker images to your Docker Hub account"
echo "- Use your MongoDB credentials in the deployment"
echo ""

echo -e "${YELLOW}Remember: Never commit sensitive credentials directly in your code!${NC}"
