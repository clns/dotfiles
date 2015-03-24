# Useful functions

# Logging stuff.
function log_header()   { echo -e "\033[1m== $@ ==\033[0m"; }
function log_success()  { echo -e "\033[0;32m✔ $@\033[0m"; }
function log_error()    { echo -e "\033[0;31m✖ $@\033[0m" 1>&2; }
function log_warning()  { echo -e "\033[0;33m$@\033[0m"; }
function log_arrow()    { echo -e "\033[0;34m➜\033[0m $@"; }

# Test whether a command exists.
# Args: $1 - cmd to test
function cmd_exists() {
if [[ $(type -P $1) ]]; then
    return 0
fi
return 1
}

# Test whether a Homebrew formula exists.
# Args: $1 - formula name to test (may include options)
function formula_exists() {
if $(brew list $1 > /dev/null); then
    return 0
fi
return 1
}

# OS detection
function is_osx() {
[[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
[[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}

# Prompt for user confirmation.
# Usage:
#
#   prompt "You are about to do some stuff."
#   if is_confirmed; then echo "confirmed!"; fi
#
function prompt() {
log_warning "$@"
read -p "Proceed? (y/n): " -n 1
echo
}
function is_confirmed() {
[[ $REPLY =~ ^[Yy]$ ]] || return 1
}

# Check if array contains value.
# Usage:
#
#   in_array $REQUIREMENTS 'brew' && echo "is in array"
#
function in_array() {
local needle="$1"
shift
local haystack=$@
(echo $haystack | grep -o $needle > /dev/null) || return 1
}
