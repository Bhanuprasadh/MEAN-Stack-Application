# Use Node.js 18-slim as base image for smaller size
FROM node:18-slim

# Set working directory in the container
WORKDIR /usr/src/app

# Set production environment for better performance and security
ENV NODE_ENV=production
ENV MONGODB_URI=mongodb://mongo:27017/dd_db

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies with clean cache for smaller layers
RUN npm ci --only=production && \
    npm cache clean --force

# Create a non-root user for security
RUN apt-get update && apt-get install -y --no-install-recommends dumb-init && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -r nodejs && \
    useradd -r -g nodejs -s /bin/bash -d /home/nodejs -m nodejs

# Copy the rest of the application source code
COPY --chown=nodejs:nodejs . .

# Set ownership and permissions
RUN chown -R nodejs:nodejs /usr/src/app

# Switch to non-root user
USER nodejs

# Expose the port the app will run on
EXPOSE 8080

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/api/tutorials || exit 1

# Use dumb-init as PID 1 for proper signal handling
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Command to run the application
CMD ["node", "server.js"]
