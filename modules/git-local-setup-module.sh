#!/bin/bash

# Initialize Git
printf "${BLUE}Initializing Git...${RESET}\n"
if [ -d '.git' ]; then
  printf "${BLACK}Git is already initialized for this project. Skipping initialization.${RESET}\n\n"
else
  git init
  # Print success message
  printf "${GREEN}Local Git repository created at: ${BOLD}.git${RESET}\n\n"
fi

# Add .gitignore file to project
printf "${BLUE}Creating .gitignore file...${RESET}\n"
if [ -f ".gitignore" ]; then
  printf "${BLACK}The .gitignore file already exists. Skipping creation.${RESET}\n\n"
else
  # Copy/Paste file
  cp ${ROOT_DIR}/files/gitignore.txt ./.gitignore
  # Update .gitignore allow list to include custom theme if active
  if $INSTALL_CASSIDYDC_STARTER_THEME; then
    sed -i '' "s|# \!wp-content/themes/theme-name|\!wp-content/themes/${CASSIDYDC_STARTER_THEME_SLUG}|g" .gitignore
  fi
  # Print success message
  printf "${GREEN}File created at: ${BOLD}.gitignore${RESET}\n\n"
fi
