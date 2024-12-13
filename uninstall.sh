# Exit immediately if a command exits with a non-zero status
set -e

echo "Uninstalling..."

mise uninstall --all
brew uninstall --force libyaml unzip git curl gum

# source ./uninstall/app-nix.sh

# brew uninstall gum
# brew uninstall curl git unzip

# Run terminal installers
# for installer in ~/.local/share/sola/install/terminal/*.sh; do source $installer; done
