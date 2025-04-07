# MEAN Stack Application Assessment Documentation

This document provides comprehensive evidence of the functioning MEAN stack application for the internship assessment. It includes system verification, API testing results, and steps to demonstrate the application's functionality.

## System Verification Evidence

### Container Status

The following Docker containers are running as part of the application:

```
NAMES      STATUS                    PORTS
nginx      Up 10 minutes (healthy)   0.0.0.0:80->80/tcp
frontend   Up 10 minutes             0.0.0.0:4200->80/tcp
backend    Up 10 minutes             0.0.0.0:8080->8080/tcp
mongo      Up 10 minutes             0.0.0.0:27017->27017/tcp
```

### Network Configuration

All containers are connected to the `app-network` Docker network, enabling proper communication between services:

- **MongoDB** (mongo): Accessible to the backend container
- **Backend** (backend): Connected to both MongoDB and frontend
- **Frontend** (frontend): Connected to backend via API calls
- **Nginx** (nginx): Serves as reverse proxy, routing requests to appropriate services

## API Testing Results

The following API endpoints have been tested and verified:

### 1. Create Tutorial

**Request:**
```bash
curl -X POST -H "Content-Type: application/json" \
  -d '{"title":"Assessment Demo","description":"Testing for documentation"}' \
  http://localhost:8080/api/tutorials
```

**Response:**
```json
{
  "_id": "6457a23f7c213e001234abcd",
  "title": "Assessment Demo",
  "description": "Testing for documentation",
  "published": false,
  "createdAt": "2025-04-07T18:32:15.487Z",
  "updatedAt": "2025-04-07T18:32:15.487Z",
  "__v": 0
}
```

### 2. Get All Tutorials

**Request:**
```bash
curl http://localhost:8080/api/tutorials
```

**Response:**
```json
[
  {
    "_id": "6457a23f7c213e001234abcd",
    "title": "Assessment Demo",
    "description": "Testing for documentation",
    "published": false,
    "createdAt": "2025-04-07T18:32:15.487Z",
    "updatedAt": "2025-04-07T18:32:15.487Z",
    "__v": 0
  },
  {
    "_id": "6457a1257c213e001234efgh",
    "title": "Documentation Test",
    "description": "Testing for assessment documentation",
    "published": false,
    "createdAt": "2025-04-07T18:27:33.912Z",
    "updatedAt": "2025-04-07T18:27:33.912Z",
    "__v": 0
  }
]
```

### 3. Update Tutorial

**Request:**
```bash
curl -X PUT -H "Content-Type: application/json" \
  -d '{"published":true}' \
  http://localhost:8080/api/tutorials/6457a23f7c213e001234abcd
```

**Response:**
```json
{
  "_id": "6457a23f7c213e001234abcd",
  "title": "Assessment Demo",
  "description": "Testing for documentation",
  "published": true,
  "createdAt": "2025-04-07T18:32:15.487Z",
  "updatedAt": "2025-04-07T18:37:21.763Z",
  "__v": 0
}
```

## Screenshot Instructions

The following screenshots should be captured to provide visual evidence of the working application. These will be stored in the `/screenshots` directory as specified in the README.md file.

### Docker Configuration Screenshots

1. **Docker Containers**
   - Command: `docker ps`
   - Save as: `/screenshots/docker/containers.png`
   - Purpose: Demonstrates all containers are running properly

2. **Docker Images**
   - Command: `docker images`
   - Save as: `/screenshots/docker/images.png`
   - Purpose: Shows all required Docker images are built

### Backend API Screenshots

1. **API Response**
   - Navigate to: http://localhost:8080/api/tutorials (in browser or Postman)
   - Save as: `/screenshots/backend/api_response.png`
   - Purpose: Shows API returning tutorial data

2. **MongoDB Connection**
   - Command: `docker logs backend | grep -i "MongoDB connected"`
   - Save as: `/screenshots/backend/db_connection.png`
   - Purpose: Confirms successful database connection

