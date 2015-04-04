if is_osx && formula_exists 'go'; then
    export GOPATH=$HOME/go
    export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin
elif is_ubuntu; then
    log_error "TODO: implement this for Ubuntu"
fi
