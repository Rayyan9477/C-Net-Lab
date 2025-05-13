# Microservices Application

A production-grade microservices application built with Node.js, React, and Docker.

## Architecture

This application consists of the following components:

1. **Auth Service**: Handles user authentication and authorization with JWT
2. **Todo Service**: Manages todo items with CRUD operations
3. **Frontend**: React-based user interface
4. **Nginx**: Reverse proxy routing requests to appropriate services
5. **MongoDB**: Database for storing user and todo data

## Features

- User registration and authentication
- JWT token-based authorization
- Todo item creation, reading, updating, and deletion
- Docker containerization
- Nginx reverse proxy with security headers
- CI/CD pipeline with GitHub Actions
- Health checks for all services

## Technologies Used

- **Backend**: Node.js, Express.js, MongoDB, Mongoose
- **Frontend**: React, React Router, Bootstrap, Axios
- **DevOps**: Docker, Docker Compose, Nginx, GitHub Actions

## Prerequisites

- Docker and Docker Compose
- Node.js and npm (for local development)
- Git

## Getting Started

### Running with Docker Compose

```bash
# Clone the repository
git clone <repository-url>
cd microservices-app

# Start the application
docker-compose up -d

# The application will be available at http://localhost:8080
```

### Local Development

Each service can be run independently for development:

**Auth Service**:
```bash
cd auth-service
npm install
npm run dev
```

**Todo Service**:
```bash
cd todo-service
npm install
npm run dev
```

**Frontend**:
```bash
cd frontend
npm install
npm start
```

## API Documentation

### Auth Service (http://localhost:8080/api/auth)

- `POST /api/auth/register` - Register a new user
- `POST /api/auth/login` - Login and get JWT token
- `GET /api/auth/profile` - Get user profile (requires authentication)
- `POST /api/auth/verify` - Verify JWT token

### Todo Service (http://localhost:8080/api/todos)

- `GET /api/todos` - Get all todos for the authenticated user
- `GET /api/todos/:id` - Get a specific todo
- `POST /api/todos` - Create a new todo
- `PUT /api/todos/:id` - Update a todo
- `DELETE /api/todos/:id` - Delete a todo

## Environment Variables

### Auth Service
- `PORT` - Server port (default: 3001)
- `MONGODB_URI` - MongoDB connection string
- `JWT_SECRET` - Secret key for JWT signing
- `TOKEN_EXPIRY` - JWT token expiry (e.g., "1d")

### Todo Service
- `PORT` - Server port (default: 3002)
- `MONGODB_URI` - MongoDB connection string
- `AUTH_SERVICE_URL` - URL for the auth service

## Docker Hub Images

- Auth Service: [Docker Hub Link]
- Todo Service: [Docker Hub Link]
- Frontend: [Docker Hub Link]
- Nginx: [Docker Hub Link]

## CI/CD Pipeline

The GitHub Actions workflow performs the following actions:
1. Runs tests for all services
2. Builds Docker images
3. Pushes images to Docker Hub

## Security Considerations

- CORS protection
- JWT authentication
- Rate limiting
- Security headers (XSS, CSRF protection)
- Container security best practices

## Screenshots

### Homepage
![Homepage](screenshots/homepage.png)

### Login Page
![Login](screenshots/login.png)

### Todo List
![Todos](screenshots/todo-list.png)

## License

MIT
