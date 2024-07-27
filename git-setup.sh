#!/bin/bash

# Initialize Git
printf "${BRIGHT_BLUE}Initializing Git...${RESET}\n"
if [ ! -d '.git' ]; then
  git init
else
  printf "${BLUE}Git is already initialized for this project. Skipping initialization.${RESET}\n"
fi

# Add .gitignore file to project
printf "${BRIGHT_BLUE}Creating .gitignore file...${RESET}\n"
if [ -f ".gitignore" ]; then
  printf "${BLUE}The .gitignore file already exists. Skipping creation.${RESET}\n"
else
  # Copy/Paste file
  cp ${FILES_DIR}/.gitignore ./
  # Print success message
  printf "${GREEN}File created at: ${BOLD}.gitignore${RESET}\n"
fi
