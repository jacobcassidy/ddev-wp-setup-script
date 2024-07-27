#!/bin/bash

# Variables
SCRIPTS_DIR='ddev-wp-setup-scripts'

# Get the script variables
source ${SCRIPTS_DIR}/script-variables.sh

# Set DDEV containers configuration
printf "${BRIGHT_BLUE}Setting DDEV configurations...${RESET}\n"
ddev config --project-type=wordpress --project-name=$PROJECT_NAME

# Add Spatie Ray app files for development env.
source ${SCRIPTS_DIR}/ray-app-connections.sh

# Add VSCode workspace settings for WP development.
source ${SCRIPTS_DIR}/vscode-workspace-settings.sh

# Build and start the project's Docker containers.
printf "${BRIGHT_BLUE}Starting DDEV containers...${RESET}\n"
ddev start $PROJECT_NAME

# Install git and git assets.
source ${SCRIPTS_DIR}/git-setup.sh

# Install and set up WordPress for development.
source ${SCRIPTS_DIR}/wordpress-starter-setup.sh

