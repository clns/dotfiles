_dotfiles() {
    # Pointer to current and prev completion words
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    COMPREPLY=() # Array variable storing the possible completions.
    local commands="help link copy bashit update install"

    if [ $COMP_CWORD == 1 ] || ([ $COMP_CWORD == 2 ] && [[ ${prev} == -* ]]); then
        COMPREPLY=($(compgen -W "${commands}" -- ${cur}))
        return 0
    fi

    case "${prev}" in
        install)
            local args="not implemented"
            COMPREPLY=( $(compgen -W "${args}" -- ${cur}) )
            return 0
      			;;
    esac

    return 0
}
complete -F _dotfiles dotfiles

_testCustomCompl() { #  By convention, the function name starts with an underscore
    local cur prev

    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}" # Pointer to current completion word
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    case "$cur" in
        cl*)
            # COMPREPLY=("https://github.com/")
            COMPREPLY=( $(compgen -W "https://github.com/clns/") )
        ;;
        *)
            COMPREPLY=( $(compgen -W "https://github.com/" -- "$cur") )
        ;;
    esac

    return 0
}

# complete -o bashdefault -o default -o nospace -F _github git

complete -o default -o nospace -W "https://github.com/clns/" gcl
