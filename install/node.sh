log_warning "TODO: install node.js"

# Install/update npm
if ! npm_exists "npm" "-g" || has_flag '-u'; then
    prompt "Install/update npm"
    if is_confirmed; then
        npm install npm -g
    fi
elif npm_exists "npm" "-g"; then
    log_arrow "$(npm ls npm -g | grep npm) is installed"
fi

# Install/update flow-bin
if ! npm_exists "flow-bin" "-g" || has_flag '-u'; then
    prompt "Install/update flow-bin."
    if is_confirmed; then
        npm install flow-bin -g
    fi
elif npm_exists "flow-bin" "-g"; then
    log_arrow "$(npm ls flow-bin -g | grep flow-bin) is installed"
fi
