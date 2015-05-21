# OS X stuff only.
is_osx || return 1

# Install MacVim
if ! formula_exists 'macvim'; then
    prompt "Install macvim."
    if is_confirmed; then
        brew install macvim --with-lua
    fi
else
    log_arrow "MacVim is installed"
fi
