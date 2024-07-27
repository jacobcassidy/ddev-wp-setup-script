#!/bin/bash

# Create a php-ray.ini file to add auto_prepend for the Global Ray loader.
printf "${BRIGHT_BLUE}Creating php-ray.ini file...${RESET}\n"
ray_ini=".ddev/php/php-ray.ini"

if [ -f "$ray_ini" ]; then
  printf "${BLUE}The ${ray_ini} file already exists. Skipping creation.${RESET}\n"
else
   # Create the directories if they don't exist.
  mkdir -p "$(dirname "$ray_ini")"
  # Copy/Paste file
  cp ${FILES_DIR}/php-ray.ini .ddev/php/
  # Print success message
  printf "${GREEN}File created at: ${BOLD}${ray_ini}${RESET}\n"
fi

# Create a Dockerfile which will install the Global Ray package via composer
# when the container is built, including when running `ddev restart`.
printf "${BRIGHT_BLUE}Creating Dockerfile file for Global Ray...${RESET}\n"
ray_dockerfile=".ddev/web-build/Dockerfile"

if [ -f "$ray_dockerfile" ]; then
  printf "${BLUE}The ${ray_dockerfile} file already exists. Skipping creation.${RESET}\n"
else
  # Create the directories if they don't exist
  mkdir -p "$(dirname "$ray_dockerfile")"
  # Copy/Paste file
  cp ${FILES_DIR}/Dockerfile .ddev/web-build/
  # Print success message
  printf "${GREEN}File created at: ${BOLD}${ray_dockerfile}${RESET}\n"
fi

# Add a ray.php file to connect the remote Docker server to the host machine's
# desktop Ray app.
printf "${BRIGHT_BLUE}Creating ray.php file...${RESET}\n"

if [ -f "ray.php" ]; then
  printf "${BLUE}The ray.php file already exists. Skipping creation.${RESET}\n"
else
  # Copy/Paste file
  cp ${FILES_DIR}/ray.php ./ray.php
  # Update file's local_path string
  sed "s#LOCAL_PROJECT_DIR#${PROJECT_DIR}#g" ray.php > ray.tmp && mv ray.tmp ray.php
  # Print success message
  printf "${GREEN}File created at: ${BOLD}ray.php${RESET}\n"
fi
