#!/bin/bash

# Download and install Wordpress
printf "${BLUE}Downloading WordPress...${RESET}\n"
if ddev wp core is-installed > /dev/null 2>&1; then
  printf "${YELLOW}Wordpress is already installed. Skipping download and installation.${RESET}\n"
else
  # Download WordPress without themes or plugins
  ddev wp core download --skip-content

  # Install WordPress
  printf "${BLUE}Installing WordPress...${RESET}\n"
  ddev wp core install --url="$DDEV_PRIMARY_URL" --title="${WP_SITE_TITLE:-$PROJECT_TITLE}" --admin_user="$WP_USER_NAME" --admin_password="$WP_USER_PASS" --admin_email="$WP_USER_EMAIL"
fi

# Install default theme
if $INSTALL_DEFAULT_THEME; then
  printf "${BLUE}Installing ${DEFAULT_THEME_SLUG} theme...${RESET}\n"

  if ddev wp theme is-installed ${DEFAULT_THEME_SLUG} > /dev/null 2>&1; then
    DEFAULT_THEME_NAME=$(ddev wp theme get ${DEFAULT_THEME_SLUG} --field=name)
    printf "${YELLOW}${DEFAULT_THEME_NAME} is already installed. Skipping installation.${RESET}\n"
  else
    ddev wp theme install $DEFAULT_THEME_SLUG
  fi
fi

# Install and activate CassidyWP Starter Block Theme
if $INSTALL_STARTER_THEME; then
  if ddev wp theme is-installed ${STARTER_THEME_SLUG} > /dev/null 2>&1; then
    CUSTOM_THEME_NAME=$(ddev wp theme get ${STARTER_THEME_SLUG} --field=name)
    printf "${BLUE}Installing ${CUSTOM_THEME_NAME}...${RESET}\n"
    printf "${YELLOW}${CUSTOM_THEME_NAME} is already installed. Skipping installation.${RESET}\n"
  else
    printf "${BLUE}Creating ${STARTER_THEME_SLUG} directory...${RESET}\n"
    git clone git@github.com:jacobcassidy/cassidywp-starter-block-theme.git wp-content/themes/${STARTER_THEME_SLUG}
    CUSTOM_THEME_NAME=$(ddev wp theme get ${STARTER_THEME_SLUG} --field=name)
    printf "${BLUE}Installing ${CUSTOM_THEME_NAME}...${RESET}\n"
    ddev wp theme activate ${STARTER_THEME_SLUG}

    # Remove remote Git connection to CassidyWP Starter Block Theme repo.
    printf "${BLUE}Removing cloned remote Git for ${CUSTOM_THEME_NAME}...${RESET}\n"
    git -C wp-content/themes/${STARTER_THEME_SLUG} remote remove origin
    # Print success message
    printf "${GREEN}Removed cloned remote Git connection for ${CUSTOM_THEME_NAME}.${RESET}\n"
  fi
fi

# Install All-In-One Migration plugin
if $INSTALL_AIOM_PLUGIN; then
  printf "${BLUE}Installing All-In-One Migration plugin...${RESET}\n"
  PLUGIN_SLUG_AIOM='all-in-one-wp-migration'

  if ddev wp plugin is-installed ${PLUGIN_SLUG_AIOM} > /dev/null 2>&1; then
    PLUGIN_NAME_AIOM=$(ddev wp plugin get ${PLUGIN_SLUG_AIOM} --field=title)
    printf "${YELLOW}${PLUGIN_NAME_AIOM} is already installed. Skipping installation.${RESET}\n"
  else
    ddev wp plugin install $PLUGIN_SLUG_AIOM --activate
  fi
fi

