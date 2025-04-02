# Host machine directories.
PROJECT_DIR=$(pwd)

# Get the project name from the project directory, minus any leading
# non-alphanumeric characters and trailing `.ddev.site`.
PROJECT_NAME=$(basename "$PROJECT_DIR" | sed 's:^[^a-zA-Z0-9]*::;s:\.ddev\.site$::')

# Replace any $PROJECT_NAME hyphens with spaces and capitalize the first letter of each word.
PROJECT_TITLE=$(echo "$PROJECT_NAME" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))} 1')

# Replace any $PROJECT_NAME spaces with hyphens and convert to lowercase.
PROJECT_NAME_SLUG=$(echo "$PROJECT_NAME" | sed 's/[[:space:]]/-/g' | tr '[:upper:]' '[:lower:]')

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
