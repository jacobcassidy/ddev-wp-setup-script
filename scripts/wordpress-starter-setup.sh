#!/bin/bash

# Download and install Wordpress
printf "${BRIGHT_BLUE}Downloading WordPress...${RESET}\n"
if ddev wp core is-installed > /dev/null 2>&1; then
  printf "${BLUE}Wordpress is already installed. Skipping download and installation.${RESET}\n"
else
  # Download WordPress without themes or plugins
  ddev wp core download --skip-content

  # Install WordPress
  printf "${BRIGHT_BLUE}Installing WordPress...${RESET}\n"
  ddev wp core install --url="$DDEV_PRIMARY_URL" --title="$WP_SITE_TITLE" --admin_user="$WP_USER_NAME" --admin_password="$WP_USER_PASS" --admin_email="$WP_USER_EMAIL"
fi

# Set WP development configurations
printf "${BRIGHT_BLUE}Setting WordPress Configurations...${RESET}\n"
ddev wp config set WP_ENVIRONMENT_TYPE local
ddev wp config set WP_DEBUG true --raw
ddev wp config set WP_DEBUG_DISPLAY false --raw
ddev wp config set WP_DEBUG_LOG 'log/wp-errors.log'

# Create ./log directory if it doesn't exist
printf "${BRIGHT_BLUE}Creating '/log' directory...${RESET}\n"
if [ ! -d 'log' ]; then
  mkdir log;
else
  printf "${BLUE}The '/log' directory already exists. Skipping creation.${RESET}\n"
fi

# Install default theme
printf "${BRIGHT_BLUE}Installing TwentyTwentyFour theme...${RESET}\n"

if ddev wp theme is-installed ${DEFAULT_THEME_SLUG} > /dev/null 2>&1; then
  DEFAULT_THEME_NAME=$(ddev wp theme get ${DEFAULT_THEME_SLUG} --field=name)
  printf "${BLUE}${DEFAULT_THEME_NAME} is already installed. Skipping installation.${RESET}\n"
else
  ddev wp theme install $DEFAULT_THEME_SLUG
fi

# Install and activate CassidyWP Starter Block Theme with custom theme slug
if ddev wp theme is-installed ${CUSTOM_THEME_SLUG} > /dev/null 2>&1; then
  CUSTOM_THEME_NAME=$(ddev wp theme get ${CUSTOM_THEME_SLUG} --field=name)
  printf "${BRIGHT_BLUE}Installing ${CUSTOM_THEME_NAME}...${RESET}\n"
  printf "${BLUE}${CUSTOM_THEME_NAME} is already installed. Skipping installation.${RESET}\n"
else
  printf "${BRIGHT_BLUE}Creating ${CUSTOM_THEME_SLUG}...${RESET}\n"
  git clone git@github.com:jacobcassidy/cassidywp-starter-block-theme.git wp-content/themes/${CUSTOM_THEME_SLUG}
  CUSTOM_THEME_NAME=$(ddev wp theme get ${CUSTOM_THEME_SLUG} --field=name)
  printf "${BRIGHT_BLUE}Installing ${CUSTOM_THEME_NAME}...${RESET}\n"
  ddev wp theme activate ${CUSTOM_THEME_SLUG}

  # Remove remote Git connection to CassidyWP Starter Block Theme repo.
  # If desired, create a new Git repo for the custom project.
  printf "${BRIGHT_BLUE}Removing cloned remote Git for ${CUSTOM_THEME_NAME}...${RESET}\n"
  git -C wp-content/themes/${CUSTOM_THEME_SLUG} remote remove origin
fi

# Install All-In-One Migration plugin
if $INSTALL_AIOM_PLUGIN; then
  printf "${BRIGHT_BLUE}Installing All-In-One Migration plugin...${RESET}\n"
  PLUGIN_SLUG_AIOM='all-in-one-wp-migration'

  if ddev wp plugin is-installed ${PLUGIN_SLUG_AIOM} > /dev/null 2>&1; then
    PLUGIN_NAME_AIOM=$(ddev wp plugin get ${PLUGIN_SLUG_AIOM} --field=title)
    printf "${BLUE}${PLUGIN_NAME_AIOM} is already installed. Skipping installation.${RESET}\n"
  else
    ddev wp plugin install all-in-one-wp-migration --activate
  fi
