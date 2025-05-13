#!/bin/bash

# Production deployment script for Microservices Application
# This script assumes you have Docker and Docker Compose installed on your production server

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOCKER_HUB_USERNAME="your-dockerhub-username"  # Replace with your Docker Hub username
APP_DIR="/opt/microservices-app"  # Production directory

echo -e "${BLUE}===== Starting Microservices Application Deployment =====${NC}"

# Check Docker installation
if ! command -v docker &> /dev/null
then
    echo -e "${RED}Error: Docker is not installed${NC}"
    exit 1
fi

# Check Docker Compose installation
if ! command -v docker-compose &> /dev/null
then
    echo -e "${RED}Error: Docker Compose is not installed${NC}"
    exit 1
fi

# Create application directory if it doesn't exist
if [ ! -d "$APP_DIR" ]; then
    echo -e "${BLUE}Creating application directory: $APP_DIR${NC}"
    mkdir -p "$APP_DIR"
fi

# Create docker-compose.yml for production
echo -e "${BLUE}Creating docker-compose.yml for production${NC}"
cat > "$APP_DIR/docker-compose.yml" << EOL
version: '3.8'

services:
  # MongoDB service
  mongo:
    image: mongo:latest
    restart: always
    volumes:
      - mongo-data:/data/db
      - ./mongo-init:/docker-entrypoint-initdb.d
    networks:
      - backend-network
    environment:
      - MONGO_INITDB_ROOT_USERNAME=rayyan9477
      - MONGO_INITDB_ROOT_PASSWORD=Nobility@2025

  # Authentication Service
  auth-service:
    image: ${DOCKER_HUB_USERNAME}/microservices-auth:latest
    restart: always
    depends_on:
      - mongo
    environment:
      - PORT=3001
      - MONGODB_URI=mongodb://rayyan9477:Nobility%402025@mongo:27017/auth-service
      - JWT_SECRET=your_production_jwt_secret_key
      - TOKEN_EXPIRY=1d
    networks:
      - backend-network
    healthcheck:
      test: ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:3001/health"]
      interval: 10s
      timeout: 5s
      retries: 5

  # Todo Service
  todo-service:
    image: ${DOCKER_HUB_USERNAME}/microservices-todo:latest
    restart: always
    depends_on:
      - mongo
      - auth-service
    environment:
      - PORT=3002
      - MONGODB_URI=mongodb://rayyan9477:Nobility%402025@mongo:27017/todo-service
      - AUTH_SERVICE_URL=http://auth-service:3001
    networks:
      - backend-network
    healthcheck:
      test: ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:3002/health"]
      interval: 10s
      timeout: 5s
      retries: 5

  # Frontend App
  frontend:
    image: ${DOCKER_HUB_USERNAME}/microservices-frontend:latest
    restart: always
    networks:
      - frontend-network

  # Nginx Reverse Proxy
  nginx:
    image: ${DOCKER_HUB_USERNAME}/microservices-nginx:latest
    restart: always
    ports:
      - "80:80"  # Production uses standard HTTP port
    depends_on:
      - auth-service
      - todo-service
      - frontend
    networks:
      - frontend-network
      - backend-network

networks:
  backend-network:
    driver: bridge
  frontend-network:
    driver: bridge

volumes:
  mongo-data:
EOL

# Create mongo-init directory and initialization script
mkdir -p "$APP_DIR/mongo-init"
echo -e "${BLUE}Creating MongoDB initialization script${NC}"
cat > "$APP_DIR/mongo-init/init.js" << EOL
// This script creates the necessary databases and users
db = db.getSiblingDB('admin');

// Create admin user if it doesn't exist
if (db.getUser("admin") == null) {
  db.createUser({
    user: "admin",
    pwd: "admin_password",
    roles: [{ role: "userAdminAnyDatabase", db: "admin" }]
  });
}

// Auth service database
db = db.getSiblingDB('auth-service');
db.createUser({
  user: "auth_user",
  pwd: "auth_password",
  roles: [{ role: "readWrite", db: "auth-service" }]
});

// Todo service database
db = db.getSiblingDB('todo-service');
db.createUser({
  user: "todo_user",
  pwd: "todo_password",
  roles: [{ role: "readWrite", db: "todo-service" }]
});

// Create initial collections
db = db.getSiblingDB('auth-service');
db.createCollection('users');

db = db.getSiblingDB('todo-service');
db.createCollection('todos');
EOL

# Pull the latest images
echo -e "${BLUE}Pulling the latest Docker images${NC}"
docker pull ${DOCKER_HUB_USERNAME}/microservices-auth:latest
docker pull ${DOCKER_HUB_USERNAME}/microservices-todo:latest
docker pull ${DOCKER_HUB_USERNAME}/microservices-frontend:latest
docker pull ${DOCKER_HUB_USERNAME}/microservices-nginx:latest
docker pull mongo:latest

# Start the application
echo -e "${BLUE}Starting the application${NC}"
cd "$APP_DIR"
docker-compose down
docker-compose up -d

# Check if services are running
echo -e "${BLUE}Checking service health${NC}"
sleep 10
docker-compose ps

echo -e "${GREEN}Deployment completed successfully!${NC}"
echo -e "The application is now running at http://your-server-ip"
echo -e "For logs, run: cd $APP_DIR && docker-compose logs -f"
