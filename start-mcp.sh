#!/bin/bash

echo "Building mcp/atlassian Docker image..."
docker build -t mcp/atlassian .

# Run the container with the .env file using Docker best practices
echo "Starting MCP-Atlassian container on port 9001..."
docker run --rm -d \
  -p 9001:9001 \
  --env-file .env \
  --name mcp-atlassian \
  mcp/atlassian \
  --transport sse \
  --port 9001 \
  --verbose --verbose

# Verify the container is running
if docker ps | grep -q mcp-atlassian; then
  echo "✅ Container started successfully. MCP server available at http://localhost:9001/sse"
  echo "You can now enable the 'Atlassian-MCP' server in VS Code's MCP Server Manager"

  # Wait for server to fully initialize
  echo "Waiting for server to initialize (5 seconds)..."
  sleep 5

  # Display logs to help with debugging
  echo "Recent container logs (for debugging):"
  docker logs mcp-atlassian --tail 20
else
  echo "❌ Failed to start container. Check Docker logs for details."
fi
