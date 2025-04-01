#!/bin/bash

echo "===== MCP Atlassian Server Diagnostics ====="

# Check if container is running
if docker ps | grep -q mcp-atlassian; then
  echo "✅ Container status: RUNNING"
else
  echo "❌ Container status: NOT RUNNING"
  echo "Run ./start-mcp.sh to start the container"
  exit 1
fi

# Check if port is open
if nc -z localhost 9001; then
  echo "✅ Port 9001: OPEN"
else
  echo "❌ Port 9001: CLOSED"
  echo "Port is not accessible, check Docker networking"
  exit 1
fi

# Check SSE endpoint
echo "Testing SSE endpoint..."
curl -s -o /dev/null -w "%{http_code}" http://localhost:9001/sse > /dev/null
if [ $? -eq 0 ]; then
  echo "✅ SSE endpoint: ACCESSIBLE"
else
  echo "❌ SSE endpoint: INACCESSIBLE"
  echo "SSE endpoint cannot be reached"
fi

# Display logs
echo -e "\n===== Container Logs ====="
docker logs mcp-atlassian --tail 30

echo -e "\n===== Environment Variables ====="
docker exec mcp-atlassian env | grep -E 'CONFLUENCE|JIRA|MCP' | sed 's/TOKEN=.*/TOKEN=*****/'

echo -e "\n===== Troubleshooting Tips ====="
echo "1. Make sure you've restarted VS Code after changes"
echo "2. Check if the MCP tools are correctly implemented in the container"
echo "3. Try the following command in VS Code: @mcp confluence_search \"your search term\""
echo "4. If all else fails, rebuild the container:"
echo "   ./stop-mcp.sh && ./start-mcp.sh"
echo ""
echo "For detailed logs: docker logs mcp-atlassian"
