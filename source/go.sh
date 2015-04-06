if is_osx && formula_exists 'go'; then
    export GOPATH=$HOME/go
    path_add "/usr/local/opt/go/libexec/bin"
    path_add "$GOPATH/bin" || true
elif is_ubuntu && [ -d "/usr/local/go" ]; then
    export GOPATH=$HOME/go
    path_add "$GOPATH/bin" || true
fi
