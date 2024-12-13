# Exit immediately if a command exits with a non-zero status
set -e

# Helpers
ROOT=~/.local/share/sola
source $ROOT/helpers.sh

echo "Uninstalling..."

if command -v brew > /dev/null 2>&1; then
    spin "brew uninstall --force zed" "Applications ${ARROW}"
fi

if command -v mise > /dev/null 2>&1; then
    spin "mise uninstall --all" "Languages ${ARROW}"
    sed -i '' '/eval "$(mise activate zsh)"/d' ~/.zshrc
fi

if command -v brew > /dev/null 2>&1; then
    spin "brew uninstall --force mise libyaml unzip git gum" "Libraries ${ARROW}"
fi
