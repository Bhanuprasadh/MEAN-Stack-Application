# Use Node.js 18 as base image
FROM node:18

# Set working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Set environment variable for MongoDB connection
# This will be overridden by docker-compose
ENV MONGODB_URI=mongodb://mongo:27017/dd_db

# Expose the port the app will run on
EXPOSE 8080

# Command to run the application
CMD ["node", "server.js"]

