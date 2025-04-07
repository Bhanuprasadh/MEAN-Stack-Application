# Stage 1: Build the Angular application
FROM node:18-slim as build

WORKDIR /app

# Set production environment
ENV NODE_ENV=production

# Copy package.json and package-lock.json first (better layer caching)
COPY package.json package-lock.json ./

# Install dependencies with clean cache
RUN npm ci && \
    npm cache clean --force

# Copy the rest of the application source code
COPY . .

# Build the Angular app for production with optimization
RUN npm run build -- --configuration production --aot

# Stage 2: Serve the application with Nginx
FROM nginx:alpine

# Create nginx config file for Angular SPA
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    gzip on; \
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript; \
    root /usr/share/nginx/html; \
    index index.html; \
    # Support for Angular routing \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    # Security headers \
    add_header X-Frame-Options "SAMEORIGIN"; \
    add_header X-XSS-Protection "1; mode=block"; \
    add_header X-Content-Type-Options "nosniff"; \
    add_header Content-Security-Policy "default-src \'self\'; script-src \'self\' \'unsafe-inline\' \'unsafe-eval\'; style-src \'self\' \'unsafe-inline\'; img-src \'self\' data:; font-src \'self\' data:; connect-src \'self\' http://localhost:8080"; \
}' > /etc/nginx/conf.d/default.conf

# Copy the built app from the build stage to Nginx's html directory
COPY --from=build /app/dist/angular-15-crud /usr/share/nginx/html

# Set proper permissions
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    # Create a basic health check file
    echo "OK" > /usr/share/nginx/html/health.html

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/health.html || exit 1

# Expose port 80
EXPOSE 80

# Run as non-root user
USER nginx

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
