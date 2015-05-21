# Install go

if is_osx && ! formula_exists 'go'; then
    brew install go
elif is_ubuntu && ! cmd_exists 'go'; then
    GO_VERSION="1.4.2"
    cd /tmp
    wget "https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz"
    sudo tar -C "/usr/local" -xzf "go${GO_VERSION}.linux-amd64.tar.gz"
    rm "go${GO_VERSION}.linux-amd64.tar.gz"
    if path_add "/usr/local/go/bin"; then
        echo "PATH=$PATH" >> ~/.bashrc
    fi
else
    log_arrow "Go is installed"
fi
