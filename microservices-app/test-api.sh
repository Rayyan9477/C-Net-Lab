#!/bin/bash

# API Testing Script for Microservices Application

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Base URL
BASE_URL="http://localhost:8080"

# Variables to store data
AUTH_TOKEN=""
USER_ID=""
TODO_ID=""

# Function to print test step
print_step() {
  echo -e "\n${BLUE}=== $1 ===${NC}"
}

# Function to check API response
check_response() {
  if [[ $1 -ge 200 && $1 -lt 300 ]]; then
    echo -e "${GREEN}✓ Success: Status $1${NC}"
    return 0
  else
    echo -e "${RED}✗ Failed: Status $1${NC}"
    echo -e "${RED}Response: $2${NC}"
    return 1
  fi
}

# Test the Auth Service
print_step "Testing Auth Service - Registration"
REGISTER_RESPONSE=$(curl -s -X POST \
  "${BASE_URL}/api/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "password123"
  }')

REGISTER_STATUS=$?
if [[ $REGISTER_STATUS -eq 0 ]]; then
  echo -e "${GREEN}✓ Registration API is accessible${NC}"
else
  echo -e "${RED}✗ Registration API is not accessible${NC}"
fi

print_step "Testing Auth Service - Login"
LOGIN_RESPONSE=$(curl -s -X POST \
  "${BASE_URL}/api/auth/login" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "password": "password123"
  }')

LOGIN_STATUS=$?
if [[ $LOGIN_STATUS -eq 0 ]]; then
  echo -e "${GREEN}✓ Login API is accessible${NC}"
  # Extract token if login was successful
  AUTH_TOKEN=$(echo $LOGIN_RESPONSE | grep -o '"token":"[^"]*' | sed 's/"token":"//')
  if [[ ! -z "$AUTH_TOKEN" ]]; then
    echo -e "${GREEN}✓ Successfully retrieved auth token${NC}"
  else
    echo -e "${RED}✗ Could not retrieve auth token${NC}"
  fi
else
  echo -e "${RED}✗ Login API is not accessible${NC}"
fi

# Test the Todo Service (if we have a token)
if [[ ! -z "$AUTH_TOKEN" ]]; then
  print_step "Testing Todo Service - Create Todo"
  CREATE_TODO_RESPONSE=$(curl -s -X POST \
    "${BASE_URL}/api/todos" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${AUTH_TOKEN}" \
    -d '{
      "title": "Test Todo",
      "description": "This is a test todo item",
      "status": "pending"
    }')

  CREATE_TODO_STATUS=$?
  if [[ $CREATE_TODO_STATUS -eq 0 ]]; then
    echo -e "${GREEN}✓ Create Todo API is accessible${NC}"
    # Extract todo ID if creation was successful
    TODO_ID=$(echo $CREATE_TODO_RESPONSE | grep -o '"_id":"[^"]*' | sed 's/"_id":"//')
    if [[ ! -z "$TODO_ID" ]]; then
      echo -e "${GREEN}✓ Successfully created a todo item${NC}"
    else
      echo -e "${RED}✗ Could not create a todo item${NC}"
    fi
  else
    echo -e "${RED}✗ Create Todo API is not accessible${NC}"
  fi

  print_step "Testing Todo Service - Get All Todos"
  GET_TODOS_RESPONSE=$(curl -s -X GET \
    "${BASE_URL}/api/todos" \
    -H "Authorization: Bearer ${AUTH_TOKEN}")

  GET_TODOS_STATUS=$?
  if [[ $GET_TODOS_STATUS -eq 0 ]]; then
    echo -e "${GREEN}✓ Get Todos API is accessible${NC}"
  else
    echo -e "${RED}✗ Get Todos API is not accessible${NC}"
  fi

  # Only test update and delete if we have a todo ID
  if [[ ! -z "$TODO_ID" ]]; then
    print_step "Testing Todo Service - Update Todo"
    UPDATE_TODO_RESPONSE=$(curl -s -X PUT \
      "${BASE_URL}/api/todos/${TODO_ID}" \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer ${AUTH_TOKEN}" \
      -d '{
        "status": "in-progress"
      }')

    UPDATE_TODO_STATUS=$?
    if [[ $UPDATE_TODO_STATUS -eq 0 ]]; then
      echo -e "${GREEN}✓ Update Todo API is accessible${NC}"
    else
      echo -e "${RED}✗ Update Todo API is not accessible${NC}"
    fi

    print_step "Testing Todo Service - Delete Todo"
    DELETE_TODO_RESPONSE=$(curl -s -X DELETE \
      "${BASE_URL}/api/todos/${TODO_ID}" \
      -H "Authorization: Bearer ${AUTH_TOKEN}")

    DELETE_TODO_STATUS=$?
    if [[ $DELETE_TODO_STATUS -eq 0 ]]; then
      echo -e "${GREEN}✓ Delete Todo API is accessible${NC}"
    else
      echo -e "${RED}✗ Delete Todo API is not accessible${NC}"
    fi
  fi
else
  echo -e "${RED}✗ Skipping Todo tests - No auth token available${NC}"
fi

print_step "Testing Health Endpoints"
AUTH_HEALTH_RESPONSE=$(curl -s "${BASE_URL}/health/auth")
TODO_HEALTH_RESPONSE=$(curl -s "${BASE_URL}/health/todo")

AUTH_HEALTH_STATUS=$?
TODO_HEALTH_STATUS=$?

if [[ $AUTH_HEALTH_STATUS -eq 0 ]]; then
  echo -e "${GREEN}✓ Auth service health endpoint is accessible${NC}"
else
  echo -e "${RED}✗ Auth service health endpoint is not accessible${NC}"
fi

if [[ $TODO_HEALTH_STATUS -eq 0 ]]; then
  echo -e "${GREEN}✓ Todo service health endpoint is accessible${NC}"
else
  echo -e "${RED}✗ Todo service health endpoint is not accessible${NC}"
fi

print_step "Test Summary"
echo "Auth Service: Registration, Login"
echo "Todo Service: Create, Read, Update, Delete"
echo "Health Checks: Auth Service, Todo Service"
echo ""
echo "You can now access the application at ${BASE_URL} and test it manually."
