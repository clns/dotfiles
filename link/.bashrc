# ~/.bashrc: executed by bash(1) for non-login shells
# with an exception on Mac OS X where .bash_profile is called each time.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
