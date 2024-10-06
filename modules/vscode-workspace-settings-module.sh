#!/bin/bash

# Create the .vscode/settings.json file for formatting WordPress files.
printf "${BLUE}Creating .vscode/settings.json file...${RESET}\n"

vscode_settings=".vscode/settings.json"

if [ -f "$vscode_settings" ]; then
  printf "${YELLOW}The ${vscode_settings} file already exists. Skipping creation.${RESET}\n"
else
  # Create the directories if they don't exist
  mkdir -p "$(dirname "$vscode_settings")"
  # Copy/Paste file
  cp ${FILES_DIR}/vscode-settings.json .vscode/settings.json
  # Print success message
  printf "${GREEN}File created at: ${BOLD}${vscode_settings}${RESET}\n"
fi
