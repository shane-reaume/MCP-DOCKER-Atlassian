# MCP-DOCKER-Atlassian

Docker-based setup for the MCP Atlassian integration to use with VS Code's Copilot MCP extension.

This repository contains configuration and scripts to easily run the MCP Atlassian server in a Docker container, providing access to Confluence and Jira resources via the Model Context Protocol.

> **Note:** Previous MyPy type checking issues inherited from the upstream project have been resolved. The type checking system is now fully functional and passing all checks.

## Prerequisites

- Docker installed and running
- Visual Studio Code with the Copilot Chat extension
- Atlassian Cloud account with API token
  - Generate token at: https://id.atlassian.net/manage-profile/security/api-tokens
  - Save the token securely - it cannot be viewed again after creation

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

   Important: Do not use quotes around values in the .env file

3. **Make scripts executable:**
   ```bash
   chmod +x *.sh
   ```

4. **Start the MCP server:**

   ```bash
   ./start-mcp.sh
   ```

   The server will be available at http://localhost:9001/sse
   **Stop the MCP server:**

   ```bash
   ./stop-mcp.sh
   ```

6. **Configure VS Code:**
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

7. **Stop the server when done:**
   ```bash
   ./stop-mcp.sh
   ```

## Available Scripts

- **start-mcp.sh**: Builds the Docker image and starts the container
- **stop-mcp.sh**: Stops the running container
- **check-mcp.sh**: Diagnostic tool to verify the server is running correctly
- **cleanup.sh**: Removes old containers and images
- **update-remote.sh**: Helper for managing git remotes
- **mcp-manager.sh**: Additional management commands

## Available MCP Commands

Once connected, you can use commands like:

- `@mcp confluence_search "search term"`
- `@mcp confluence_get_page "Page Title"`
- `@mcp jira_get_issue "PROJECT-123"`
- `@mcp jira_search "project = PROJECT AND status = 'In Progress'"`

## Troubleshooting

1. **SSE Connection Issues**
   - Ensure the Docker container is running: `docker ps | grep mcp-atlassian`
   - Check container logs: `docker logs mcp-atlassian`
   - Verify the port is accessible: `curl http://localhost:9001/health`

2. **Authentication Issues**
   - Ensure your API token is correct and not surrounded by quotes in .env
   - Check that your email matches the one used to generate the API token
   - Verify you have appropriate permissions in Confluence/Jira

3. **Common Errors**
   - "SSE error: TypeError: fetch failed": Restart VS Code and the MCP server
   - "Current user not permitted": Check API token and permissions
   - Empty results: Verify space/project access and try more general searches first

## Environment Variables

Key environment variables in `.env`:

- `MCP_TRANSPORT`: Set to 'sse' for VS Code integration
- `MCP_PORT`: Default 9001, change if port is in use
- `CONFLUENCE_URL`: Your Atlassian instance URL
- `CONFLUENCE_USERNAME`: Your Atlassian email
- `CONFLUENCE_API_TOKEN`: Your API token
- `CONFLUENCE_SPACES_FILTER`: Optional space restrictions

See `.env.example` for all available options.

## Based On

This setup is based on the [MCP-Atlassian](https://github.com/sooperset/mcp-atlassian) project, customized for Docker-based deployment.
