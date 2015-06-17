# .bashrc is executed every time a terminal window is opened
# with an exception on Mac OS X where .bash_profile is called each time.

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
