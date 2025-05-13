# Troubleshooting Guide

This document provides solutions for common issues you might encounter when running the microservices application.

## General Issues

### Application doesn't start properly

**Problem:** One or more containers fail to start.

**Solution:**
1. Check Docker Compose logs:
   ```bash
   docker-compose logs
   ```
2. Check individual service logs:
   ```bash
   docker-compose logs auth-service
   docker-compose logs todo-service
   docker-compose logs frontend
   docker-compose logs nginx
   ```
3. Ensure all ports are available:
   ```bash
   sudo netstat -tulpn | grep 8080
   sudo netstat -tulpn | grep 27017
   ```

### Services can't connect to MongoDB

**Problem:** Auth or Todo services can't connect to MongoDB.

**Solution:**
1. Check MongoDB logs:
   ```bash
   docker-compose logs mongo
   ```
2. Verify MongoDB is running:
   ```bash
   docker-compose ps mongo
   ```
3. Check MongoDB connection string in the .env files.
4. Try to connect manually to MongoDB:
   ```bash
   docker-compose exec mongo mongo -u root -p example
   ```

## Service-Specific Issues

### Auth Service Issues

**Problem:** JWT token verification fails.

**Solution:**
1. Check if JWT_SECRET is consistent in the auth-service .env file.
2. Verify the token expiry time in the .env file.
3. Check auth service logs for more details:
   ```bash
   docker-compose logs auth-service
   ```

### Todo Service Issues

**Problem:** Todo service can't communicate with Auth service.

**Solution:**
1. Check if the auth service is running:
   ```bash
   docker-compose ps auth-service
   ```
2. Verify the AUTH_SERVICE_URL in the todo-service .env file.
3. Check network connectivity between services:
   ```bash
   docker-compose exec todo-service ping auth-service
   ```

### Frontend Issues

**Problem:** Frontend can't connect to the backend APIs.

**Solution:**
1. Check Nginx configuration:
   ```bash
   docker-compose exec nginx cat /etc/nginx/nginx.conf
   ```
2. Verify API endpoints in the frontend code:
   ```bash
   docker-compose exec frontend cat /usr/share/nginx/html/main.js | grep -i api_url
   ```
3. Test API endpoints directly:
   ```bash
   curl -v http://localhost:8080/api/auth/health
   curl -v http://localhost:8080/api/todos/health
   ```

## Nginx Issues

**Problem:** Nginx isn't properly routing requests to services.

**Solution:**
1. Check Nginx logs:
   ```bash
   docker-compose logs nginx
   ```
2. Verify Nginx configuration:
   ```bash
   docker-compose exec nginx nginx -t
   ```
3. Check if backend services are reachable from Nginx:
   ```bash
   docker-compose exec nginx ping auth-service
   docker-compose exec nginx ping todo-service
   docker-compose exec nginx ping frontend
   ```

## Docker Issues

**Problem:** Docker Compose can't build or run containers.

**Solution:**
1. Check Docker status:
   ```bash
   systemctl status docker
   ```
2. Try rebuilding images:
   ```bash
   docker-compose build --no-cache
   ```
3. Clean up Docker resources:
   ```bash
   docker system prune -a
   ```

## GitHub Actions Issues

**Problem:** GitHub Actions workflow fails.

**Solution:**
1. Check if Docker Hub credentials are properly set up in GitHub Secrets.
2. Verify that the Dockerfile paths in the workflow match the project structure.
3. Check if tests are running correctly by running them locally.

## Still Having Issues?

If you're still experiencing problems, try the following steps:

1. Stop all containers and remove volumes:
   ```bash
   docker-compose down -v
   ```
2. Rebuild and restart the application:
   ```bash
   docker-compose build --no-cache
   docker-compose up -d
   ```
3. Check logs for all services:
   ```bash
   docker-compose logs > app-logs.txt
   ```
4. Review the log file for detailed error messages.
