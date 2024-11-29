#!/bin/bash

# Get the script constants
source ddev-wp-setup-script/modules/constants.sh

# Get the script config settings
source ${SCRIPT_DIR}/config.sh

# Confirm WP_USER_EMAIL is a valid email address before proceeding
if ! [[ "$WP_USER_EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
  printf "${BRIGHT_RED}${WP_USER_EMAIL}${RESET}${RED} is not a valid email address. Please update the ${BRIGHT_RED}WP_USER_EMAIL${RESET}${RED} setting in ${BRIGHT_RED}config.sh${RESET}${RED} with a valid email address and rerun the install script.${RESET}\n"
  exit 1
fi

# Set DDEV containers configuration
printf "${BLUE}Setting DDEV configurations...${RESET}\n"
ddev config --project-type=wordpress --project-name=$PROJECT_NAME_SLUG

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
ddev start $PROJECT_NAME_SLUG

# Install and set up WordPress for development.
source ${MODULES_DIR}/wp-starter-setup-module.sh