fi

# Copy and install All-In-One Migration Unlimited Extension plugin from host machine.
if $INSTALL_LOCAL_AIOMUE_PLUGIN; then
  printf "${BRIGHT_BLUE}Installing All-In-One Migration Unlimited Extension plugin from local source...${RESET}\n"
  PLUGIN_SLUG_AIOMUE='all-in-one-wp-migration-unlimited-extension'

  if ddev wp plugin is-installed ${PLUGIN_SLUG_AIOMUE} > /dev/null 2>&1; then
    PLUGIN_NAME_AIOMUE=$(ddev wp plugin get ${PLUGIN_SLUG_AIOMUE} --field=title)
    printf "${BLUE}${PLUGIN_NAME_AIOMUE} is already installed. Skipping installation.${RESET}\n"
  else
    unzip /Users/Jacob/Projects/Assets/Packages/WordPress/Plugins/All\ In\ One\ Migration\ Unlimited\ Extension/all-in-one-wp-migration-unlimited-extension_2.59.zip -x "__MACOSX/*" -d ./wp-content/plugins
    printf "${BRIGHT_BLUE}Activating All-In-One Migration Unlimited Extension plugin...${RESET}\n"
    ddev wp plugin activate all-in-one-wp-migration-unlimited-extension
  fi
fi

# Update the WP permalinks to use post name
printf "${BRIGHT_BLUE}Setting WP permalinks to use '%%postname%%'...${RESET}\n"

if [[ $(ddev wp option get permalink_structure) == '/%postname%' ]]; then
  printf "${BLUE}The permalink structure is already using '%%postname%%'. Skipping restructure.${RESET}\n"
else
  ddev wp rewrite structure '/%postname%'
fi

# Delete Hello World post
# ddev wp post exists 1 > /dev/null 2>&1 && ddev wp post delete 1 --force
printf "${BRIGHT_BLUE}Deleting WordPress' default 'Hello, World' post...${RESET}\n"
if ddev wp post exists 1 > /dev/null 2>&1; then
  ddev wp post delete 1 --force
else
  printf "${BLUE}Post with ID 1 does not exist. Skipping deletion.${RESET}\n"
fi

# Delete Sample Page
printf "${BRIGHT_BLUE}Deleting WordPress' default 'Sample Page'...${RESET}\n"
if ddev wp post exists 2 > /dev/null 2>&1; then
  ddev wp post delete 2 --force
else
  printf "${BLUE}Post with ID 2 does not exist. Skipping deletion.${RESET}\n"
fi

# Delete Privacy Policy draft page
printf "${BRIGHT_BLUE}Deleting WordPress' default 'Privacy Policy'...${RESET}\n"
if ddev wp post exists 3 > /dev/null 2>&1; then
  ddev wp post delete 3 --force
else
  printf "${BLUE}Post with ID 3 does not exist. Skipping deletion.${RESET}\n"
fi

# Create a 'Homepage' page
printf "${BRIGHT_BLUE}Creating a new page titled 'Homepage' and setting it to be the site's front page...${RESET}\n"

if [[ $(ddev wp option get show_on_front) == 'page' ]]; then
  printf "${BLUE}Homepage already exists. Skipping creation.${RESET}\n"
else
  HOMEPAGE_ID=$(ddev wp post create --post_type=page --post_title='Homepage' --post_author=1 --post_status=publish --post_content='<!-- wp:paragraph --><p>This is the homepage.</p><!-- /wp:paragraph -->' --porcelain)
  ddev wp option update show_on_front 'page'
  ddev wp option update page_on_front $HOMEPAGE_ID
fi

# Open project in default browser to finish WordPress installation
printf "${BRIGHT_BLUE}Opening browser to the WP Admin dashboard...${RESET}\n"
ddev launch wp-admin/
