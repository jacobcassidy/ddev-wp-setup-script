# Changelog for `ddev-wp-setup-script`

## 1.3.4

_2024-11-25_

-   Fixed broken AIOMUE plugin unzip path.
-   Updated `$WP_SITE_TITLE` with default name and override option.

## 1.3.3

_2024-11-25_

-   Added installation option for Query Monitor plugin and AIOMUE local path variable.

## 1.3.2

_2024-11-24_

-   Added boolean install options for default and starter themes.
-   Fixed the `$PROJECT_TITLE` value by using `awk` for capitalizing the first letter of each word.
-   Updated the README to improve ability to quickly scan for the commands.

## 1.3.1

_2024-11-24_

-   Added the `$PROJECT_TITLE` variable.
-   Updated `$WP_SITE_TITLE` to use `$PROJECT_TITLE` variable.

## 1.3.0

_2024-11-24_

-   Added the `PROJECT_NAME_SLUG` variable for the ddev project name, which replaces whitespaces with dashes and uppercase letters with lowercase letters in the `$PROJECT_NAME` variable.
-   Updated `$WP_SITE_TITLE` to use `$PROJECT_NAME` variable.
-   Updated `DEFAULT_THEME_SLUG` value to `twentytwentyfive`.
-   Updated `PROJECT_NAME` logic to remove any leading symbols.
-   Updated cloned git removal message.

## 1.2.0

_2024-11-11_

-   Added `.dev-assets`, `.env` and `vendor` to .gitignore list.
-   Moved `constants.sh` inside `/modules`.

## 1.1.0

_2024-10-06_

-   Fixed WP debugging config settings getting overwritten when restarting DDEV with the addition of `wp-debug-log-setup-module.sh`.
-   Added boolean option for installing WP Debug.
-   Refactored order script are run in.
-   Added `CHANGELOG.md` file.
-   Updated terminal colors used for various messages.
-   Updated the `files/vscode-settings.json` file's CSS and HTML settings for formatting to WordPress Code Standard
-   Renamed and moved `./scripts/script-variables.sh` to `./constants.sh`.
