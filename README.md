# MEAN Stack CRUD Application - Tutorials Management System

A containerized MEAN (MongoDB, Express, Angular, Node.js) stack application for managing tutorials with complete CRUD operations. This project was developed as part of an internship assessment.

## Project Overview

This project is a full-stack CRUD (Create, Read, Update, Delete) application for managing tutorials, built with the MEAN stack:

- **MongoDB**: NoSQL database for storing tutorial data
- **Express.js**: Backend web application framework handling API requests
- **Angular 15**: Frontend framework providing an interactive user interface
- **Node.js**: JavaScript runtime environment for the backend server

The application is containerized using Docker and Nginx as a reverse proxy, making it easy to deploy and scale.

### Features

- Create, retrieve, update, and delete tutorials
- Mark tutorials as published/unpublished
- Filter tutorials by title
- View all published tutorials
- Responsive user interface

### Architecture

```
+-------------------+     +-------------------+     +-------------------+
|                   |     |                   |     |                   |
|   Angular Frontend|---->|   Express Backend |---->|   MongoDB         |
|                   |     |                   |     |                   |
+-------------------+     +-------------------+     +-------------------+
         ^                         ^                         ^
         |                         |                         |
         |                         |                         |
+---------------------------------------------------------------------------------------------------+
|                                      Docker Containers                                            |
+---------------------------------------------------------------------------------------------------+
         ^
         |
+---------------------------------------------------------------------------------------------------+
|                                      Nginx Reverse Proxy                                          |
+---------------------------------------------------------------------------------------------------+
```

### Component Details

#### Frontend (Angular 15)
- **Container Name**: frontend
- **Port**: 80 (via Nginx)
- **Key Components**:
  - Tutorial list component
  - Tutorial details component
  - Add tutorial component
  - Tutorial service for API communication

#### Backend (Node.js & Express)
- **Container Name**: backend
- **Port**: 8080
- **Key Components**:
  - RESTful API endpoints
  - MongoDB connection management
  - Controller logic for CRUD operations
  - Data models and validation

#### Database (MongoDB)
- **Container Name**: mongo
- **Port**: 27017
- **Database Name**: dd_db
- **Collection**: tutorials

#### Reverse Proxy (Nginx)
- **Container Name**: nginx
- **Port**: 80 -> 8080 (API), 80 (Frontend)
- **Purpose**: Route traffic between frontend and backend services

## Local Development Setup

### Prerequisites

- Node.js (v18 or higher)
- npm (v8 or higher)
- MongoDB (v6.0 or higher)
- Angular CLI (v15)

### Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Create a `.env` file with the following variables:
   ```
   MONGODB_URI=mongodb://localhost:27017/dd_db
   PORT=8080
   ```

4. Start the backend server:
   ```bash
   npm start
   ```

### Frontend Setup

1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   ng serve
   ```

4. Access the application at `http://localhost:4200`

## Docker Deployment

### Prerequisites

- Docker (v20 or higher)
- Docker Compose (v2 or higher)

### Docker Configuration

The application uses a multi-container setup defined in `docker-compose.yml`:

| Service  | Image                | Description                       | Ports       |
|----------|----------------------|-----------------------------------|-------------|
| frontend | Custom Angular build | Serves the Angular frontend       | 80 (internal) |
| backend  | Custom Node.js build | Provides the RESTful API          | 8080        |
| mongo    | mongo:latest         | MongoDB database                  | 27017       |
| nginx    | Custom Nginx config  | Reverse proxy for routing traffic | 80:80       |

### Using Docker Compose

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd crud-dd-task-mean-app
   ```

2. Build and start the containers:
   ```bash
   docker-compose up -d
   ```

3. Access the application at `http://localhost`

### Docker Images

| Image           | Version | Size    | Description                         |
|-----------------|---------|---------|-------------------------------------|
| frontend        | latest  | ~25MB   | Angular application                 |
| backend         | latest  | ~150MB  | Node.js API server                  |
| mongo           | latest  | ~700MB  | MongoDB database                    |
| nginx           | latest  | ~20MB   | Nginx reverse proxy                 |

### Individual Container Setup

Build and run each container separately:

**Backend:**
```bash
cd backend
docker build -t mean-crud-app-backend .
docker run -p 8080:8080 --env-file .env mean-crud-app-backend
```

**Frontend:**
```bash
cd frontend
docker build -t mean-crud-app-frontend .
docker run -p 4200:80 mean-crud-app-frontend
```

## API Documentation

The backend provides the following RESTful API endpoints:

| Method | Endpoint                | Description                      | Request Body                                                | Response                              |
|--------|-------------------------|----------------------------------|-------------------------------------------------------------|---------------------------------------|
| GET    | /api/tutorials          | Get all tutorials               | -                                                           | Array of tutorial objects             |
| GET    | /api/tutorials/:id      | Get a single tutorial by ID     | -                                                           | Tutorial object                       |
| GET    | /api/tutorials/published| Get all published tutorials     | -                                                           | Array of published tutorial objects   |
| POST   | /api/tutorials          | Create a new tutorial           | `{title: string, description: string, published: boolean}`  | Created tutorial object               |
| PUT    | /api/tutorials/:id      | Update a tutorial               | `{title: string, description: string, published: boolean}`  | Updated tutorial object               |
| DELETE | /api/tutorials/:id      | Delete a tutorial               | -                                                           | Success message                       |
| DELETE | /api/tutorials          | Delete all tutorials            | -                                                           | Success message                       |

### Example API Usage

**Creating a tutorial:**
```bash
curl -X POST -H "Content-Type: application/json" -d '{"title":"Angular Basics","description":"Learn the basics of Angular 15","published":false}' http://localhost:8080/api/tutorials
```

**Retrieving all tutorials:**
```bash
curl http://localhost:8080/api/tutorials
```

