# Changelog for `ddev-wp-setup-script`

## 1.2.0

_2024-11-11_

- Added `.dev-assets`, `.env` and `vendor` to .gitignore list.

## 1.1.0

_2024-10-06_

-   Fixed WP debugging config settings getting overwritten when restarting DDEV with the addition of `wp-debug-log-setup-module.sh`.
-   Added boolean option for installing WP Debug.
-   Refactored order script are run in.
-   Added `CHANGELOG.md` file.
-   Updated terminal colors used for various messages.
-   Updated the `files/vscode-settings.json` file's CSS and HTML settings for formatting to WordPress Code Standard
-   Renamed and moved `./scripts/script-variables.sh` to `./constants.sh`.
