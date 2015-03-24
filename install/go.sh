# Install go

if is_osx && ! formula_exists 'go'; then
    brew install go
elif is_ubuntu; then
    log_error "TODO: implement this for Ubuntu"
    # sudo apt-get install golang
    exit 1
else
    log_arrow "Go is installed"
fi
