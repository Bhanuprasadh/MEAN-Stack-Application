# MEAN Stack Application Assessment Checklist

This checklist outlines the steps required to complete your assessment preparation, ensuring all necessary evidence is properly captured and all components are verified to be working correctly before submission.

## 1. Required Screenshots

Replace the text files with actual screenshots of the following:

### Docker Screenshots

- [ ] **Container Status**
  - Open terminal and run: `docker ps`
  - Take screenshot showing all 4 containers running (nginx, frontend, backend, mongo)
  - Save as: `screenshots/docker/containers.png`

- [ ] **Docker Images**
  - Run: `docker images | grep -E 'crud-dd-task-mean-app|mongo|nginx'`
  - Take screenshot showing all docker images
  - Save as: `screenshots/docker/images.png`

- [ ] **Docker Compose**
  - Run: `docker-compose ps`
  - Take screenshot showing all services running
  - Save as: `screenshots/docker/compose.png`

- [ ] **Docker Network**
  - Run: `docker network ls | grep app-network`
  - Take screenshot showing the app network
  - Save as: `screenshots/docker/network.png`

### Backend Screenshots

- [ ] **API Response - GET all tutorials**
  - Run: `curl -v http://localhost:8080/api/tutorials | json_pp`
  - Take screenshot showing the API response with JSON data
  - Save as: `screenshots/backend/get_tutorials.png`

- [ ] **API Response - POST new tutorial**
  - Run: `curl -v -X POST -H "Content-Type: application/json" -d '{"title":"Assessment Screenshot","description":"For documentation"}' http://localhost:8080/api/tutorials | json_pp`
  - Take screenshot showing the created tutorial response
  - Save as: `screenshots/backend/post_tutorial.png`

- [ ] **API Response - GET single tutorial**
  - Use an ID from previous responses
  - Run: `curl -v http://localhost:8080/api/tutorials/{TUTORIAL_ID} | json_pp`
  - Take screenshot showing a single tutorial
  - Save as: `screenshots/backend/get_single_tutorial.png`

- [ ] **MongoDB Connection Log**
  - Run: `docker logs backend 2>&1 | grep -i mongo`
  - Take screenshot showing successful MongoDB connection
  - Save as: `screenshots/backend/mongodb_connection.png`

### Frontend Screenshots

- [ ] **Home Page**
  - Open browser to: `http://localhost`
  - Take screenshot of the home page with tutorial list
  - Save as: `screenshots/frontend/home_page.png`

- [ ] **Add Tutorial Form**
  - Click "Add" button on the frontend
  - Take screenshot of the add tutorial form
  - Save as: `screenshots/frontend/add_tutorial.png`

- [ ] **Tutorial Details**
  - Click on a tutorial title in the list
  - Take screenshot of the tutorial details
  - Save as: `screenshots/frontend/tutorial_details.png`

- [ ] **Edit Tutorial**
  - Edit a tutorial (change status or content)
  - Take screenshot showing the edit functionality
  - Save as: `screenshots/frontend/edit_tutorial.png`

### Nginx Screenshots

- [ ] **Nginx Configuration**
  - Run: `docker exec nginx cat /etc/nginx/conf.d/default.conf`
  - Take screenshot showing the nginx configuration
  - Save as: `screenshots/nginx/config.png`

- [ ] **Nginx Logs**
  - Run: `docker logs nginx | tail -20`
  - Take screenshot showing nginx request logs
  - Save as: `screenshots/nginx/logs.png`

## 2. Final Verification Steps

Complete these steps to verify all components are functioning correctly:

- [ ] **Database Verification**
  - Run: `docker exec -it mongo mongo --eval "db.adminCommand('listDatabases')"`
  - Verify tutorials database exists
  - Take screenshot and save as: `screenshots/database_verification.png`

- [ ] **API Endpoint Testing**
  - Complete all CRUD operations using curl:
    ```bash
    # Get all tutorials
    curl -v http://localhost:8080/api/tutorials
    
    # Create a new tutorial
    curl -v -X POST -H "Content-Type: application/json" \
      -d '{"title":"Final Verification","description":"Testing all endpoints"}' \
      http://localhost:8080/api/tutorials
      
    # Get the new tutorial (use ID from response)
    curl -v http://localhost:8080/api/tutorials/{NEW_TUTORIAL_ID}
    
    # Update the tutorial
    curl -v -X PUT -H "Content-Type: application/json" \
      -d '{"published":true}' \
      http://localhost:8080/api/tutorials/{NEW_TUTORIAL_ID}
      
    # Delete the tutorial
    curl -v -X DELETE http://localhost:8080/api/tutorials/{NEW_TUTORIAL_ID}
    ```
  - Verify each operation returned expected response

- [ ] **Frontend Functionality Testing**
  - Navigate to http://localhost in browser
  - Create a new tutorial via the UI
  - Edit the tutorial (update description and status)
  - Delete the tutorial
  - Verify all operations worked correctly

- [ ] **Nginx Routing Verification**
  - Verify frontend requests work: `curl -I http://localhost/`
  - Verify API requests work: `curl -I http://localhost/api/tutorials`
  - Take screenshot showing both responses

## 3. Submission Preparation Steps

- [ ] **Organize Documentation Files**
  - Ensure the following files are complete and up-to-date:
    - README.md
    - ASSESSMENT.md
    - VERIFICATION.md
    - FINAL_REPORT.md
    - CHECKLIST.md (this file)

- [ ] **Verify Screenshots Directory**
  - Ensure all required screenshots are present
  - Remove any text files that were placeholders

- [ ] **Prepare Evidence Directory**
  - Organize all verification logs and test results
  - Ensure all evidence files are properly formatted

- [ ] **Create Final Package**
  - Zip the entire project directory, ensuring it includes:
    - All source code
    - Docker configuration files
    - Documentation
    - Screenshots and evidence
  - Name the file: `MEAN_Stack_Assessment_<YourName>.zip`

## 4. Pre-Assessment Verification Steps

Before submitting, perform these final checks:

- [ ] **Clean Environment Test**
  - Stop and remove all containers: `docker-compose down -v`
  - Remove all related images: `docker rmi $(docker images | grep crud-dd-task-mean-app | awk '{print $3}')`
  - Start fresh deployment: `docker-compose up -d`
  - Verify all containers start correctly: `docker ps`

- [ ] **API Functionality**
  - Test all API endpoints again after clean environment setup
  - Verify data persistence (if any tutorials were created before)

- [ ] **Frontend Accessibility**
  - Verify frontend loads correctly after restart
  - Test basic functionality (view, create, update, delete)

- [ ] **Documentation Review**
  - Review all documentation for completeness
  - Check for any mistakes or missing information
  - Ensure all references to files and commands are accurate

## Final Submission Checklist

- [ ] Source code is complete and working
- [ ] Docker configuration files are present and functional
- [ ] Documentation is complete (README, ASSESSMENT, VERIFICATION, FINAL_REPORT)
- [ ] All required screenshots are captured
- [ ] Evidence of functionality is well-documented
- [ ] Final deployment verification is successful
- [ ] Package is properly named and ready for submission

---

_Complete this checklist before submitting your assessment to ensure all requirements are met._

