# Exit immediately if a command exits with a non-zero status
set -e

AVAILABLE_LANGUAGES=("Ruby" "Rails" "Python" "Elixir" "Go" "Node.js")
SELECTED_LANGUAGES="Ruby","Rails"

# Helpers
source $ROOT/helpers.sh

printf "\nSystem libraries\n"

# Homebrew
if command -v brew > /dev/null 2>&1; then
    spin "brew update && brew upgrade" "⚙️  ${CYAN}brew${NC} ${ARROW}"
else
    echo "|> Installing"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "|> Version | $(package_version "brew" "--version")"
fi

# System
package_install "gum" "-v"
package_install "git" "-v"
package_install "unzip" "-v"
package_install "libyaml" "-v"
package_install "mise" "-v"

# Activate mise in zsh
# echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
# eval "$(mise activate zsh)"

# brew install fzf ripgrep bat eza zoxide plocate btop fd tlrc

printf "\nLanguages\n"

# Languages
languages=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --selected "$SELECTED_LANGUAGES" --height 10 --header "Select programming languages")

if [[ -n "$languages" ]]; then
    for language in $languages; do
        case $language in
            Ruby)
                mise_use "ruby" "latest"
                ;;
            Rails)
                mise_x "ruby" "gem install rails" "--quiet --no-document"
                ;;
            Python)
                mise_use "python" "latest"
                ;;
            Elixir)
                mise_use "erlang" "latest"
                mise_use "elixir" "latest"
                mise_x "elixir" "mix local.hex" "--quiet --force"
                ;;
            Go)
                mise_use "go" "latest"
                ;;
            Node.js)
                mise_use "node" "lts"
                ;;
        esac
    done
else
    echo "No languages are selected for install"
fi

printf "\nApplications\n"

# Applications
package_install "zed"

package_install "wezterm"
cp -r $ROOT/config/wezterm ~/.config
# brew search nerd-font
# wezterm ls-fonts --list-system
# wezterm ls-fonts --list-system | grep GoMono

package_install "starship"
cp -r $ROOT/config/starship ~/.config

package_install "zsh-syntax-highlighting zsh-autosuggestions"

mv ~/.zshrc ~/.zshrc.before-install-sola.bak
cp $ROOT/config/zshrc ~/.zshrc
