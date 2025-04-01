#!/bin/bash

# Script to manage MCP-Atlassian Docker container lifecycle

ACTION=$1

case $ACTION in
  start)
    echo "Starting MCP-Atlassian container..."
    docker-compose -f "$(dirname "$0")/docker-compose.yml" up -d
    echo "Container started. MCP server available at http://localhost:9001/sse"
    ;;
  stop)
    echo "Stopping MCP-Atlassian container..."
    docker-compose -f "$(dirname "$0")/docker-compose.yml" down
    echo "Container stopped."
    ;;
  status)
    CONTAINER_STATUS=$(docker ps -q -f name=mcp-atlassian)
    if [ -z "$CONTAINER_STATUS" ]; then
      echo "MCP-Atlassian container is not running"
      exit 1
    else
      echo "MCP-Atlassian container is running"
      exit 0
    fi
    ;;
  *)
    echo "Usage: $0 {start|stop|status}"
    exit 1
    ;;
esac
