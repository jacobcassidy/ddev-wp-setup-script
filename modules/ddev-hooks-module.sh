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
  CONFIG_VALUE="\"${!VALUE_VAR_NAME}\""

  if [ -n "${CONFIG_VALUE}" ]; then
    eval "$HOOK_VAR_NAME='${EXEC_HOOK} wp config set $CONFIG \"'${CONFIG_VALUE}'\" --raw'"
  else
    eval "$HOOK_VAR_NAME="
  fi
done

# Add search-replace hook for post-import-db
if [ $ADD_DB_URL_REPLACE ] && [ -n "$DB_URL_REPLACE_VALUE" ]; then
  DB_URL_REPLACE_HOOK="${EXEC_HOOK} wp search-replace ${DB_URL_REPLACE_VALUE}"
fi

# Check if hooks section exist, if not add the hook commands
if ! grep -q "^hooks:" "$CONFIG_FILE"; then
  {
    echo "hooks:"
    echo "    post-start:"
    for CONFIG in "${WP_CONFIGS[@]}"; do
      HOOK_VAR_NAME="${CONFIG}_HOOK"
      if [ -n "${!HOOK_VAR_NAME}" ]; then
        echo "        ${!HOOK_VAR_NAME}"
      fi
    done
    echo "    post-import-db:"
    if [ -n "$DB_URL_REPLACE_HOOK" ]; then
      echo "        $DB_URL_REPLACE_HOOK"
    fi
  } >> "$CONFIG_FILE"
  printf "${GREEN}Added hooks section with post-start and post-import-db in: ${BOLD}${CONFIG_FILE}${RESET}\n\n"
else
  # Check if post-start hooks section exists
  grep -q "^[[:space:]]*post-start:" "$CONFIG_FILE"
  POST_START_EXISTS=$?

  # Check if post-import-db hooks section exists
  grep -q "^[[:space:]]*post-import-db:" "$CONFIG_FILE"
  POST_IMPORT_DB_EXISTS=$?

  if [ $POST_START_EXISTS -ne 0 ]; then
    sed -i '' "/^hooks:/a\\
    post-start:\\
$(for CONFIG in "${WP_CONFIGS[@]}"; do
  HOOK_VAR_NAME="${CONFIG}_HOOK"
  if [ -n "${!HOOK_VAR_NAME}" ]; then
    printf "        %s\\\\\n" "${!HOOK_VAR_NAME}"
  fi
done)
" "$CONFIG_FILE"
    printf "${GREEN}Added post-start hooks for WP Config in: ${BOLD}${CONFIG_FILE}${RESET}\n\n"
  else
    printf "${BLACK}The post-start hooks section already exist in $CONFIG_FILE. Skipping creation.${RESET}\n\n"
  fi

  if [ $POST_IMPORT_DB_EXISTS -ne 0 ]; then
    sed -i '' "/^hooks:/a\\
    post-import-db:\\
$(if [ -n "$DB_URL_REPLACE_HOOK" ]; then
  printf "        %s\\\\\n" "$DB_URL_REPLACE_HOOK"
fi)
" "$CONFIG_FILE"
    printf "${GREEN}Added post-start hooks for WP Config in: ${BOLD}${CONFIG_FILE}${RESET}\n\n"
  else
    printf "${BLACK}The post-import-db hooks section already exist in $CONFIG_FILE. Skipping creation.${RESET}\n\n"
  fi
fi
