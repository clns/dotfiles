# OS X stuff only.
is_osx || return 1

# Install Homebrew
if ! cmd_exists 'brew'; then
    log_header "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    log_arrow "Homebrew is installed"
fi

# Exit if failed to install
cmd_exists 'brew' || (log_error "Homebrew failed to install" && return 1)

if ! has_flag '-q'; then
    log_header "Updating Homebrew"
    brew update
    brew doctor
fi

if has_flag '-u'; then
    log_header "Upgrading Homebrew packages"
    brew upgrade
    brew cleanup
fi
