#!/bin/bash

# Get the script constants
source ddev-wp-setup-script/modules/constants.sh

# Get the script config settings
source ${SCRIPT_DIR}/config.sh

# Set DDEV containers configuration
printf "${BLUE}Setting DDEV configurations...${RESET}\n"
ddev config --project-type=wordpress --project-name=$PROJECT_NAME

# Add Spatie Ray app files for development env.
if $INSTALL_RAY_CONNECTIONS; then
  source ${MODULES_DIR}/ray-app-connections-module.sh
fi

# Add VSCode workspace settings file for WP development.
if $INSTALL_VSCODE_SETTINGS; then
  source ${MODULES_DIR}/vscode-workspace-settings-module.sh
fi

# Add WordPress debugging log for WP development.
if $INSTALL_WP_DEBUG_SETTING; then
  source ${MODULES_DIR}/wp-debug-log-setup-module.sh
fi

# Add git and git assets.
if $INSTALL_GIT; then
  source ${MODULES_DIR}/git-local-setup-module.sh
fi

# Build and start the project's Docker containers.
printf "${BLUE}Starting DDEV containers...${RESET}\n"
ddev start $PROJECT_NAME

# Install and set up WordPress for development.
source ${MODULES_DIR}/wp-starter-setup-module.sh
