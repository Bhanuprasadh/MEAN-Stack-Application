# MEAN Stack CRUD Application

A containerized MEAN (MongoDB, Express, Angular, Node.js) stack application with CI/CD pipeline integration.

## Project Overview

This project is a full-stack CRUD (Create, Read, Update, Delete) application built with the MEAN stack:

- **MongoDB**: NoSQL database for data storage
- **Express.js**: Backend web application framework
- **Angular 15**: Frontend framework
- **Node.js**: JavaScript runtime environment

The application is containerized using Docker and includes a CI/CD pipeline with GitHub Actions for automated testing, building, and deployment.

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
         ^
         |
         |
+---------------------------------------------------------------------------------------------------+
|                                      GitHub Actions CI/CD                                         |
+---------------------------------------------------------------------------------------------------+
```

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

## License

[MIT](LICENSE)

In this DevOps task, you need to build and deploy a full-stack CRUD application using the MEAN stack (MongoDB, Express, Angular 15, and Node.js). The backend will be developed with Node.js and Express to provide REST APIs, connecting to a MongoDB database. The frontend will be an Angular application utilizing HTTPClient for communication.  

The application will manage a collection of tutorials, where each tutorial includes an ID, title, description, and published status. Users will be able to create, retrieve, update, and delete tutorials. Additionally, a search box will allow users to find tutorials by title.

## Project setup

### Node.js Server

cd backend

npm install

You can update the MongoDB credentials by modifying the `db.config.js` file located in `app/config/`.

Run `node server.js`

### Angular Client

cd frontend

npm install

Run `ng serve --port 8081`

You can modify the `src/app/services/tutorial.service.ts` file to adjust how the frontend interacts with the backend.

Navigate to `http://localhost:8081/`
# MEAN-Stack-Application
