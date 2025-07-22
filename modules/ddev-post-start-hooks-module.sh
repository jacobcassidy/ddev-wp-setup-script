#!/bin/bash

# Set WP development configurations
printf "${BLUE}Adding DDEV post-start hooks for WP Config...${RESET}\n"

CONFIG_FILE=".ddev/config.yaml"
LOG_DIR="$(dirname "$WP_DEBUG_LOG_VALUE")"
SLEEP_COMMAND="sleep 2"
WP_CONTENT_DIR_COMMAND="wp config set WP_CONTENT_DIR \"${WP_CONTENT_DIR_VALUE}\" --raw"
WP_CONTENT_URL_COMMAND="wp config set WP_CONTENT_URL ${WP_CONTENT_URL_VALUE}"
WP_DEBUG_COMMAND="wp config set WP_DEBUG ${WP_DEBUG_VALUE} --raw"
WP_DEBUG_DISPLAY_COMMAND="wp config set WP_DEBUG_DISPLAY ${WP_DEBUG_DISPLAY_VALUE} --raw"
WP_DEBUG_LOG_COMMAND="wp config set WP_DEBUG_LOG ${WP_DEBUG_LOG_VALUE}"
WP_DEBUG_SCRIPT_COMMAND="wp config set SCRIPT_DEBUG ${WP_DEBUG_SCRIPT_VALUE} --raw"
WP_DEV_MODE_COMMAND="wp config set WP_DEVELOPMENT_MODE ${WP_DEVELOPMENT_MODE_VALUE}"
WP_ENV_TYPE_COMMAND="wp config set WP_ENVIRONMENT_TYPE ${WP_ENVIRONMENT_TYPE_VALUE}"

# Check if hooks section exist, if not add the hook commands
if ! grep -q "^hooks:" "$CONFIG_FILE"; then
  echo "hooks:
    post-start:
        - exec: $SLEEP_COMMAND
        - exec: $WP_CONTENT_DIR_COMMAND
        - exec: $WP_CONTENT_URL_COMMAND
        - exec: $WP_DEBUG_COMMAND
        - exec: $WP_DEBUG_DISPLAY_COMMAND
        - exec: $WP_DEBUG_LOG_COMMAND
        - exec: $WP_DEBUG_SCRIPT_COMMAND
        - exec: $WP_DEV_MODE_COMMAND
        - exec: $WP_ENV_TYPE_COMMAND
        - exec: bash -c 'if [ -n \"\$TABLE_PREFIX\" ]; then sed -i \"/\/\* That'\''s all, stop editing! Happy publishing. \*\//i\\\\\n\\\$table_prefix = '\''\$TABLE_PREFIX'\'';\\\n\" wp-config.php; fi'
        " >> "$CONFIG_FILE"
  printf "${GREEN}Added post-start hooks for WP Config in: ${BOLD}${CONFIG_FILE}${RESET}\n\n"
# If the hooks section exist, but the post-start subsection doesn't, add the post-start hook commands
elif grep -q "^hooks:" "$CONFIG_FILE" && ! grep -q "^[[:space:]]*post-start:" "$CONFIG_FILE"; then
  # Add post-start hooks under the existing hooks section
  sed -i '' "/^hooks:/a\\
    post-start:\\
        - exec: $SLEEP_COMMAND\\
        - exec: $WP_CONTENT_DIR_COMMAND\\
        - exec: $WP_CONTENT_URL_COMMAND\\
        - exec: $WP_DEBUG_COMMAND\\
        - exec: $WP_DEBUG_DISPLAY_COMMAND\\
        - exec: $WP_DEBUG_LOG_COMMAND\\
        - exec: $WP_DEBUG_SCRIPT_COMMAND\\
        - exec: $WP_DEV_MODE_COMMAND\\
        - exec: $WP_ENV_TYPE_COMMAND\\
        - exec: bash -c 'if [ -n \"\$TABLE_PREFIX\" ]; then sed -i \"\/\\\/\\\* That'\\\''s all, stop editing! Happy publishing. \\\*\\\//i\\\\\\\\\\\n\\\\\$table_prefix = '\\\''\$TABLE_PREFIX'\\\'';\\\\\\\n\" wp-config.php; fi'\\
" "$CONFIG_FILE"
  printf "${GREEN}Added post-start hooks for WP Config in: ${BOLD}${CONFIG_FILE}${RESET}\n\n"
else
  printf "${BLACK}Post-start hooks already exist in $CONFIG_FILE. Skipping creation.${RESET}\n\n"
fi

# Create the log directory if it doesn't exist
if [ -n "$LOG_DIR" ]; then
  printf "${BLUE}Creating $LOG_DIR directory...${RESET}\n"
  if [ -d "$LOG_DIR" ]; then
    printf "${BLACK}The '$LOG_DIR' directory already exists. Skipping creation.${RESET}\n\n"
  else
    mkdir -p "$LOG_DIR"
    # Print success message
    printf "${GREEN}New directory created at: ${BOLD}${LOG_DIR}${RESET}\n\n"
  fi
else
  printf "${RED}WP_DEBUG_LOG_VALUE is not set. Skipping directory creation.${RESET}\n\n"
fi
