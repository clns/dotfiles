# https://github.com/Bash-it/bash-it

export BASH_IT="$HOME/.bash_it"
if [ -e "$BASH_IT/bash_it.sh" ]; then

    # Your place for hosting Git repos. I use this for private repos.
    export GIT_HOSTING='clns@github.com'

    # Don't check mail when opening terminal.
    unset MAILCHECK

    # Load Bash It
    source $BASH_IT/bash_it.sh
fi
