#!/bin/bash

CONFIG_FILE=".ddev/config.yaml"

# Set WP development configurations
printf "${BLUE}Adding DDEV configuration hooks to ${CONFIG_FILE}...${RESET}\n"

EXEC_HOOK="- exec:"
SLEEP_HOOK="${EXEC_CMD} sleep 2"

# Define an array of WP config command variable names
WP_CONFIGS=(
  SCRIPT_DEBUG
  WP_CONTENT_DIR
  WP_CONTENT_URL
  WP_DEBUG
  WP_DEBUG_DISPLAY
  WP_DEBUG_LOG
  WP_DEVELOPMENT_MODE
  WP_ENVIRONMENT_TYPE
)

# Create {WP_CONFIG}_HOOK variables assigned to {WP_CONFIG}_VALUE
for CONFIG in "${WP_CONFIGS[@]}"; do
  HOOK_VAR_NAME="${CONFIG}_HOOK"
  VALUE_VAR_NAME="${CONFIG}_VALUE"
  CONFIG_VALUE=${!VALUE_VAR_NAME}

  if [ -n "${CONFIG_VALUE}" ]; then
    eval "$HOOK_VAR_NAME=\"${EXEC_HOOK} wp config set $CONFIG $CONFIG_VALUE\""
    printf " HOOK: ${!HOOK_VAR_NAME}\n"
  else
    eval "$HOOK_VAR_NAME="
    printf "EMPTY"
  fi
done
# declare -p

# if $SET_DB_URL_REPLACE; then
#   DB_URL_REPLACE="- exec: wp search-replace ${SET_DB_URL_REPLACE}"
# else
#   DB_URL_REPLACE=""
# fi

# # Check if hooks section exist, if not add the hook commands
# if ! grep -q "^hooks:" "$CONFIG_FILE"; then

#   TMP_HOOKS_FILE=$(mktemp)

#   cat << EOF > $TMP_HOOKS_FILE
#   hooks:
#     post-start:
#         - exec: $SLEEP_COMMAND
#         - exec: $WP_CONTENT_DIR_COMMAND
#         - exec: $WP_CONTENT_URL_COMMAND
#         - exec: $WP_DEBUG_COMMAND
#         - exec: $WP_DEBUG_DISPLAY_COMMAND
#         - exec: $WP_DEBUG_LOG_COMMAND
#         - exec: $WP_DEBUG_SCRIPT_COMMAND
#         - exec: $WP_DEV_MODE_COMMAND
#         - exec: $WP_ENV_TYPE_COMMAND
#         - exec: bash -c 'if [ -n "\$TABLE_PREFIX" ]; then sed -i "/\* That'\''s all, stop editing! Happy publishing. \*\//i\\
#   \\\$table_prefix = '\''\$TABLE_PREFIX'\'';\\
#   " wp-config.php; fi'
#   EOF
#   cat "$TMP_HOOKS_FILE" >> "$CONFIG_FILE"
#   rm "$TMP_HOOKS_FILE"

# -----------------------
# -- ORIGINAL SETTINGS --
# -----------------------

# CONFIG_FILE=".ddev/config.yaml"
# SLEEP_COMMAND="sleep 2"
# WP_CONTENT_DIR_COMMAND="wp config set WP_CONTENT_DIR \"${WP_CONTENT_DIR_VALUE}\" --raw"
# WP_CONTENT_URL_COMMAND="wp config set WP_CONTENT_URL ${WP_CONTENT_URL_VALUE}"
# WP_DEBUG_COMMAND="wp config set WP_DEBUG ${WP_DEBUG_VALUE} --raw"
# WP_DEBUG_DISPLAY_COMMAND="wp config set WP_DEBUG_DISPLAY ${WP_DEBUG_DISPLAY_VALUE} --raw"
# WP_DEBUG_LOG_COMMAND="wp config set WP_DEBUG_LOG ${WP_DEBUG_LOG_VALUE}"
# WP_DEBUG_SCRIPT_COMMAND="wp config set SCRIPT_DEBUG ${WP_DEBUG_SCRIPT_VALUE} --raw"
# WP_DEV_MODE_COMMAND="wp config set WP_DEVELOPMENT_MODE ${WP_DEVELOPMENT_MODE_VALUE}"
# WP_ENV_TYPE_COMMAND="wp config set WP_ENVIRONMENT_TYPE ${WP_ENVIRONMENT_TYPE_VALUE}"

# # Check if hooks section exist, if not add the hook commands
# if ! grep -q "^hooks:" "$CONFIG_FILE"; then
#   echo "hooks:
#     post-start:
#         - exec: $SLEEP_COMMAND
#         - exec: $WP_CONTENT_DIR_COMMAND
#         - exec: $WP_CONTENT_URL_COMMAND
#         - exec: $WP_DEBUG_COMMAND
#         - exec: $WP_DEBUG_DISPLAY_COMMAND
#         - exec: $WP_DEBUG_LOG_COMMAND
#         - exec: $WP_DEBUG_SCRIPT_COMMAND
#         - exec: $WP_DEV_MODE_COMMAND
#         - exec: $WP_ENV_TYPE_COMMAND
#         - exec: bash -c 'if [ -n \"\$TABLE_PREFIX\" ]; then sed -i \"/\/\* That'\''s all, stop editing! Happy publishing. \*\//i\\\\\n\\\$table_prefix = '\''\$TABLE_PREFIX'\'';\\\n\" wp-config.php; fi'
#         "
#     echo "hello" >> "$CONFIG_FILE"
#   printf "${GREEN}Added post-start hooks for WP Config in: ${BOLD}${CONFIG_FILE}${RESET}\n\n"
# # If the hooks section exist, but the post-start subsection doesn't, add the post-start hook commands
# elif grep -q "^hooks:" "$CONFIG_FILE" && ! grep -q "^[[:space:]]*post-start:" "$CONFIG_FILE"; then
#   # Add post-start hooks under the existing hooks section
#   sed -i '' "/^hooks:/a\\
#     post-start:\\
#         - exec: $SLEEP_COMMAND\\
#         - exec: $WP_CONTENT_DIR_COMMAND\\
#         - exec: $WP_CONTENT_URL_COMMAND\\
#         - exec: $WP_DEBUG_COMMAND\\
#         - exec: $WP_DEBUG_DISPLAY_COMMAND\\
#         - exec: $WP_DEBUG_LOG_COMMAND\\
#         - exec: $WP_DEBUG_SCRIPT_COMMAND\\
#         - exec: $WP_DEV_MODE_COMMAND\\
#         - exec: $WP_ENV_TYPE_COMMAND\\
#         - exec: bash -c 'if [ -n \"\$TABLE_PREFIX\" ]; then sed -i \"\/\\\/\\\* That'\\\''s all, stop editing! Happy publishing. \\\*\\\//i\\\\\\\\\\\n\\\\\$table_prefix = '\\\''\$TABLE_PREFIX'\\\'';\\\\\\\n\" wp-config.php; fi'\\
# " "$CONFIG_FILE"
#   printf "${GREEN}Added post-start hooks for WP Config in: ${BOLD}${CONFIG_FILE}${RESET}\n\n"
# else
#   printf "${BLACK}Post-start hooks already exist in $CONFIG_FILE. Skipping creation.${RESET}\n\n"
# fi
