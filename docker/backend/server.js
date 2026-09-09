const express = require('express');
const cors = require('cors');
const os = require('os');

const app = express();
const PORT = process.env.PORT || 5000;
const ENVIRONMENT = process.env.APP_ENV || 'development';
const LOG_LEVEL = process.env.LOG_LEVEL || 'info';

app.use(cors());
app.use(express.json());

// Request logger
app.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] [${LOG_LEVEL.toUpperCase()}] ${req.method} ${req.url}`);
    next();
});

// Root route
app.get('/', (req, res) => {
    res.json({
        message: "FA1 Microservices Backend API is up and running!",
        environment: ENVIRONMENT,
        version: "1.0.0"
    });
});

// Health check endpoint
app.get('/api/health', (req, res) => {
    res.status(200).json({
        status: "UP",
        timestamp: new Date().toISOString(),
        uptime: process.uptime()
    });
});

// Environment status endpoint
app.get('/api/status', (req, res) => {
    res.json({
        environment: ENVIRONMENT,
        service: "fa1-backend-api",
        status: "healthy",
        hostname: os.hostname(),
        platform: os.platform(),
        timestamp: new Date().toISOString(),
        config: {
            log_level: LOG_LEVEL,
            port: PORT
        }
    });
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`FA1 Backend Service listening on port ${PORT} in ${ENVIRONMENT.toUpperCase()} environment`);
});
