# Hello World Web Application

Simple Node.js Express application that displays "hello world".

## Features

- Express web server
- PM2 process manager
- Nginx reverse proxy
- Automatic deployment via GitHub Actions

## Server Details

- IP: 91.99.120.72
- Application URL: http://91.99.120.72

## Deployment

The application automatically deploys to the server when changes are pushed to the `claude/hello-world-github-actions-ni842` branch.

## Local Development

```bash
npm install
npm start
```

The application will be available at http://localhost:3000

## Server Setup

The server has been configured with:
- Node.js 18.x
- Nginx as reverse proxy
- PM2 for process management
- Automatic deployment pipeline
