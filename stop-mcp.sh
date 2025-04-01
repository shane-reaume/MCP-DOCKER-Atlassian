#!/bin/bash

# Stop the container if it's running
if docker ps -q --filter "name=mcp-atlassian" | grep -q .; then
  echo "Stopping MCP-Atlassian container..."
  docker stop mcp-atlassian
  echo "Container stopped."
else
  echo "MCP-Atlassian container is not running."
fi
