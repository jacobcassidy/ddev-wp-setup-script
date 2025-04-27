#!/bin/bash

# DETAILS

## Your WP site name. Defaults to the project name taken from the project directory.
## Uncomment the following line to set a custom name.
# WP_SITE_TITLE='Example Title'

## WP Admin login details for user 1
WP_USER_NAME='example-name'
WP_USER_PASS='example-password'
WP_USER_EMAIL='example-email@example.com'

## Theme Slugs
DEFAULT_THEME_SLUG='twentytwentyfive'
STARTER_THEME_SLUG='cassidywp-starter-block-theme'

## Local path to the All-in-One WP Migration Unlimited Extension plugin zip file.
## Not used unless INSTALL_LOCAL_AIOMUE_PLUGIN is set to true.
LOCAL_AIOMUE_PATH='/Users/Jacob/Projects/Assets/Packages/WordPress/Plugins/All In One Migration Unlimited Extension/all-in-one-wp-migration-unlimited-extension_2.65.zip'

# SETTINGS - Turn settings on/off with true/false values

## DEBUGGING
### Add WordPress debugging and env settings
INSTALL_WP_DEBUG_SETTING=true
### Set values for WP debugging and env settings.
### Only used if INSTALL_WP_DEBUG_SETTING is set to true.
if $INSTALL_WP_DEBUG_SETTING; then
  WP_DEBUG_VALUE=true
  WP_DEBUG_DISPLAY_VALUE=false
  LOG_DIR_VALUE='logs/wp-errors.log'
  SCRIPT_DEBUG_VALUE=true
  WP_ENVIRONMENT_TYPE_VALUE='development'
  WP_DEVELOPMENT_MODE_VALUE='theme'
fi

## FILES
### Install Spatie Ray connection files to work with Docker containers
INSTALL_RAY_CONNECTIONS=true
### Install local Git repo and .gitignore file for the project
INSTALL_GIT=true

## PLUGINS
### Install All-in-One WP Migration plugin
INSTALL_AIOM_PLUGIN=true
### Install All-in-One WP Migration Unlimited Extension plugin from local machine zip file
INSTALL_LOCAL_AIOMUE_PLUGIN=false
### Install Query Monitor plugin
INSTALL_QUERY_MONITOR_PLUGIN=true

## THEMES
### Install official Default WordPress Theme
INSTALL_DEFAULT_THEME=true
### Install CassidyWP Starter Block Theme
INSTALL_STARTER_THEME=true

## WIDGETS
### Hide default WordPress dashboard widgets for user 1
HIDE_DASHBOARD_WIDGETS=true
