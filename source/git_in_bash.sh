# http://git-scm.com/book/en/v2/Git-in-Other-Environments-Git-in-Bash

GIT_COMPLETION="$HOME/.git-completion.bash"
GIT_PROMPT="$HOME/.git-prompt.sh"

# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
if [ -e "$GIT_COMPLETION" ]; then
    source "$GIT_COMPLETION"
    complete -o default -o nospace -F _git g
fi

# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
if [ -e "$GIT_PROMPT" ]; then
    source "$GIT_PROMPT"
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_SHOWCOLORHINTS=1
    # export PS1='\w$(__git_ps1 " (%s)")\$ '
    PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'";$PROMPT_COMMAND"
fi