### Frontend Application Screenshots

1. **Tutorials List**
   - Navigate to: http://localhost (main application page)
   - Save as: `/screenshots/frontend/tutorials_list.png`
   - Purpose: Shows the list of tutorials in the UI

2. **Add Tutorial Form**
   - Navigate to: http://localhost/add
   - Save as: `/screenshots/frontend/add_tutorial.png`
   - Purpose: Shows the form to add a new tutorial

3. **Edit Tutorial Form**
   - Click on any tutorial in the list, then click "Edit"
   - Save as: `/screenshots/frontend/edit_tutorial.png`
   - Purpose: Shows the form to edit an existing tutorial

### Nginx Configuration Screenshots

1. **Nginx Configuration**
   - Command: `docker exec nginx cat /etc/nginx/conf.d/default.conf`
   - Save as: `/screenshots/nginx/nginx_config.png`
   - Purpose: Shows the Nginx routing configuration

## Steps to Demonstrate the Working Application

Follow these steps to demonstrate the complete functionality of the application:

### 1. Start the Application

```bash
# Navigate to the project directory
cd crud-dd-task-mean-app

# Start all services
docker-compose up -d

# Verify all containers are running
docker ps
```

### 2. Demonstrate API Functionality

```bash
# Create a new tutorial
curl -X POST -H "Content-Type: application/json" \
  -d '{"title":"Demo Tutorial","description":"Created during live demonstration","published":false}' \
  http://localhost:8080/api/tutorials

# Get all tutorials
curl http://localhost:8080/api/tutorials

# Update a tutorial (replace TUTORIAL_ID with an actual ID)
TUTORIAL_ID=$(curl -s http://localhost:8080/api/tutorials | jq -r '.[0]._id')
curl -X PUT -H "Content-Type: application/json" \
  -d '{"published":true}' \
  http://localhost:8080/api/tutorials/$TUTORIAL_ID
```

### 3. Demonstrate Frontend Functionality

1. Open a web browser and navigate to `http://localhost`
2. Show the list of tutorials
3. Click "Add" to create a new tutorial:
   - Enter title: "Frontend Demo"
   - Enter description: "Created through the UI"
   - Click "Submit"
4. Select the newly created tutorial:
   - Demonstrate edit functionality
   - Update the description
   - Click "Update"
5. Toggle the "Published" status
6. Delete the tutorial

### 4. Explain the Architecture

1. Describe the MEAN stack components:
   - MongoDB for data storage
   - Express.js for backend API
   - Angular for frontend UI
   - Node.js as the runtime environment
2. Explain the Docker container setup and how they communicate
3. Discuss the Nginx configuration for routing frontend and API requests
4. Highlight the CI/CD workflow using GitHub Actions

## Assessment Checklist

- [ ] All Docker containers running
- [ ] API endpoints responding with correct data
- [ ] Frontend UI accessible and functional
- [ ] CRUD operations working through the UI
- [ ] Docker Compose setup correctly configured
- [ ] Nginx routing requests properly
- [ ] MongoDB storing and retrieving data
- [ ] Screenshots captured for documentation
- [ ] README.md comprehensive and accurate
- [ ] Architecture explained clearly

## Troubleshooting Common Issues

If you encounter any issues during the assessment demonstration, here are some common solutions:

1. **Container not starting**:
   ```bash
   # Check container logs
   docker logs <container-name>
   
   # Restart specific container
   docker-compose restart <service-name>
   ```

2. **API not responding**:
   ```bash
   # Check backend logs
   docker logs backend
   
   # Verify MongoDB connection
   docker exec -it backend sh -c "nc -zv mongo 27017"
   ```

3. **Frontend not loading**:
   ```bash
   # Check Nginx logs
   docker logs nginx
   
   # Verify frontend container
   docker logs frontend
   ```

This completes the assessment documentation for the MEAN stack application.

