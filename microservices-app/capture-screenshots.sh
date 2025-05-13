#!/bin/bash

# Screenshot capture helper script for Microservices Application

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}===== Screenshot Capture Helper =====${NC}"
echo "This script will guide you through capturing the required screenshots for submission."
echo

# Check if screenshots directory exists
if [ ! -d "screenshots" ]; then
    mkdir -p screenshots
    echo "Created screenshots directory."
fi

echo -e "${BLUE}Required Screenshots:${NC}"
echo "1. Docker Compose Services"
echo "2. Application Homepage"
echo "3. Registration Page"
echo "4. Login Page"
echo "5. Todo List Page (after login)"
echo

echo -e "${BLUE}Step 1: Docker Compose Services${NC}"
echo "Run the following command and take a screenshot of its output:"
echo "  docker-compose ps"
echo "Save the screenshot as: screenshots/01-docker-compose-services.png"
echo "Press Enter when done..."
read

echo -e "${BLUE}Step 2: Application Homepage${NC}"
echo "Navigate to http://localhost:8080 in your browser"
echo "Take a screenshot of the homepage"
echo "Save the screenshot as: screenshots/02-homepage.png"
echo "Press Enter when done..."
read

echo -e "${BLUE}Step 3: Registration Page${NC}"
echo "Navigate to http://localhost:8080/register in your browser"
echo "Take a screenshot of the registration page"
echo "Save the screenshot as: screenshots/03-registration-page.png"
echo "Press Enter when done..."
read

echo -e "${BLUE}Step 4: Login Page${NC}"
echo "Navigate to http://localhost:8080/login in your browser"
echo "Take a screenshot of the login page"
echo "Save the screenshot as: screenshots/04-login-page.png"
echo "Press Enter when done..."
read

echo -e "${BLUE}Step 5: Todo List Page${NC}"
echo "Register a new account or log in with an existing account"
echo "Add at least 2-3 todo items with different statuses"
echo "Take a screenshot of the todo list page"
echo "Save the screenshot as: screenshots/05-todo-list.png"
echo "Press Enter when done..."
read

echo -e "${BLUE}Step 6: API Test Results${NC}"
echo "Run the API test script and take a screenshot of the results:"
echo "  ./test-api.sh"
echo "Save the screenshot as: screenshots/06-api-test-results.png"
echo "Press Enter when done..."
read

echo -e "${GREEN}All screenshots captured!${NC}"
echo "Please verify that all screenshots are saved in the screenshots directory:"
ls -la screenshots/
echo
echo "Make sure to include these screenshots in your final submission."
