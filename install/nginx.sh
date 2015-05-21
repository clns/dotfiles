if is_ubuntu && ! cmd_exists 'nginx'; then
    # Install nginx on Ubuntu
    if ! apt_repository_exists 'nginx/stable'; then
        sudo add-apt-repository -y ppa:nginx/stable # Nginx repository
        sudo apt-get update
    fi

    prompt "Install nginx."
    if ! is_confirmed; then return 0; fi

    sudo apt-get install -y nginx
elif cmd_exists 'nginx'; then
    log_arrow 'Nginx is installed'
fi
