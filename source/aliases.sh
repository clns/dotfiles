# `z <dir>` - cd to a directory from ~/Projects/
_z() {
    cd "$HOME/Projects/$1"
}
alias z=_z

# docker cleanup commands
# http://blog.stefanxo.com/2014/02/clean-up-after-docker/
alias dockercleancontainers="docker ps -a -notrunc| grep 'Exit' | awk '{print \$1}' | xargs docker rm"
alias dockercleanimages="docker images -a -notrunc | grep none | awk '{print \$3}' | xargs docker rmi"
alias dockerclean="dockercleancontainers && dockercleanimages"
