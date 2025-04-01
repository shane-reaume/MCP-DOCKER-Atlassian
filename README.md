# MCP-DOCKER-Atlassian

Docker-based setup for the MCP Atlassian integration to use with VS Code's Copilot MCP extension.

This repository contains configuration and scripts to easily run the MCP Atlassian server in a Docker container, providing access to Confluence and Jira resources via the Model Context Protocol.

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/shane-reaume/MCP-DOCKER-Atlassian.git
   cd MCP-DOCKER-Atlassian
   ```

2. **Set up your credentials:**
   Copy the example environment file and edit it:
   ```bash
   cp .env.example .env
   # Edit .env with your Atlassian credentials
   ```

3. **Start the MCP server:**
   ```bash
   chmod +x start-mcp.sh
   ./start-mcp.sh
   ```

4. **Configure VS Code:**
   Add this to your VS Code `settings.json`:
   ```json
   "mcpManager.servers": [
     {
       "name": "Atlassian-MCP",
       "type": "sse",
       "url": "http://localhost:9001/sse",
       "enabled": true
     }
   ]
   ```

5. **Stop the server when done:**
   ```bash
   ./stop-mcp.sh
   ```

## Available Scripts

- **start-mcp.sh**: Builds the Docker image and starts the container
- **stop-mcp.sh**: Stops the running container
- **check-mcp.sh**: Diagnostic tool to verify the server is running correctly

## Available MCP Commands

Once connected, you can use commands like:

- `@mcp confluence_search "search term"`
- `@mcp confluence_get_page "Page Title"`
- `@mcp jira_get_issue "PROJECT-123"`
- `@mcp jira_search "project = PROJECT AND status = 'In Progress'"`

## Based On

This setup is based on the [MCP-Atlassian](https://github.com/sooperset/mcp-atlassian) project.
