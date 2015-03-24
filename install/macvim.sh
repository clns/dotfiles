# OS X stuff only.
is_osx || return 1

# Install MacVim
if ! formula_exists 'macvim'; then
    brew install macvim --with-lua
else
    log_arrow "MacVim is installed"
fi
