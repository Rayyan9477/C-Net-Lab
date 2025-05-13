#!/bin/bash

# Script to fix GitHub Actions cache issue and apply changes

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}===== Fixing GitHub Actions Workflow =====${NC}"

cd /workspaces/C-Net-Lab || { echo "Cannot cd to workspace directory"; exit 1; }

# Remove old workflow file and rename the new one
echo "Renaming fixed workflow file to replace the original..."
git add .github/workflows/microservices-cicd.yml .github/workflows/microservices-cicd-fixed.yml
git mv .github/workflows/microservices-cicd-fixed.yml .github/workflows/microservices-cicd.yml -f

# Commit the changes
echo "Committing changes..."
git commit -m "Fix: GitHub Actions npm caching issue"

# Push to GitHub (if desired)
echo -e "${GREEN}Changes committed locally.${NC}"
echo ""
echo "To push these changes to GitHub, run:"
echo "git push origin main"
echo ""
echo "The workflow changes should now fix the dependency cache issue!"
