# DDEV WordPress Setup Script

This installation script automatically sets up a development Docker server with DDEV and installs a WordPress site with clean defaults on that server.

## Quick Start

_Note: [DDEV](https://ddev.com/) needs to be installed in order for the installation script to work._

1. Clone this [repo](https://github.com/jacobcassidy/ddev-wp-setup-script) to your (preferably empty) project's root directory with the command: **`git clone git@github.com:jacobcassidy/ddev-wp-setup-script.git`**
2. Customize the configuration settings in: _ddev-wp-setup-script/config.sh_
3. Run the installation script in you project's root directory with the command: **`ddev-wp-setup-script/install.sh`**
4. Delete the _ddev-wp-setup-script_ directory after successfully running the installation script

## Features

This script automatically sets up the following:

-   Configures and starts the [DDEV](https://ddev.com/) Docker containers with a WordPress development server.
-   Installs a clean WordPress site with the default pages, posts, comments, plugins, themes, welcome panel and dashboard widgets removed (with the exception of the latest official default theme as a fallback).
-   Downloads, installs, and activates the [CassidyWP Starter Block Theme](https://github.com/jacobcassidy/cassidywp-starter-block-theme).
-   Installs the [All-in-One WP Migration plugin](https://wordpress.org/plugins/all-in-one-wp-migration/).
-   Installs the [All-in-One WP Migration Unlimited Extension plugin](https://servmask.com/products/unlimited-extension).
    -   _Note: this plugin is not free and is sourced from your local machine since it's unavailable through the official WP plugin directory. If you don't have this plugin, you can turn the installation off in the `config.sh` file by setting `INSTALL_LOCAL_AIOMUE_PLUGIN` to false._
-   Installs the [Query Monitor plugin](https://wordpress.org/plugins/query-monitor/).
-   Installs the files needed to connect the DDEV Docker containers with the [Spatie Ray](https://myray.app/) desktop app (used for simple debugging when Xdebug is overkill).
-   Initializes a local project Git repo and adds a `.gitignore` file configured for WordPress.
-   Adds a VSCode Workspace `.vscode/settings.json` file to include formatting rules to match WordPress's official coding standards.

## Found an Issue?

If you come across any issues, please report them [here](https://github.com/jacobcassidy/ddev-wp-setup-script/issues).
