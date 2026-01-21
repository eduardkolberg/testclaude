# Server Setup Instructions

## Overview
This document provides step-by-step instructions to set up the hello world web application on your server.

## Server Information
- **IP Address**: 91.99.120.72
- **Username**: root
- **Password**: TqkfTEMhvUWrjbjiFhEX

## Part 1: GitHub Actions Setup

### 1.1 Add SSH Private Key to GitHub Secrets

1. Go to your GitHub repository: https://github.com/eduardkolberg/testclaude
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `SSH_PRIVATE_KEY`
5. Value: Copy the entire private key below (including BEGIN and END lines):

```
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACAAjVti6XiXAn3PPp/mRLhGHQ9aOyoibVhGLupbgMaTZAAAAJjGFz6rxhc+
qwAAAAtzc2gtZWQyNTUxOQAAACAAjVti6XiXAn3PPp/mRLhGHQ9aOyoibVhGLupbgMaTZA
AAAEDfrffBCdUERa+TN8gKXL+jSeC4hx7NJVUVOfEXPsG5aQCNW2LpeJcCfc8+n+ZEuEYd
D1o7KiJtWEYu6luAxpNkAAAAFWdpdGh1Yi1hY3Rpb25zLWRlcGxveQ==
-----END OPENSSH PRIVATE KEY-----
```

6. Click **Add secret**

## Part 2: Server Setup

### 2.1 Connect to Server

Connect to your server using SSH or Hetzner Cloud Console:

```bash
ssh root@91.99.120.72
# Password: TqkfTEMhvUWrjbjiFhEX
```

Or use Hetzner Cloud web console at: https://console.hetzner.cloud/

### 2.2 Add GitHub Actions SSH Public Key

On the server, run:

```bash
# Create .ssh directory if it doesn't exist
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# Add the public key to authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIACNW2LpeJcCfc8+n+ZEuEYdD1o7KiJtWEYu6luAxpNk github-actions-deploy" >> /root/.ssh/authorized_keys

# Set correct permissions
chmod 600 /root/.ssh/authorized_keys
```

### 2.3 Run Automated Setup Script

Download and run the setup script:

```bash
# Update system and install curl
apt-get update && apt-get install -y curl

# Download and run the setup script
curl -fsSL https://raw.githubusercontent.com/eduardkolberg/testclaude/claude/hello-world-github-actions-ni842/server-setup.sh | bash
```

Or manually run these commands:

```bash
# Update system
apt-get update && apt-get upgrade -y

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

# Clone repository
git clone https://github.com/eduardkolberg/testclaude.git .
git checkout claude/hello-world-github-actions-ni842

# Install dependencies
npm install --production

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

# Test and restart nginx
nginx -t && systemctl restart nginx && systemctl enable nginx

# Start application with PM2
pm2 start ecosystem.config.js
pm2 save
pm2 startup systemd -u root --hp /root

# Configure firewall
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
echo "y" | ufw enable
```

### 2.4 Verify Installation

Check that everything is running:

```bash
# Check nginx status
systemctl status nginx

# Check PM2 status
pm2 status

# Test application locally
curl http://localhost:3000

# Should return: hello world
```

## Part 3: Test Deployment

### 3.1 Access the Application

Open your browser and navigate to:

**http://91.99.120.72**

You should see "hello world" displayed.

### 3.2 Test GitHub Actions

Any push to the `claude/hello-world-github-actions-ni842` branch will automatically trigger deployment.

You can monitor the deployment at:
https://github.com/eduardkolberg/testclaude/actions

## Troubleshooting

### Application not responding
```bash
pm2 restart hello-world-app
pm2 logs
```

### Nginx issues
```bash
systemctl status nginx
nginx -t
tail -f /var/log/nginx/error.log
```

### Check application logs
```bash
pm2 logs hello-world-app
```

### Manual deployment
```bash
cd /var/www/hello-world-app
git pull origin claude/hello-world-github-actions-ni842
npm ci --production
pm2 restart hello-world-app
```

## Summary

Once setup is complete:
- Application URL: **http://91.99.120.72**
- Automatic deployment on git push to `claude/hello-world-github-actions-ni842`
- PM2 manages the Node.js process
- Nginx serves as reverse proxy on port 80
