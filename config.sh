#!/bin/bash

# Your WP site name
WP_SITE_TITLE=$PROJECT_TITLE

# Your WP login details
WP_USER_NAME='example-name'
WP_USER_PASS='example-password'
WP_USER_EMAIL='dev@example.com'

# Theme Slugs
DEFAULT_THEME_SLUG='twentytwentyfive'
CUSTOM_THEME_SLUG='cassidywp-starter-block-theme'

# Environment Settings
WP_ENVIRONMENT_TYPE='development'
WP_DEVELOPMENT_MODE='theme'

# TURN ON/OFF OTHER ASSETS:

## All-in-One WP Migration plugin
INSTALL_AIOM_PLUGIN=true

## All-in-One WP Migration Unlimited Extension plugin from local machine
INSTALL_LOCAL_AIOMUE_PLUGIN=true

## Spatie Ray connection files to work with Docker containers
INSTALL_RAY_CONNECTIONS=true

## VSCode workspace settings to follow WordPress coding standards
INSTALL_VSCODE_SETTINGS=true

## Local Git repo and .gitignore file for the project
INSTALL_GIT=true

## WordPress debugging settings with log file
INSTALL_WP_DEBUG_SETTING=true
