#!/bin/bash

echo "=== Cleaning up MCP-DOCKER-Atlassian Project ==="

# Stopping any running containers (just to be safe)
if docker ps -q --filter "name=mcp-atlassian" | grep -q .; then
  echo "Stopping MCP-Atlassian container..."
  docker stop mcp-atlassian
fi

# Define essential files and directories
essential_files=(
  ".env"
  ".env.example"
  ".gitignore"
  "Dockerfile"
  "docker-compose.yml"
  "README.md"
  "start-mcp.sh"
  "stop-mcp.sh"
  "check-mcp.sh"
  "update-remote.sh"
  "cleanup.sh"
  "LICENSE"  # Usually good to keep this
)

# Define unnecessary files and directories
unnecessary_files=(
  "mcp-manager.sh"
  ".pre-commit-config.yaml"
  "CHANGELOG.md"
  "CONTRIBUTING.md"
  "mypy.ini"
  "pyproject.toml"
  "ruff.toml"
  "SECURITY.md"
  "uv.lock"
)

unnecessary_dirs=(
  "tests"
  ".github"
  ".devcontainer"
  "scripts"
)

# Remove unnecessary files
echo "Removing unnecessary files..."
for file in "${unnecessary_files[@]}"; do
  if [ -f "$file" ]; then
    rm -f "$file"
    echo "✓ Removed $file"
  fi
done

# Remove unnecessary directories
echo "Removing unnecessary directories..."
for dir in "${unnecessary_dirs[@]}"; do
  if [ -d "$dir" ]; then
    rm -rf "$dir"
    echo "✓ Removed $dir"
  fi
done

# Ensure the essential files are executable
echo "Setting permissions on essential scripts..."
chmod +x start-mcp.sh stop-mcp.sh check-mcp.sh update-remote.sh cleanup.sh

# Clean up .env file (remove comments and empty lines)
if [ -f .env ]; then
  echo "Cleaning up .env file..."
  # Create backup
  cp .env .env.bak
  # Remove comments and empty lines, preserve actual settings
  grep -v '^#' .env | grep -v '^$' > .env.tmp
  mv .env.tmp .env
  echo "✓ Cleaned up .env file (backup saved as .env.bak)"
fi

# Update .gitignore to ensure .env is not committed
if [ -f .gitignore ]; then
  if ! grep -q "^.env$" .gitignore; then
    echo -e "\n# Environment variables with credentials\n.env" >> .gitignore
    echo "✓ Updated .gitignore to protect .env file"
  fi
fi

# Evaluate whether to keep src directory
echo -e "\nWould you like to retain the Python source code? It's not needed for Docker functionality,"
echo "but you might want to keep it for reference or customization. (y/N)"
read -r keep_src

if [[ ! "$keep_src" =~ ^[Yy] ]]; then
  if [ -d "src" ]; then
    echo "Removing src directory..."
    rm -rf src
    echo "✓ Removed src directory"
  fi
else
  echo "Keeping src directory for reference."
fi

echo -e "\n=== Cleanup Complete! ==="
echo -e "Preserved essential files:"
echo "  - .env: Contains your Atlassian credentials"
echo "  - .env.example: Template for credentials"
echo "  - Dockerfile: Used to build the Docker image"
echo "  - docker-compose.yml: Defines the Docker service"
echo "  - README.md: Documentation for the project"
echo "  - start-mcp.sh: Starts the Docker container"
echo "  - stop-mcp.sh: Stops the Docker container"
echo "  - check-mcp.sh: Diagnoses server issues"
echo "  - update-remote.sh: Updates GitHub repository"
echo -e "\nTo start the MCP server: ./start-mcp.sh"
echo "To stop the MCP server: ./stop-mcp.sh"
echo "To check server status: ./check-mcp.sh"
echo -e "\nYour VS Code should be configured with mcpManager.servers pointing to http://localhost:9001/sse"
