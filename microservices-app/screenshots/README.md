# Screenshot Guide

This document describes the screenshots you need to take to demonstrate the functionality of your microservices application.

## 1. Docker Compose Services

Run the following command and take a screenshot of the output:
```
docker-compose ps
```

Save the screenshot as `screenshots/01-docker-compose-services.png`

## 2. Application Homepage

Visit http://localhost:8080 in your browser and take a screenshot of the homepage.

Save the screenshot as `screenshots/02-homepage.png`

## 3. Registration Page

Visit http://localhost:8080/register in your browser and take a screenshot of the registration page.

Save the screenshot as `screenshots/03-registration-page.png`

## 4. Login Page

Visit http://localhost:8080/login in your browser and take a screenshot of the login page.

Save the screenshot as `screenshots/04-login-page.png`

## 5. Todo List Page

After logging in, you'll be redirected to the Todo List page. Create a few todo items and take a screenshot.

Save the screenshot as `screenshots/05-todo-list.png`

## 6. API Test Results

Run the API test script and take a screenshot of the results:
```
./test-api.sh
```

Save the screenshot as `screenshots/06-api-test-results.png`

## Submission

Include these screenshots in your final submission along with your GitHub repository link, Docker Hub image links, and other required documentation.
