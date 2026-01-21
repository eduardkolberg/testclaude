#!/bin/bash
set -e

APP_DIR="/var/www/hello-world-app"

echo "Starting deployment..."

# Navigate to app directory
cd $APP_DIR

# Pull latest changes
git pull origin claude/hello-world-github-actions-ni842

# Install dependencies
npm ci --production

# Restart PM2 app
pm2 restart ecosystem.config.js || pm2 start ecosystem.config.js

# Save PM2 configuration
pm2 save

echo "Deployment completed successfully!"
