#!/bin/bash

# Set environment variables
export NODE_ENV=production
export PORT=5678
export N8N_PORT=5678
export N8N_HOST=0.0.0.0
export N8N_LISTEN_ADDRESS=0.0.0.0

echo "Starting n8n with environment:"
echo "NODE_ENV: $NODE_ENV"
echo "PORT: $PORT"
echo "N8N_PORT: $N8N_PORT"
echo "N8N_HOST: $N8N_HOST"
echo "N8N_LISTEN_ADDRESS: $N8N_LISTEN_ADDRESS"

# Change to CLI directory
cd packages/cli

# Check if dist/index.js exists
if [ ! -f "dist/index.js" ]; then
    echo "Error: dist/index.js not found. CLI package may not be built."
    exit 1
fi

echo "Starting n8n..."
node dist/index.js start 