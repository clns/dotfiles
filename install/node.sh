# Install node.js

if is_osx && ! formula_exists 'node'; then
    log_warning "TODO: Install node.js"
elif is_ubuntu && ! cmd_exists 'node'; then
    prompt "Install node.js"
    if is_confirmed; then
        NODE_VERSION="0.12.2"
        cd /tmp
        wget "http://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz"
        sudo tar -C /usr/local -xzf node-v${NODE_VERSION}-linux-x64.tar.gz
        sudo mv "/usr/local/node-v${NODE_VERSION}-linux-x64" "/usr/local/node"
        rm node-v${NODE_VERSION}-linux-x64.tar.gz
        if path_add "/usr/local/node/bin"; then
            echo "PATH=$PATH" >> ~/.bashrc
        fi
        sudo ln -s /usr/local/node/bin/node /usr/bin/node
        sudo ln -s /usr/local/node/lib/node /usr/lib/node
        sudo ln -s /usr/local/node/bin/npm /usr/bin/npm
    fi
else
    log_arrow "Node is installed"
fi

# Install/update npm
if ! npm_exists "npm" "-g" || has_flag '-u'; then
    prompt "Install/update npm"
    if is_confirmed; then
        sudo npm install npm -g

        # For some reason ~/.npm/_locks has root:root instead of current user
        # Fix the chown here but might looks into the root problem later
        sudo chmod $(whoami):$(whoami) -R ~/.npm
    fi
elif npm_exists "npm" "-g"; then
    log_arrow "$(npm ls npm -g | grep npm) is installed"
fi

# Install/update flow-bin
if ! npm_exists "flow-bin" "-g" || has_flag '-u'; then
    prompt "Install/update flow-bin."
    if is_confirmed; then
        sudo npm install flow-bin -g
    fi
elif npm_exists "flow-bin" "-g"; then
    log_arrow "$(npm ls flow-bin -g | grep flow-bin) is installed"
fi
