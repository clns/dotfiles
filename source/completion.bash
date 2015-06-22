# http://www.debian-administration.org/article/317/An_introduction_to_bash_completion_part_2
_dotfiles() {
    # Pointer to current and prev completion words
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    COMPREPLY=() # Array variable storing the possible completions.
    local commands="help link copy bashit update install hub-as-git"

    if [ $COMP_CWORD == 1 ] || ([ $COMP_CWORD == 2 ] && [[ ${prev} == -* ]]); then
        COMPREPLY=($(compgen -W "${commands}" -- ${cur}))
        return 0
    fi

    case "${prev}" in
        install)
            local args="not implemented"
            for inst in $DOTFILES/install/[!_]*.sh; do
                inst=$(basename "$inst"); args=$(echo "$args ${inst%.*}")
            done
            COMPREPLY=( $(compgen -W "${args}" -- ${cur}) )
            return 0
      		;;
        hub-as-git)
            local args="on off"
            COMPREPLY=( $(compgen -W "${args}" -- ${cur}) )
            return 0
            ;;
        help)
            local args="hub"
            COMPREPLY=( $(compgen -W "${args}" -- ${cur}) )
            return 0
            ;;
    esac

    return 0
}
complete -F _dotfiles dotfiles

_z_completion() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local dir=$(dirname "${cur}a")/
    if [ "$dir" = "./" ]; then dir=; fi
    local file=$(basename "$cur")
    if [ "$file/" = "$dir" ]; then file=; fi
    COMPREPLY=($(compgen -W "$(cd $HOME/Projects && ls -adF $dir* | grep -E '/$')" -- ${dir}${file}))
    return 0
}
complete -F _z_completion -o nospace z
