# DDEV WordPress Setup Script

Use this installation script to setup your initial WordPress environment with DDEV.

## Features

This script automatically sets up the following:

- Configures and starts the [DDEV](https://ddev.com/) Docker containers for a WordPress development environment.
- Installs a clean WordPress site with the default pages, posts, comments, plugins, and themes removed (with the exception of the latest official default theme as a fallback).
- Downloads, installs, and activates the [CassidyWP Starter Block Theme](https://github.com/jacobcassidy/cassidywp-starter-block-theme).
- Installs the [All-in-One WP Migration plugin](https://wordpress.org/plugins/all-in-one-wp-migration/).
- Installs the [All-in-One WP Migration Unlimited Extension plugin](https://servmask.com/products/unlimited-extension).
  - _Note: this plugin is not free and is sourced from your local machine since it's unavailable through the official WP plugin directory. You can turn the installation off in the `config.sh` file if you don't have this plugin._
- Installs the files needed to connect the DDEV Docker containers with the [Spatie Ray](https://myray.app/) desktop app for simple debugging.
- Initializes a local project Git repo and adds a `.gitignore` file.
- Adds a VSCode Workspace `.vscode/settings.json` file to include formatting rules to match WordPress's official coding standards.

## Getting Started

> Note: [DDEV](https://ddev.com/) needs to be installed in order for the install script to work.

1. Clone the [ddev-wp-setup-script repo](https://github.com/jacobcassidy/ddev-wp-setup-script) to your (preferably empty) project root directory, with: `git clone git@github.com:jacobcassidy/ddev-wp-setup-script.git`.

2. Update the settings in the `ddev-wp-setup-script/config.sh` file:

   - Add your WordPress user details.
   - Turn off any settings you don't want installed by simply changing the `true` value to `false`. Settings that can be turned off include:
     - VSCode Workspace settings
     - Ray app connection files
     - All-in-One Migration plugins
     - Git

3. In you project's root directory, run: `ddev-wp-setup-script/install.sh`. This will install all the files and you'll be ready to begin development.

4. Optional: delete the `ddev-wp-setup-script` directory after running the `install.sh` script successfully from your project's root directory, as it's no longer needed after the initial setup.

## Found An Issue?

If you come across any issues, please report them [here](https://github.com/jacobcassidy/ddev-wp-setup-script/issues).
