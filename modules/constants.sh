# Host machine directories.
SCRIPT_DIR='ddev-wp-setup-script'
MODULES_DIR="${SCRIPT_DIR}/modules"
FILES_DIR="${SCRIPT_DIR}/files"
PROJECT_DIR=$(pwd)

# Get the project name from the project directory,
# minus the leading `~` and trailing `.ddev.site`, if any.
PROJECT_NAME=$(basename "$PROJECT_DIR" | sed 's:^~::;s:\.ddev\.site$::')

# Terminal Base Colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Terminal Bright Colors
BRIGHT_BLACK='\033[1;30m'
BRIGHT_RED='\033[1;31m'
BRIGHT_GREEN='\033[1;32m'
BRIGHT_YELLOW='\033[1;33m'
BRIGHT_BLUE='\033[1;34m'
BRIGHT_MAGENTA='\033[1;35m'
BRIGHT_CYAN='\033[1;36m'
BRIGHT_WHITE='\033[1;37m'

# Terminal Format
ITALIC='\033[3m'
BOLD='\033[1m'
RESET='\033[0m'
