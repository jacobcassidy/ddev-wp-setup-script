#!/bin/bash

# Set WP development configurations
printf "${BLUE}Setting WordPress Debug Configurations...${RESET}\n"

CONFIG_FILE=".ddev/config.yaml"
SLEEP_SETTING="sleep 2"
WP_ENV_SETTING="wp config set WP_ENVIRONMENT_TYPE ${WP_ENVIRONMENT_TYPE_VALUE}"
WP_DEBUG_SETTING="wp config set WP_DEBUG ${WP_DEBUG_VALUE} --raw"
WP_DISPLAY_SETTING="wp config set WP_DEBUG_DISPLAY ${WP_DEBUG_DISPLAY_VALUE} --raw"
WP_SCRIPT_DEBUG_SETTING="wp config set SCRIPT_DEBUG ${SCRIPT_DEBUG_VALUE} --raw"
WP_LOG_SETTING="wp config set WP_DEBUG_LOG ${LOG_DIR_VALUE}"
WP_DEVELOPMENT_MODE_SETTING="wp config set WP_DEVELOPMENT_MODE ${WP_DEVELOPMENT_MODE_VALUE}"

# Add hooks to config.yaml
HOOK="
hooks:
  post-start:
    - exec: $SLEEP_SETTING
    - exec: $WP_ENV_SETTING
    - exec: $WP_DEVELOPMENT_MODE_SETTING
    - exec: $WP_DEBUG_SETTING
    - exec: $WP_DISPLAY_SETTING
    - exec: $WP_SCRIPT_DEBUG_SETTING
    - exec: $WP_LOG_SETTING
"

# Check if the unique exec command exists in the config file
if grep -q "$WP_DEBUG_SETTING" "$CONFIG_FILE"; then
  printf "${BLACK}The WP Debug post-start hooks already exist in $CONFIG_FILE. Skipping creation.${RESET}\n"
# Check if the hooks section exists
elif grep -q "^hooks:" "$CONFIG_FILE"; then
  # Add post-start hooks under the existing hooks section
  sed -i '' "/hooks:/a \\
  \ \ post-start:\\
  \ \ \ \ - exec: $SLEEP_SETTING\\
  \ \ \ \ - exec: $WP_ENV_SETTING\\
  \ \ \ \ - exec: $WP_DEVELOPMENT_MODE_SETTING
  \ \ \ \ - exec: $WP_DEBUG_SETTING\\
  \ \ \ \ - exec: $WP_DISPLAY_SETTING\\
  \ \ \ \ - exec: $WP_SCRIPT_DEBUG_SETTING\\
  \ \ \ \ - exec: $WP_LOG_SETTING" "$CONFIG_FILE"
  printf "${GREEN}Added post-start hooks in: ${BOLD}${CONFIG_FILE}${RESET}.\n"
else
  echo "$HOOK" >> "$CONFIG_FILE"
  printf "${GREEN}Added WP Debug post-start hooks in: ${BOLD}${CONFIG_FILE}${RESET}.\n"
fi

LOG_DIR="$(dirname "$LOG_DIR_VALUE")"

# Create log directory if it doesn't exist
if [ -n "$LOG_DIR" ]; then
  printf "${BLUE}Creating $LOG_DIR directory...${RESET}\n"
  if [ -d "$LOG_DIR" ]; then
    printf "${BLACK}The '$LOG_DIR' directory already exists. Skipping creation.${RESET}\n"
  else
    mkdir -p "$LOG_DIR"
    # Print success message
    printf "${GREEN}New directory created at: ${BOLD}${LOG_DIR}${RESET}\n"
  fi
else
  printf "${RED}LOG_DIR_VALUE is not set. Skipping directory creation.${RESET}\n"
fi