**Updating a tutorial:**
```bash
curl -X PUT -H "Content-Type: application/json" -d '{"title":"Angular Basics","description":"Learn the basics of Angular 15","published":true}' http://localhost:8080/api/tutorials/60c72b2f7c213e0012345678
```

## CI/CD Pipeline Setup

The application includes GitHub Actions workflow for continuous integration and deployment.

### Required Secrets

Set up the following secrets in your GitHub repository:

- `DOCKERHUB_USERNAME`: Your Docker Hub username
- `DOCKERHUB_TOKEN`: Your Docker Hub access token
- `SSH_HOST`: The IP address or hostname of your VM
- `SSH_USERNAME`: SSH username for your VM
- `SSH_PRIVATE_KEY`: SSH private key for authentication

### VM Setup

1. Run the VM setup script to prepare your Ubuntu server:
   ```bash
   chmod +x scripts/setup-vm.sh
   ./scripts/setup-vm.sh
   ```

2. The script will:
   - Update the system
   - Install Docker and Docker Compose
   - Configure firewall rules
   - Set up application directories
   - Initialize environment variables

### CI/CD Workflow

The CI/CD workflow consists of three main stages:

1. **Build and Test**: Builds and tests both frontend and backend applications
2. **Build and Push Docker**: Builds Docker images and pushes them to Docker Hub
3. **Deploy**: Deploys the application to your VM

## Environment Variables

### Backend Environment Variables

| Variable     | Description                   | Default Value                    |
|--------------|-------------------------------|----------------------------------|
| MONGODB_URI  | MongoDB connection string     | mongodb://mongo:27017/dd_db      |
| PORT         | Backend server port           | 8080                             |
| NODE_ENV     | Node.js environment           | production                       |

### CI/CD Environment Variables

| Variable            | Description                   | Where to Set                    |
|---------------------|-------------------------------|----------------------------------|
| DOCKERHUB_USERNAME  | Docker Hub username           | GitHub Secrets                   |
| DOCKERHUB_TOKEN     | Docker Hub access token       | GitHub Secrets                   |
| SSH_HOST            | VM IP address or hostname     | GitHub Secrets                   |
| SSH_USERNAME        | SSH username for VM           | GitHub Secrets                   |
| SSH_PRIVATE_KEY     | SSH private key for VM access | GitHub Secrets                   |

## Troubleshooting

### Docker Issues

1. **Container not starting**:
   - Check container logs: `docker logs <container-id>`
   - Verify environment variables are set correctly
   - Check for port conflicts: `netstat -tuln`

2. **MongoDB connection issues**:
   - Check if MongoDB container is running: `docker ps`
   - Verify the connection string in environment variables
   - Check network connectivity between containers

### CI/CD Issues

1. **GitHub Actions workflow failing**:
   - Check workflow run logs in GitHub Actions tab
   - Verify that all required secrets are set correctly
   - Ensure Docker Hub credentials are valid

2. **Deployment failing**:
   - Check SSH connectivity to your VM
   - Verify that the VM has Docker and Docker Compose installed
   - Check disk space on the VM: `df -h`

### Application Issues

1. **Frontend not loading**:
   - Check browser console for errors
   - Verify that the Nginx configuration is correct
   - Check if the frontend container is running

2. **Backend API errors**:
   - Check backend logs: `docker logs backend`
   - Verify MongoDB connection
   - Check for server errors in the logs

## Documentation & Screenshots

### Project Documentation

Documentation for this project is organized as follows:

| Directory                    | Description                                             |
|------------------------------|---------------------------------------------------------|
| `/screenshots/docker/`       | Docker configuration and container evidence             |
| `/screenshots/backend/`      | Backend API functionality and database connection       |
| `/screenshots/frontend/`     | Frontend UI and interaction with backend               |
| `/screenshots/nginx/`        | Nginx configuration and routing evidence                |

### Screenshots

#### Docker Configuration
![Docker Containers](screenshots/docker/containers.png)
*Screenshot showing all running Docker containers*

![Docker Images](screenshots/docker/images.png)
*Screenshot showing all Docker images*

#### Backend API
![Backend API Response](screenshots/backend/api_response.png)
*Screenshot showing successful API response*

![Database Connection](screenshots/backend/db_connection.png)
*Screenshot showing successful MongoDB connection*

#### Frontend Application
![Tutorials List](screenshots/frontend/tutorials_list.png)
*Screenshot showing the tutorials list page*

![Add Tutorial](screenshots/frontend/add_tutorial.png)
*Screenshot showing the add tutorial form*

![Edit Tutorial](screenshots/frontend/edit_tutorial.png)
*Screenshot showing the edit tutorial form*

#### Nginx Configuration
![Nginx Configuration](screenshots/nginx/nginx_config.png)
*Screenshot showing Nginx configuration for routing*

## Testing the Application

1. **Create a Tutorial**:
   - Navigate to http://localhost
   - Click on "Add" button
   - Fill in the title and description
   - Click "Submit"

2. **View Tutorials**:
   - Navigate to http://localhost
   - All tutorials will be displayed in a list

3. **Edit a Tutorial**:
   - Click on a tutorial from the list
   - Modify the details
   - Click "Update"

4. **Delete a Tutorial**:
   - Click on a tutorial from the list
   - Click "Delete"

5. **Publish a Tutorial**:
   - Click on a tutorial from the list
   - Click the "Publish" button
   - The tutorial status will change to "Published"

## Project Improvements

Future improvements for this project could include:

1. Adding user authentication and authorization
2. Implementing pagination for the tutorials list
3. Adding categories or tags for tutorials
4. Implementing full-text search
5. Adding unit and integration tests
6. Implementing a more robust error handling system

## License

[MIT](LICENSE)
