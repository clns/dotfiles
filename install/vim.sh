# Install Vim (Linux only, we use MacVim for OS X)
if is_ubuntu; then
    log_error "TODO: implement this for Ubuntu"
    return 0
fi

# Install go-deps
if formula_exists 'go'; then
    if is_osx; then
        if ! formula_exists 'ctags'; then
            brew install ctags
        else
            log_arrow "ctags is installed"
        fi
    elif is_ubuntu; then
        log_error "TODO: implement this for Ubuntu"
        return 0
    fi
    u=""
    if has_flag '-u'; then
        u=" -u"
    fi
    go get$u github.com/jstemmer/gotags
    log_arrow "github.com/jstemmer/gotags is$u installed"
fi