# Copy and install All-In-One Migration Unlimited Extension plugin from host machine.
if $INSTALL_LOCAL_AIOMUE_PLUGIN; then
  printf "${BLUE}Installing All-In-One Migration Unlimited Extension plugin from local source...${RESET}\n"
  PLUGIN_SLUG_AIOMUE='all-in-one-wp-migration-unlimited-extension'

  if ddev wp plugin is-installed ${PLUGIN_SLUG_AIOMUE} > /dev/null 2>&1; then
    PLUGIN_NAME_AIOMUE=$(ddev wp plugin get ${PLUGIN_SLUG_AIOMUE} --field=title)
    printf "${YELLOW}${PLUGIN_NAME_AIOMUE} is already installed. Skipping installation.${RESET}\n"
  else
    unzip "$LOCAL_AIOMUE_PATH" -x "__MACOSX/*" -d ./wp-content/plugins
    printf "${BLUE}Activating All-In-One Migration Unlimited Extension plugin...${RESET}\n"
    ddev wp plugin activate $PLUGIN_SLUG_AIOMUE
  fi
fi

# Install Query Monitor plugin
if $INSTALL_QUERY_MONITOR_PLUGIN; then
  printf "${BLUE}Installing Query Monitor plugin...${RESET}\n"
  PLUGIN_SLUG_QM='query-monitor'

  if ddev wp plugin is-installed ${PLUGIN_SLUG_QM} > /dev/null 2>&1; then
    PLUGIN_NAME_QM=$(ddev wp plugin get ${PLUGIN_SLUG_QM} --field=title)
    printf "${YELLOW}${PLUGIN_NAME_QM} is already installed. Skipping installation.${RESET}\n"
  else
    ddev wp plugin install $PLUGIN_SLUG_QM --activate
  fi
fi

# Update the WP permalinks to use post name
printf "${BLUE}Setting WP permalinks to use '%%postname%%'...${RESET}\n"

if [[ $(ddev wp option get permalink_structure) == '/%postname%' ]]; then
  printf "${YELLOW}The permalink structure is already using '%%postname%%'. Skipping restructure.${RESET}\n"
else
  ddev wp rewrite structure '/%postname%'
fi

# Delete Hello World post
# ddev wp post exists 1 > /dev/null 2>&1 && ddev wp post delete 1 --force
printf "${BLUE}Deleting WordPress' default 'Hello, World' post...${RESET}\n"
if ddev wp post exists 1 > /dev/null 2>&1; then
  ddev wp post delete 1 --force
else
  printf "${YELLOW}Post with ID 1 does not exist. Skipping deletion.${RESET}\n"
fi

# Delete Sample Page
printf "${BLUE}Deleting WordPress' default 'Sample Page'...${RESET}\n"
if ddev wp post exists 2 > /dev/null 2>&1; then
  ddev wp post delete 2 --force
else
  printf "${YELLOW}Post with ID 2 does not exist. Skipping deletion.${RESET}\n"
fi

# Delete Privacy Policy draft page
printf "${BLUE}Deleting WordPress' default 'Privacy Policy'...${RESET}\n"
if ddev wp post exists 3 > /dev/null 2>&1; then
  ddev wp post delete 3 --force
else
  printf "${YELLOW}Post with ID 3 does not exist. Skipping deletion.${RESET}\n"
fi

# Create a 'Homepage' page
printf "${BLUE}Creating a new page titled 'Homepage' and setting it to be the site's front page...${RESET}\n"

if [[ $(ddev wp option get show_on_front) == 'page' ]]; then
  printf "${YELLOW}Homepage already exists. Skipping creation.${RESET}\n"
else
  HOMEPAGE_ID=$(ddev wp post create --post_type=page --post_title='Homepage' --post_author=1 --post_status=publish --post_content='<!-- wp:paragraph --><p>This is the homepage.</p><!-- /wp:paragraph -->' --porcelain)
  ddev wp option update show_on_front 'page'
  ddev wp option update page_on_front $HOMEPAGE_ID
fi

# Open project in default browser to finish WordPress installation
printf "${BLUE}Opening browser to the WP Admin dashboard...${RESET}\n"
ddev launch wp-admin/
