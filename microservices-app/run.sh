#!/bin/bash

echo "Building and starting microservices application..."

# Navigate to the project directory
cd /workspaces/C-Net-Lab/microservices-app

# Create screenshots directory if it doesn't exist
mkdir -p screenshots

# Build and start with Docker Compose
docker-compose down
docker-compose build
docker-compose up -d

# Check if services are running
echo "Waiting for services to start..."
sleep 15

echo "Checking service health..."
docker-compose ps

echo ""
echo "=========== Application URLs ==========="
echo "Application is running at http://localhost:8080"
echo "Auth service API: http://localhost:8080/api/auth"
echo "Todo service API: http://localhost:8080/api/todos"
echo ""
echo "=========== Screenshot Guide ==========="
echo "Please take screenshots of the following pages and save them to the 'screenshots' directory:"
echo ""
echo "1. Docker Compose Services (docker-compose ps)"
echo "2. Application Homepage (http://localhost:8080)"
echo "3. Registration Page (http://localhost:8080/register)"
echo "4. Login Page (http://localhost:8080/login)"
echo "5. Todo List Page (after login and adding some todos)"
echo ""
echo "=========== Testing Instructions ==========="
echo "1. Register a new user"
echo "2. Login with the registered user"
echo "3. Create some todo items"
echo "4. Update and delete todo items"
echo "5. Test the authentication by accessing the todo list page directly"
echo ""
echo "To shut down the application, run: docker-compose down"
