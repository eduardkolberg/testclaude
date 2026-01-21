#!/bin/bash
# Server setup script - run this on the server to prepare environment

set -e

echo "Starting server setup..."

# Update system
apt-get update
apt-get upgrade -y

# Install Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

# Install nginx
apt-get install -y nginx

# Install PM2 globally
npm install -g pm2

# Install git
apt-get install -y git

# Create app directory
mkdir -p /var/www/hello-world-app
cd /var/www/hello-world-app

# Clone repository (will be configured later)
echo "Repository should be cloned manually or via GitHub Actions"

# Configure nginx
cat > /etc/nginx/sites-available/hello-world-app <<'EOF'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
EOF

# Enable nginx site
ln -sf /etc/nginx/sites-available/hello-world-app /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test nginx configuration
nginx -t

# Restart nginx
systemctl restart nginx
systemctl enable nginx

# Configure PM2 to start on boot
pm2 startup systemd -u root --hp /root

# Configure firewall
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
echo "y" | ufw enable || true

echo "Server setup completed!"
echo "Next steps:"
echo "1. Clone repository to /var/www/hello-world-app"
echo "2. Run 'npm install' in the app directory"
echo "3. Start the app with 'pm2 start ecosystem.config.js'"
echo "4. Access the app at http://91.99.120.72"
