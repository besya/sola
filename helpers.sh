#!/bin/bash

# Color definitions
GREEN='\033[0;32m'
LIGHT_GREEN='\033[1;32m'
RED='\033[0;31m'
LIGHT_RED='\033[1;31m'
BLUE='\033[0;34m'
LIGHT_BLUE='\033[1;34m'
YELLOW='\033[1;33m'
DARK_YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
LIGHT_PURPLE='\033[1;35m'
CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
BLACK='\033[0;30m'
LIGHT_BLACK='\033[1;30m'
NC='\033[0m' # No Color
ARROW="▸"

spin() {
    local command="$1"
    local label="$2"
    local spinner=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local pid

    eval "$command" &>/tmp/spin.log & pid=$!

    local i=0
    while kill -0 $pid 2>/dev/null; do
        printf "\r${label} ${spinner[i]}"
        i=$(( (i + 1) % ${#spinner[@]} ))
        sleep 0.1
    done

    wait $pid
    status=$?
    printf "\r${label} ${GREEN}Done${NC}                \n"

    return $status
}

package_version() {
    local package="$1"
    local flag="$2"
    ${package} ${flag} | head -n 1
}

package_install() {
    local package="$1"
    local flag="$2"

    local label="🍺 ${CYAN}${package}${NC} ${ARROW}"

    if command -v ${package} > /dev/null 2>&1; then
        printf "${label} ${BLUE}Exist${NC}\n"
    else
        spin "brew install ${package}" "${label}"
    fi
}

mise_use() {
    local language="$1"
    local version="$2"
    local label="🪄 ${LIGHT_CYAN}${language}@${version}${NC} ${ARROW}"
    spin "mise use --global --quiet --yes ${language}@${version}" "${label}"
}

mise_x() {
    local language="$1"
    local command="$2"
    local extras="$3"
    local label="🛠️  ${BLUE}${language} | ${command}${NC} ${ARROW}"
    spin "mise x --quiet --yes ${language} -- ${command} ${extras}" "${label}"
}


# Function to show a spinner
# DEPRECATED
spinner() {
    local pid=$1
    local delay=0.1
    local spinner="|/-\\"

    while kill -0 $pid 2>/dev/null; do
        for i in $(seq 0 3); do
            printf "\r${spinner:i:1} Running..."
            sleep $delay
        done
    done
    printf "\rDone!             \n"
}
