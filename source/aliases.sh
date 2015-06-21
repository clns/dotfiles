# `z <dir>` - cd to a directory from ~/Projects/
_z() {
    cd "$HOME/Projects/$1"
}
alias z=_z
_z_completion() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=($(compgen -W "$(ls -ap $HOME/Projects/ | grep -E '^[^.]{2}.*/')" -- ${cur}))
    return 0
}
complete -F _z_completion -o nospace z
