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

# Configuration directory - use a writable location
export N8N_CONFIG_PATH=/opt/render/project/src/.n8n
export N8N_USER_FOLDER=/opt/render/project/src/.n8n

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
echo "N8N_CONFIG_PATH: $N8N_CONFIG_PATH"
echo "N8N_USER_FOLDER: $N8N_USER_FOLDER"

# Create the n8n configuration directory if it doesn't exist
mkdir -p /opt/render/project/src/.n8n

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

# Check bin directory contents
echo "Checking bin directory contents:"
ls -la bin/

# Check if start command file exists
echo "Checking if start command file exists:"
if [ -f "dist/commands/start.js" ]; then
    echo "✓ dist/commands/start.js exists"
else
    echo "✗ dist/commands/start.js does not exist"
    exit 1
fi

# Check dist directory structure
echo "Checking dist directory structure:"
ls -la dist/ | head -20

# Check dist/commands directory
echo "Checking dist/commands directory:"
ls -la dist/commands/ | head -20

echo "Starting n8n process..."
set -e  # Exit on any error
set -x  # Print commands as they execute

# Start n8n and capture output
./bin/n8n start 2>&1 | tee n8n.log

# Check exit code
EXIT_CODE=$?
echo "n8n process has exited with code: $EXIT_CODE"

# Show log contents for debugging
echo "=== n8n.log contents ==="
cat n8n.log
echo "=== End of n8n.log ==="

# Exit with the same code as n8n
exit $EXIT_CODE 