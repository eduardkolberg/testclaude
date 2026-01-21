# Quick Start Guide

## Step 1: Access Your Server

Connect to your Hetzner server using one of these methods:

### Option A: SSH (if port 22 is open)
```bash
ssh root@91.99.120.72
# Password: TqkfTEMhvUWrjbjiFhEX
```

### Option B: Hetzner Cloud Console
1. Go to https://console.hetzner.cloud/
2. Select your server
3. Click "Console" button
4. Login as root with password: TqkfTEMhvUWrjbjiFhEX

## Step 2: Run Setup Script

Copy and paste this ONE command into your server terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/eduardkolberg/testclaude/claude/hello-world-github-actions-ni842/quick-setup.sh | bash
```

**OR** if you prefer to review the script first:

```bash
curl -O https://raw.githubusercontent.com/eduardkolberg/testclaude/claude/hello-world-github-actions-ni842/quick-setup.sh
chmod +x quick-setup.sh
./quick-setup.sh
```

This will automatically:
- Install Node.js, Nginx, PM2, and Git
- Clone the repository
- Configure Nginx as reverse proxy
- Start the application
- Configure firewall
- Setup automatic deployment

## Step 3: Add GitHub Secret

1. Go to: https://github.com/eduardkolberg/testclaude/settings/secrets/actions
2. Click "New repository secret"
3. Name: `SSH_PRIVATE_KEY`
4. Value:
```
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACAAjVti6XiXAn3PPp/mRLhGHQ9aOyoibVhGLupbgMaTZAAAAJjGFz6rxhc+
qwAAAAtzc2gtZWQyNTUxOQAAACAAjVti6XiXAn3PPp/mRLhGHQ9aOyoibVhGLupbgMaTZA
AAAEDfrffBCdUERa+TN8gKXL+jSeC4hx7NJVUVOfEXPsG5aQCNW2LpeJcCfc8+n+ZEuEYd
D1o7KiJtWEYu6luAxpNkAAAAFWdpdGh1Yi1hY3Rpb25zLWRlcGxveQ==
-----END OPENSSH PRIVATE KEY-----
```
5. Click "Add secret"

## Step 4: Access Your Application

Open your browser and go to:

### **http://91.99.120.72**

You should see: **hello world**

## That's it! 🎉

Your application is now live and will automatically deploy when you push changes to the `claude/hello-world-github-actions-ni842` branch.

---

## Troubleshooting

### Check if app is running:
```bash
pm2 status
pm2 logs hello-world-app
```

### Restart the app:
```bash
pm2 restart hello-world-app
```

### Check Nginx:
```bash
systemctl status nginx
curl http://localhost:3000
```

### Manual deployment:
```bash
cd /var/www/hello-world-app
git pull
npm install --production
pm2 restart hello-world-app
```
