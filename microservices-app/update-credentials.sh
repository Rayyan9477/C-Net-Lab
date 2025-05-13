#!/bin/bash

# Credentials management script for Microservices Application
# This script updates credentials across all configuration files

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Default credentials (if not provided as arguments)
DEFAULT_USERNAME="rayyan9477"
DEFAULT_PASSWORD="Nobility@2025"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -u|--username)
      USERNAME="$2"
      shift 2
      ;;
    -p|--password)
      PASSWORD="$2"
      shift 2
      ;;
    -h|--help)
      echo "Usage: $0 [-u|--username USERNAME] [-p|--password PASSWORD]"
      echo "Updates MongoDB credentials across all configuration files"
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      echo "Usage: $0 [-u|--username USERNAME] [-p|--password PASSWORD]"
      exit 1
      ;;
  esac
done

# Set default values if not provided
USERNAME=${USERNAME:-$DEFAULT_USERNAME}
PASSWORD=${PASSWORD:-$DEFAULT_PASSWORD}

# URL-encode the password for MongoDB connection strings
# Replace @ with %40, $ with %24, etc.
URL_ENCODED_PASSWORD=$(echo "$PASSWORD" | sed 's/@/%40/g; s/\$/%24/g; s/&/%26/g; s/+/%2B/g; s/,/%2C/g; s/:/%3A/g; s/;/%3B/g; s/=/%3D/g; s/?/%3F/g; s/\ /%20/g')

echo -e "${BLUE}===== Updating Credentials =====${NC}"
echo "Username: $USERNAME"
echo "Password: [REDACTED]"
echo "URL-encoded password: [REDACTED]"

# Directory where the microservices app is located
APP_DIR="/workspaces/C-Net-Lab/microservices-app"

# Update docker-compose.yml
echo -e "${YELLOW}Updating docker-compose.yml...${NC}"
sed -i "s/MONGO_INITDB_ROOT_USERNAME=.*/MONGO_INITDB_ROOT_USERNAME=$USERNAME/g" "$APP_DIR/docker-compose.yml"
sed -i "s/MONGO_INITDB_ROOT_PASSWORD=.*/MONGO_INITDB_ROOT_PASSWORD=$PASSWORD/g" "$APP_DIR/docker-compose.yml"

# Update MongoDB init script
echo -e "${YELLOW}Updating MongoDB initialization script...${NC}"
sed -i "s/user: \"[^\"]*\",/user: \"$USERNAME\",/g" "$APP_DIR/mongo-init/init.js"
sed -i "s/pwd: \"[^\"]*\",/pwd: \"$PASSWORD\",/g" "$APP_DIR/mongo-init/init.js"

# Update auth service .env
echo -e "${YELLOW}Updating auth-service .env...${NC}"
sed -i "s|mongodb://[^:]*:[^@]*@|mongodb://$USERNAME:$URL_ENCODED_PASSWORD@|g" "$APP_DIR/auth-service/.env"

# Update todo service .env
echo -e "${YELLOW}Updating todo-service .env...${NC}"
sed -i "s|mongodb://[^:]*:[^@]*@|mongodb://$USERNAME:$URL_ENCODED_PASSWORD@|g" "$APP_DIR/todo-service/.env"

# Update deploy-production.sh
echo -e "${YELLOW}Updating deploy-production.sh...${NC}"
sed -i "s/MONGO_INITDB_ROOT_USERNAME=.*/MONGO_INITDB_ROOT_USERNAME=$USERNAME/g" "$APP_DIR/deploy-production.sh"
sed -i "s/MONGO_INITDB_ROOT_PASSWORD=.*/MONGO_INITDB_ROOT_PASSWORD=$PASSWORD/g" "$APP_DIR/deploy-production.sh"
sed -i "s|mongodb://[^:]*:[^@]*@mongo:27017/auth-service|mongodb://$USERNAME:$URL_ENCODED_PASSWORD@mongo:27017/auth-service|g" "$APP_DIR/deploy-production.sh"
sed -i "s|mongodb://[^:]*:[^@]*@mongo:27017/todo-service|mongodb://$USERNAME:$URL_ENCODED_PASSWORD@mongo:27017/todo-service|g" "$APP_DIR/deploy-production.sh"

echo -e "${GREEN}✅ Credentials successfully updated across all files!${NC}"
echo ""
echo "Files updated:"
echo "- docker-compose.yml"
echo "- mongo-init/init.js"
echo "- auth-service/.env"
echo "- todo-service/.env"
echo "- deploy-production.sh"
echo ""
echo "To apply these changes, restart the application:"
echo "  cd $APP_DIR"
echo "  docker-compose down"
echo "  docker-compose up -d"
