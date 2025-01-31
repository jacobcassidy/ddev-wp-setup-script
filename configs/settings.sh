#!/bin/bash

# Your WP site name. Defaults to the project name taken from the project directory.
# Uncomment the following line to set a custom name.
# WP_SITE_TITLE='Example'

# Your WP login details
WP_USER_NAME='example-name'
WP_USER_PASS='example-password'
WP_USER_EMAIL='dev@example.com'

# Theme Slugs
DEFAULT_THEME_SLUG='twentytwentyfive'
STARTER_THEME_SLUG='cassidywp-starter-block-theme'

# Local path to the All-in-One WP Migration Unlimited Extension plugin zip file.
# If you don't have this plugin, set `INSTALL_LOCAL_AIOMUE_PLUGIN` to false.
LOCAL_AIOMUE_PATH='/Users/Jacob/Projects/Assets/Packages/WordPress/Plugins/All In One Migration Unlimited Extension/all-in-one-wp-migration-unlimited-extension_2.59.zip'

# Turn settings on/off with true/false values:

## THEMES

### Installs official Default WordPress Theme
INSTALL_DEFAULT_THEME=true

### Installs CassidyWP Starter Block Theme
INSTALL_STARTER_THEME=true

## PLUGINS

### Installs All-in-One WP Migration plugin
INSTALL_AIOM_PLUGIN=true

### Installs All-in-One WP Migration Unlimited Extension plugin from local machine zip file
INSTALL_LOCAL_AIOMUE_PLUGIN=true

### Installs Query Monitor plugin
INSTALL_QUERY_MONITOR_PLUGIN=true

## WIDGETS

### Hides default WordPress dashboard widgets for user 1
HIDE_DASHBOARD_WIDGETS=true

## FILES

### Installs Spatie Ray connection files to work with Docker containers
INSTALL_RAY_CONNECTIONS=true

### Installs VSCode workspace settings file to follow WordPress coding standards
INSTALL_VSCODE_SETTINGS=true

### Installs local Git repo and .gitignore file for the project
INSTALL_GIT=true

## DEBUGGING

### Adds WordPress debugging and env settings
INSTALL_WP_DEBUG_SETTING=true

### Set values for WP debugging and env settings
if $INSTALL_WP_DEBUG_SETTING; then
  WP_DEBUG_VALUE=true
  WP_DEBUG_DISPLAY_VALUE=false
  LOG_DIR_VALUE='log/wp-errors.log'
  SCRIPT_DEBUG_VALUE=true
  WP_ENVIRONMENT_TYPE_VALUE='development'
  WP_DEVELOPMENT_MODE_VALUE='theme'
fi
