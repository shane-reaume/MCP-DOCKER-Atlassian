#!/bin/bash

echo "=== Updating Git Repository and Pushing to New Remote ==="

# Check if we're in a git repository
if [ ! -d .git ]; then
  echo "Initializing new git repository..."
  git init
fi

# Set up new remote
echo "Setting up new remote repository..."
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/shane-reaume/MCP-DOCKER-Atlassian.git
echo "✅ Remote 'origin' set to https://github.com/shane-reaume/MCP-DOCKER-Atlassian.git"

# Add all files
echo "Adding files to git..."
git add .

# Add a .gitignore file to exclude sensitive files
if [ ! -f .gitignore ]; then
  echo "Creating .gitignore file..."
  cat > .gitignore << EOL
# Environment variables with secrets
.env

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
*.egg-info/
.installed.cfg
*.egg

# Docker
.dockerignore

# Editor directories and files
.idea
.vscode
*.swp
*.swo
*~
EOL
  git add .gitignore
  echo "✅ Created .gitignore file to protect sensitive data"
fi

# Commit changes
echo "Committing changes..."
git commit -m "Initial setup of MCP-DOCKER-Atlassian with Docker support"

# Push to GitHub
echo "Pushing to GitHub..."
git branch -M main
git push -u origin main

echo "=== Repository Update Complete ==="
echo ""
echo "Your MCP-DOCKER-Atlassian repository is now set up and pushed to GitHub."
echo "Repository URL: https://github.com/shane-reaume/MCP-DOCKER-Atlassian"
echo ""
echo "IMPORTANT: Make sure you have Git credentials configured for pushing to GitHub."
echo "If you encounter authentication errors, you may need to:"
echo "1. Use a personal access token for HTTPS authentication"
echo "2. Or set up SSH keys for your GitHub account"
echo ""
echo "To start the MCP server: ./start-mcp.sh"
echo "To stop the MCP server: ./stop-mcp.sh"
echo "To check server status: ./check-mcp.sh"
