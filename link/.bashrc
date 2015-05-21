# .bashrc is executed every time a terminal window is opened
# with an exception on Mac OS X where .bash_profile is called each time.

# Add binaries into the path
export DOTFILES=$HOME/.dotfiles
export PATH=$PATH:$DOTFILES/bin

# Prevent OS X's tar to add ._* hidden files when creating archives
# http://superuser.com/a/61188
export COPYFILE_DISABLE=1


# https://github.com/Bash-it/bash-it

export BASH_IT="$HOME/.bash_it"
if [ -d "$BASH_IT" ]; then

    # Your place for hosting Git repos. I use this for private repos.
    export GIT_HOSTING='clns@github.com'

    # Don't check mail when opening terminal.
    unset MAILCHECK

    # Load Bash It
    source $BASH_IT/bash_it.sh
fi

# Source all files in "source"
function src() {
local file
if [[ "$1" ]]; then
    source "$DOTFILES/source/$1"
else
    for file in $DOTFILES/source/*.{sh,bash}; do
        if [ -e "$file" ]; then
            source "$file"
        fi
    done
fi
}

src

# http://git-scm.com/book/en/v2/Git-in-Other-Environments-Git-in-Bash
# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
if [[ $(declare -f "__git_complete") ]]; then
    __git_complete g __git_main
fi
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
if [[ $(declare -f "__git_ps1") ]]; then
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_SHOWCOLORHINTS=1
    # export PS1='\w$(__git_ps1 " (%s)")\$ '
    PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'";$PROMPT_COMMAND"
fi
