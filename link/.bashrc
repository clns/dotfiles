# ~/.bashrc: executed by bash(1) for non-login shells
# with an exception on Mac OS X where .bash_profile is called each time.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add binaries into the path
export DOTFILES=$HOME/.dotfiles
export PATH=$PATH:$DOTFILES/bin

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
