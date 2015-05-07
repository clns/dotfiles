# .bashrc is executed every time a terminal window is opened
# with an exception on Mac OS X where .bash_profile is called each time.

# Add binaries into the path
export DOTFILES=~/.dotfiles
export PATH=$PATH:$DOTFILES/bin

# Prevent OS X's tar to add ._* hidden files when creating archives
# http://superuser.com/a/61188
export COPYFILE_DISABLE=1

# Source all files in "source"
function src() {
local file
if [[ "$1" ]]; then
    source "$DOTFILES/source/$1.sh"
else
    for file in $DOTFILES/source/*; do
        source "$file"
    done
fi
}

src
