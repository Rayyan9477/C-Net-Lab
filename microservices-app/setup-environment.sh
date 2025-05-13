#!/bin/bash

# Environment Setup Script for Microservices Application
# This script helps users set up their environment for the application

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}===== Environment Setup for Microservices Application =====${NC}"
echo ""
echo "This script will help you set up your environment variables for the microservices application."
echo ""

# Check for Docker and Docker Compose
echo -e "${YELLOW}Checking for Docker...${NC}"
if ! command -v docker &> /dev/null; then
  echo "Docker is not installed. Please install Docker first:"
  echo "https://docs.docker.com/get-docker/"
  exit 1
else
  docker_version=$(docker --version)
  echo -e "${GREEN}✅ Docker is installed: $docker_version${NC}"
fi

echo -e "${YELLOW}Checking for Docker Compose...${NC}"
if ! command -v docker-compose &> /dev/null; then
  echo "Docker Compose is not installed. Please install Docker Compose first:"
  echo "https://docs.docker.com/compose/install/"
  exit 1
else
  compose_version=$(docker-compose --version)
  echo -e "${GREEN}✅ Docker Compose is installed: $compose_version${NC}"
fi

echo ""
echo -e "${BLUE}MongoDB Credentials${NC}"
echo "Current MongoDB credentials are:"
echo "  Username: rayyan9477"
echo "  Password: Nobility@2025"
echo ""
echo -e "${YELLOW}Do you want to change these credentials? (y/n)${NC}"
read change_credentials

if [[ "$change_credentials" == "y" || "$change_credentials" == "Y" ]]; then
  echo "Please enter a new MongoDB username (leave blank to keep current):"
  read new_username
  
  echo "Please enter a new MongoDB password (leave blank to keep current):"
  read -s new_password
  echo ""
  
  if [[ ! -z "$new_username" || ! -z "$new_password" ]]; then
    # Build args
    args=""
    if [[ ! -z "$new_username" ]]; then
      args="$args -u $new_username"
    fi
    if [[ ! -z "$new_password" ]]; then
      args="$args -p $new_password"
    fi
    
    # Update credentials
    echo -e "${YELLOW}Updating credentials...${NC}"
    ./update-credentials.sh $args
    echo -e "${GREEN}✅ Credentials updated${NC}"
  else
    echo "No changes made to credentials."
  fi
fi

echo ""
echo -e "${BLUE}Docker Hub Configuration${NC}"
echo "For CI/CD to work, you need a Docker Hub account."
echo -e "${YELLOW}Do you want to test Docker Hub authentication now? (y/n)${NC}"
read test_docker_hub

if [[ "$test_docker_hub" == "y" || "$test_docker_hub" == "Y" ]]; then
  echo "Please enter your Docker Hub username:"
  read docker_username
  
  if [[ ! -z "$docker_username" ]]; then
    echo "Testing Docker Hub login..."
    docker login -u $docker_username
    login_status=$?
    
    if [ $login_status -eq 0 ]; then
      echo -e "${GREEN}✅ Docker Hub login successful${NC}"
      
      # Update Docker Hub username in scripts
      echo -e "${YELLOW}Updating Docker Hub username in scripts...${NC}"
      sed -i "s/DOCKER_HUB_USERNAME=\"your-dockerhub-username\"/DOCKER_HUB_USERNAME=\"$docker_username\"/g" build-push-docker-images.sh
      sed -i "s/DOCKER_HUB_USERNAME=\"your-dockerhub-username\"/DOCKER_HUB_USERNAME=\"$docker_username\"/g" update-readme-links.sh
      sed -i "s/DOCKER_HUB_USERNAME=\"your-dockerhub-username\"/DOCKER_HUB_USERNAME=\"$docker_username\"/g" deploy-production.sh
      echo -e "${GREEN}✅ Docker Hub username updated in scripts${NC}"
      
      # Ask about GitHub repository
      echo ""
      echo "Please enter your GitHub repository URL (e.g., https://github.com/username/C-Net-Lab):"
      read github_repo_url
      
      if [[ ! -z "$github_repo_url" ]]; then
        echo -e "${YELLOW}Updating GitHub repository URL in scripts...${NC}"
        sed -i "s|GITHUB_REPO_URL=\"https://github.com/yourusername/C-Net-Lab\"|GITHUB_REPO_URL=\"$github_repo_url\"|g" update-readme-links.sh
        echo -e "${GREEN}✅ GitHub repository URL updated in scripts${NC}"
      fi
    else
      echo -e "${RED}❌ Docker Hub login failed. Please check your credentials.${NC}"
    fi
  fi
fi

echo ""
echo -e "${BLUE}GitHub Actions Secrets${NC}"
echo "For GitHub Actions CI/CD to work, you need to set up secrets in your GitHub repository."
echo -e "${YELLOW}Would you like to see the guide for setting up GitHub Actions secrets? (y/n)${NC}"
read show_secrets_guide

if [[ "$show_secrets_guide" == "y" || "$show_secrets_guide" == "Y" ]]; then
  ./github-secrets-guide.sh
fi

echo ""
echo -e "${GREEN}===== Environment Setup Complete! =====${NC}"
echo "You're now ready to run the microservices application."
echo "To start the application, run:"
echo "  ./run.sh"
