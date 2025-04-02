#!/bin/bash

# Get the script constants
source constants.sh

# Get the script settings
source settings.sh

# Confirm WP_USER_EMAIL is a valid email address before proceeding
if ! [[ "$WP_USER_EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
  printf "${BRIGHT_RED}${WP_USER_EMAIL}${RESET}${RED} is not a valid email address. Please update the ${BRIGHT_RED}WP_USER_EMAIL${RESET}${RED} setting in ${BRIGHT_RED}settings.sh${RESET}${RED} with a valid email address and rerun the install script.${RESET}\n"
  exit 1
fi

# Set DDEV containers configuration
printf "${BLUE}Setting DDEV configurations...${RESET}\n"
ddev config --project-type=wordpress --project-name=$PROJECT_NAME_SLUG

# Add Spatie Ray app files for development env.
if $INSTALL_RAY_CONNECTIONS; then
  source /modules/ray-app-connections-module.sh
fi

# Add WordPress debugging log for WP development.
if $INSTALL_WP_DEBUG_SETTING; then
  source /modules/wp-debug-log-setup-module.sh
fi

# Add git and git assets.
if $INSTALL_GIT; then
  source /modules/git-local-setup-module.sh
fi

# Build and start the project's Docker containers.
printf "${BLUE}Starting DDEV containers...${RESET}\n"
ddev start $PROJECT_NAME_SLUG

# Install and set up WordPress for development.
source /modules/wp-starter-setup-module.sh
