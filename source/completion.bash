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
