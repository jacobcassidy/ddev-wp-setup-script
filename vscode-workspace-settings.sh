#!/bin/bash

# Create the .vscode/settings.json file for formatting WordPress files.
printf "${BRIGHT_BLUE}Creating .vscode/settings.json file...${RESET}\n"
vscode_settings=".vscode/settings.json"

if [ -f "$vscode_settings" ]; then
  printf "${BLUE}The ${vscode_settings} file already exists. Skipping creation.${RESET}\n"
else
  # Create the directories if they don't exist
  mkdir -p "$(dirname "$vscode_settings")"
  # Copy/Paste file
  cp ${FILES_DIR}/settings.json .vscode/
  # Print success message
  printf "${GREEN}File created at: ${BOLD}${vscode_settings}${RESET}\n"
fi
