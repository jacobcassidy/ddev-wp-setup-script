# DDEV WordPress Setup Script

Use this installation script to automatically setup a clean WordPress environment with DDEV.

## Getting Started

_Note: [DDEV](https://ddev.com/) needs to be installed in order for the installation script to work._

**Step 1: Clone the repo with `git clone git@github.com:jacobcassidy/ddev-wp-setup-script.git`**

-   You should clone the [repo](https://github.com/jacobcassidy/ddev-wp-setup-script) to your (preferably empty) project root directory.

**Step 2: Update the configuration settings found in `ddev-wp-setup-script/config.sh`**

-   Add your desire WordPress user login details.
-   Turn off any settings you don't want installed by simply changing the `true` value to `false`.
-   Settings that can be turned off include:
    -   VSCode Workspace settings
    -   Ray app connection files
    -   All-in-One Migration plugins
    -   Git

**Step 3: Run the installation script with the command: `ddev-wp-setup-script/install.sh`**

-   Run this command in you project's root directory.
-   This will install all the files and you'll be ready to begin development on your WordPress site.

**Optional Step: Delete the `ddev-wp-setup-script` directory**

-   The `ddev-wp-setup-script` directory is no longer needed after successfully running the install script in step 3.

## Features

This script automatically sets up the following (any of which can be opted-out of by changing the option to false in the config settings):

-   Configures and starts the [DDEV](https://ddev.com/) Docker containers for a WordPress development environment.
-   Installs a clean WordPress site with the default pages, posts, comments, plugins, and themes removed (with the exception of the latest official default theme as a fallback).
-   Downloads, installs, and activates the [CassidyWP Starter Block Theme](https://github.com/jacobcassidy/cassidywp-starter-block-theme).
-   Installs the [All-in-One WP Migration plugin](https://wordpress.org/plugins/all-in-one-wp-migration/).
-   Installs the [All-in-One WP Migration Unlimited Extension plugin](https://servmask.com/products/unlimited-extension).
    -   _Note: this plugin is not free and is sourced from your local machine since it's unavailable through the official WP plugin directory. You can turn the installation off in the `config.sh` file if you don't have this plugin._
-   Installs the [Query Monitor plugin](https://wordpress.org/plugins/query-monitor/).
-   Installs the files needed to connect the DDEV Docker containers with the [Spatie Ray](https://myray.app/) desktop app for simple debugging.
-   Initializes a local project Git repo and adds a `.gitignore` file.
-   Adds a VSCode Workspace `.vscode/settings.json` file to include formatting rules to match WordPress's official coding standards.

## Found An Issue?

If you come across any issues, please report them [here](https://github.com/jacobcassidy/ddev-wp-setup-script/issues).
