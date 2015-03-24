#!/usr/bin/env bash

function help() {
cat <<HELP
Download and extract a GitHub repository tarball to a specified location on disk (no cloning).
Usage: ~/.dotfiles/utils/$(basename "$0") <user/repository> <path>

Arguments:
  user/repository   The GitHub user and repository to download, eg. 'clns/dotfiles'
  path              The path on disk to extract the tarball, eg. '~/.dotfiles'

HELP
exit 0
}

# Show help
[[ $1 && $2 ]] || help

if [ -e $2 ]; then
    log_error "$2 already exists"
    exit 1
fi

repo="https://github.com/$1/tarball/master"
mkdir -p $2

echo "Downloading ${repo} to $2"
curl -fsSL $repo | tar -xzC $2 --strip-components 1
