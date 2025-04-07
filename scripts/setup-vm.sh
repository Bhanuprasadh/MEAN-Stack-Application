#!/bin/bash

# Exit on any error
set -e

echo "===== Starting VM setup script ====="

# Update system
echo "===== Updating system packages ====="
sudo apt-get update
sudo apt-get upgrade -y

# Install required packages
echo "===== Installing required packages ====="
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Install Docker
echo "===== Installing Docker ====="
# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the stable repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add current user to docker group
sudo usermod -aG docker $USER

# Install Docker Compose
echo "===== Installing Docker Compose ====="
sudo curl -L "https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Configure firewall
echo "===== Configuring firewall ====="
# Install UFW if not installed
sudo apt-get install -y ufw

# Configure UFW
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Enable UFW (only if not enabled already to avoid SSH lockout)
if ! sudo ufw status | grep -q "Status: active"; then
  sudo ufw --force enable
fi

# Create application directories
echo "===== Creating application directories ====="
mkdir -p ~/app/nginx

# Set up environment variables
echo "===== Setting up environment variables ====="
cat << EOF > ~/.app_env
# App environment variables
MONGODB_URI=mongodb://mongo:27017/dd_db
NODE_ENV=production
EOF

echo "===== VM setup complete! ====="
echo "Please log out and log back in for Docker group changes to take effect."

