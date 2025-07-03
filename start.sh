#!/bin/bash

# Set environment variables
export NODE_ENV=production
export PORT=5678
export N8N_PORT=5678
export N8N_HOST=0.0.0.0
export N8N_LISTEN_ADDRESS=0.0.0.0

# Database configuration - ensure SQLite is used
export DB_TYPE=sqlite
export DB_SQLITE_DATABASE=database.sqlite
export DB_SQLITE_POOL_SIZE=0
export DB_SQLITE_ENABLE_WAL=false
export DB_SQLITE_VACUUM_ON_STARTUP=false

# Additional configuration for better debugging
export N8N_LOG_LEVEL=debug
export N8N_DIAGNOSTICS_ENABLED=true

echo "Starting n8n with environment:"
echo "NODE_ENV: $NODE_ENV"
echo "PORT: $PORT"
echo "N8N_PORT: $N8N_PORT"
echo "N8N_HOST: $N8N_HOST"
echo "N8N_LISTEN_ADDRESS: $N8N_LISTEN_ADDRESS"
echo "DB_TYPE: $DB_TYPE"
echo "DB_SQLITE_DATABASE: $DB_SQLITE_DATABASE"

# Change to CLI directory
cd packages/cli

# Check if dist/index.js exists
if [ ! -f "dist/index.js" ]; then
    echo "Error: dist/index.js not found. CLI package may not be built."
    exit 1
fi

echo "Starting n8n..."
echo "Current directory: $(pwd)"
echo "Node version: $(node --version)"
echo "NPM version: $(npm --version)"

# Add error handling and verbose logging
set -e  # Exit on any error
set -x  # Print commands as they execute

# Start n8n with better error reporting
node dist/index.js start 2>&1 | tee n8n.log

# If we reach here, the process has exited
echo "n8n process has exited"
exit 1 