#!/bin/bash
# Quick setup script - copy and paste this entire script into your server terminal

set -e

echo "================================================"
echo "Hello World App - Quick Server Setup"
echo "================================================"

# Update and install dependencies
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get upgrade -y
echo "✓ System updated"

# Install Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs
echo "✓ Node.js installed: $(node --version)"

# Install nginx
apt-get install -y nginx
echo "✓ Nginx installed"

# Install git
apt-get install -y git
echo "✓ Git installed"

# Install PM2
npm install -g pm2
echo "✓ PM2 installed"

# Create and setup app directory
mkdir -p /var/www/hello-world-app
cd /var/www/hello-world-app

# Clone repository
if [ -d ".git" ]; then
  echo "Repository already exists, pulling latest changes..."
  git pull origin claude/hello-world-github-actions-3RoPr
else
  echo "Cloning repository..."
  git clone -b claude/hello-world-github-actions-3RoPr https://github.com/eduardkolberg/testclaude.git .
fi
echo "✓ Repository cloned"

# Install dependencies
npm install --production
echo "✓ Dependencies installed"

# Configure nginx
cat > /etc/nginx/sites-available/hello-world-app <<'NGINX_EOF'
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
NGINX_EOF

ln -sf /etc/nginx/sites-available/hello-world-app /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

nginx -t
systemctl restart nginx
systemctl enable nginx
echo "✓ Nginx configured and started"

# Start application
pm2 delete hello-world-app 2>/dev/null || true
pm2 start ecosystem.config.js
pm2 save
pm2 startup systemd -u root --hp /root
echo "✓ Application started"

# Configure firewall
ufw --force enable
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
echo "✓ Firewall configured"

echo ""
echo "================================================"
echo "✓ Setup complete!"
echo "================================================"
echo ""
echo "Application URL: http://116.203.251.113"
echo ""
echo "Test locally: curl http://localhost:3000"
echo "View logs: pm2 logs hello-world-app"
echo "Restart app: pm2 restart hello-world-app"
echo ""
echo "GitHub Actions will now automatically deploy on push"
echo "================================================"

# Test the application
sleep 2
curl -s http://localhost:3000 && echo "" && echo "✓ Application is responding!"
