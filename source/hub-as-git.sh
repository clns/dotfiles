# Alias 'hub' to 'git'
# https://github.com/github/hub#aliasing
if [ $(command -v 'hub') ]; then
    eval "$(hub alias -s)"
fi
