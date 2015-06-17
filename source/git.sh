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
