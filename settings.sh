#!/bin/bash

# SETTINGS

## Your WP site name. Defaults to the project name taken from the project directory.
## Uncomment the following line to set a custom name.
# WP_SITE_TITLE='Example Title'

## Set WP Admin login details for user 1
WP_USER_NAME='admin'
WP_USER_PASS='password'
WP_USER_EMAIL='admin@example.com'

# Set custom table prefix for WordPress database by uncommenting the following line
# CUSTOM_TABLE_PREFIX='wp_custom_'

# Set search and replace hook to run after a DB import using the `ddev import-db` command
# SET_DB_URL_REPLACE="https://production.com https://local.ddev.site"

## Install Spatie Ray connection files to work with Docker containers
INSTALL_RAY_CONNECTIONS=true

## Install local Git repo and .gitignore file for the project
INSTALL_GIT=true

## Install clean version of WP
INSTALL_CLEAN_WP=true

if $INSTALL_CLEAN_WP; then
  ## Hide default WP Admin dashboard widgets for default user 1
  HIDE_DASHBOARD_WIDGETS=true

  ## Install default official WordPress theme
  INSTALL_DEFAULT_THEME=true
  DEFAULT_THEME_SLUG='twentytwentyfive'

  # Remove default Hello World post
  REMOVE_WP_HELLO_POST=true

  # Remove default Sample Page
  REMOVE_WP_SAMPLE_PAGE=true

  # Remove default Privacy Policy draft page
  REMOVE_WP_PRIVACY_DRAFT=true

  # Update the WP permalinks to use the post name
  SET_POSTNAME_PERMALINKS=true

  ## Create a new page titled 'Homepage' and set it to be the site's front page
  CREATE_HOMEPAGE=true
fi

## Add WP configurations
ADD_WP_CONFIG_SETTINGS=true

if $ADD_WP_CONFIG_SETTINGS; then
  ## Set WP debug settings
  WP_DEBUG_VALUE=true
  WP_DEBUG_DISPLAY_VALUE=false
  WP_DEBUG_LOG_VALUE='logs/wp-errors.log'
  SCRIPT_DEBUG_VALUE=true

  ## Set WP environment settings
  WP_DEVELOPMENT_MODE_VALUE='theme'
  WP_ENVIRONMENT_TYPE_VALUE='local'
fi

## Install CassidyWP Starter Block Theme
INSTALL_STARTER_THEME=false
STARTER_THEME_SLUG='cassidywp-starter-block-theme'

## Install WP plugins
INSTALL_QUERY_MONITOR_PLUGIN=false
INSTALL_AIOM_PLUGIN=false # All-in-One WP Migration plugin
INSTALL_LOCAL_AIOMUE_PLUGIN=false # All-in-One WP Migration Unlimited Extension plugin from local machine
LOCAL_AIOMUE_PATH='/Users/Jacob/Projects/Assets/Packages/WordPress/Plugins/All In One Migration Unlimited Extension/all-in-one-wp-migration-unlimited-extension_2.65.zip'
