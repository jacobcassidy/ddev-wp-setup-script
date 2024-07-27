#!/bin/bash

# Variables
SCRIPTS_DIR='ddev-wp-setup-script'

# Get the script variables
source ${SCRIPTS_DIR}/script-variables.sh

# Get the script config settings
source ${SCRIPTS_DIR}/config.sh

# Set DDEV containers configuration
printf "${BRIGHT_BLUE}Setting DDEV configurations...${RESET}\n"
ddev config --project-type=wordpress --project-name=$PROJECT_NAME

# Add Spatie Ray app files for development env.
if $INSTALL_RAY_CONNECTIONS; then
  source ${SCRIPTS_DIR}/ray-app-connections.sh
fi

# Add VSCode workspace settings for WP development.
if $INSTALL_VSCODE_SETTINGS; then
  source ${SCRIPTS_DIR}/vscode-workspace-settings.sh
fi

# Build and start the project's Docker containers.
printf "${BRIGHT_BLUE}Starting DDEV containers...${RESET}\n"
ddev start $PROJECT_NAME

# Install git and git assets.
if $INSTALL_GIT; then
  source ${SCRIPTS_DIR}/git-setup.sh
fi

# Install and set up WordPress for development.
source ${SCRIPTS_DIR}/wordpress-starter-setup.sh

