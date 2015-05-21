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

# Check if a given npm package is installed
# Params:
#   $1 - the npm package name (eg. "flow-bin")
#   $2... - args to pass to npm
#
# Usage:
#
#   npm_exists "flow-bin"
#   npm_exists "flow-bin" "-g"
#
function npm_exists() {
    local pkg=$1; shift
    npm ls "$pkg" "$@" &>/dev/null || return 1
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
    if [[ $(declare -f has_flag) ]] && has_flag '-y'; then
        echo "Proceed since '-y' was given."
    else
        read -p "Proceed? (y/n): " -n 1
    fi
    echo
}
function is_confirmed() {
    if [[ $(declare -f has_flag) ]] && has_flag '-y'; then
        return 0
    fi
    [[ $REPLY =~ ^[Yy]$ ]] || return 1
}

# Check if array contains value.
# Usage:
#
#   in_array $name ${array[@]} && echo "is in array"
#
function in_array() {
    local needle="$1"; shift
    local el
    for el in "$@"; do
        [[ $el == $needle ]] && return 0
    done
    return 1
}

# Working with command flags and parameters.
# http://www.shelldorado.com/goodcoding/cmdargs.html
#
# parse_arguments() parses the command arguments for future use.
#
# Params:
# $1 - the count of the OPTIONS array (should be even)
# $2 - the OPTIONS array
# $3 - the command arguments ($@)
#
# Usage:
#
#   OPTIONS=('-h' 'Display this help' '-q' 'Enable quiet/quick mode')
#   parse_arguments "${#OPTIONS[@]}" "${OPTIONS[@]}" $@
#
#   # then you can use the following functions:
#   has_flag '-h'
#   has_param 'file'
#
#   # also after calling parse_arguments() the following
#   # arrays are populated: $FLAGS $PARAMS
#
FLAGS=()
PARAMS=()
function parse_arguments() {
    FLAGS=(); PARAMS=()
    local opts_no=$(($1/2)); shift
    local opts=() i

    # Store all possible options in opts
    for ((i=0; i<opts_no; i++)); do
        opts+=($1)
        shift; shift # discard next param as it is used for help
    done

    # Parse each arg given and populate FLAGS and PARAMS.
    while [ $# -gt 0 ]
    do
        if in_array $1 ${opts[@]}; then
            FLAGS+=($1)
        elif [[ $1 == "--" ]]; then
            shift; break
        elif [[ $1 == -* ]]; then
            echo "parse_arguments: invalid flag $1"
            if [[ $(declare -f help) ]]; then
                help; exit 1
            else
                echo "Consider adding a 'help' function that will be called here."
                exit 1
            fi
        else
            break
        fi
        shift
    done
    # all command line switches are processed,
    # "$@" contains all file names
    PARAMS=($@)
}
# Test if a given flag is available.
# Note: parse_arguments() should be called first.
#
# Params:
# $1 - the flag to test
#
# Usage:
#
#   has_flag '-q' && echo "Quiet mode enabled"
#
function has_flag() {
    in_array $1 ${FLAGS[@]} || return 1
}
# Test if a given parameter is available.
# Note: parse_arguments() should be called first.
#
# Params:
# $1 - the parameter to test
#
# Usage:
#
#   has_param 'file' && echo "'file' given"
#
function has_param() {
    in_array $1 ${PARAMS[@]} || return 1
}

# echo_flags prints the available options contained in an OPTIONS array.
#
# Params:
# $1 - separator between flag and description (usually \t)
# $2 - the OPTIONS array
#
# Usage:
#
#   OPTIONS=('-h' 'Display this help' '-q' 'Enable quiet/quick mode')
#   function help() {
#   cat <<HELP
#   Command description...
#   Usage: $(basename "$0") [options]
#
#   Options:
#   $(echo_flags "\t" "${OPTIONS[@]}")
#
#   HELP
#   exit 0
#   }
#
function echo_flags() {
    local separator=$1; shift
    local values=("$@")
    local i j
    local text=""

    for ((i=0; i<$#; i=$(($i+2)))); do
        j=$(($i+1))
        text+=${values[i]}"$separator"${values[j]}"\n"
    done
    echo -e $text
}

# kill_p kills the given process name
#
# Params:
# $1 - the process to kill (eg. jsx)
#
function kill_p() {
    kill $(ps -A | grep -e $1 | head -1 | awk -F ' ' '{print $1}')
}

# path_add adds a directory to PATH if not already present.
# Note that the directory needs to exist.
# http://superuser.com/a/39995
#
# Usage:
#
#   if path_add "/dir"; then
#     echo $PATH >> ~/.bashrc
#   fi
#
function path_add() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        # adds the dir to the end of the path
        # to put at the beginning use `PATH="$1:$PATH"
        PATH="${PATH:+"$PATH:"}$1"
        return 0
    fi
    return 1
}

# Check if a given apt-repository is already added as a source.
# http://stackoverflow.com/a/12739281/1104534
function apt_repository_exists() {
    grep -h ^deb /etc/apt/sources.list /etc/apt/sources.list.d/* | grep -- $1 || return 1
}

# Export functions
export -f log_header log_success log_error log_warning log_arrow
export -f cmd_exists formula_exists npm_exists
export -f is_osx is_ubuntu
export -f prompt is_confirmed
export -f in_array
export -f parse_arguments has_flag has_param echo_flags
export -f kill_p
export -f path_add
export -f apt_repository_exists
