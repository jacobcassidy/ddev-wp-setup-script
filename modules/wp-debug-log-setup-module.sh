#!/bin/bash

# Set WP development configurations
printf "${BLUE}Setting WordPress Debug Configurations...${RESET}\n"

CONFIG_FILE=".ddev/config.yaml"
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
    - exec: $WP_ENV_SETTING
    - exec: $WP_DEVELOPMENT_MODE_SETTING
    - exec: $WP_DEBUG_SETTING
    - exec: $WP_DISPLAY_SETTING
    - exec: $WP_SCRIPT_DEBUG_SETTING
    - exec: $WP_LOG_SETTING
"

# Check if the unique exec command exists in the config file
if grep -q "$WP_DEBUG_SETTING" "$CONFIG_FILE"; then
  printf "${YELLOW}The WP Debug post-start hooks already exist in $CONFIG_FILE. Skipping creation.${RESET}\n"
# Check if the hooks section exists
elif grep -q "^hooks:" "$CONFIG_FILE"; then
  # Add post-start hooks under the existing hooks section
  sed -i '' "/hooks:/a \\
  \ \ post-start:\\
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


# Create ./log directory if it doesn't exist
printf "${BLUE}Creating '/log' directory...${RESET}\n"
if [ -d 'log' ]; then
  printf "${YELLOW}The '/log' directory already exists. Skipping creation.${RESET}\n"
else
  mkdir log;
  # Print success message
  printf "${GREEN}New directory created at: ${BOLD}/log${RESET}\n"
fi
