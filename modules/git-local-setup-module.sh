#!/bin/bash

# Initialize Git
printf "${BLUE}Initializing Git...${RESET}\n"
if [ -d '.git' ]; then
  printf "${YELLOW}Git is already initialized for this project. Skipping initialization.${RESET}\n"
else
  git init
  # Print success message
  printf "${GREEN}Local Git repository created at: ${BOLD}.git${RESET}\n"
fi

# Add .gitignore file to project
printf "${BLUE}Creating .gitignore file...${RESET}\n"
if [ -f ".gitignore" ]; then
  printf "${YELLOW}The .gitignore file already exists. Skipping creation.${RESET}\n"
else
  # Copy/Paste file
  cp ${FILES_DIR}/.gitignore ./
  # Update .gitignore allow list to include custom theme
  sed -i '' "s|# \!wp-content/themes/theme-name|\!wp-content/themes/${STARTER_THEME_SLUG}|g" .gitignore
  # Print success message
  printf "${GREEN}File created at: ${BOLD}.gitignore${RESET}\n"
fi
