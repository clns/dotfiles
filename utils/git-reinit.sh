#!/bin/bash

function help () {
echo "Easily re-initialize a git repo, pushing it to the same remote."
echo "usage: ./git-init.sh <path>"
echo
echo "==> Caveats"
echo "All local git configurations are lost except the upstream remote that will be put back."
}

if [ $1 ]; then
	if [ ! -d $1 ]; then
		echo "$1 is not a directory" 1>&2
		exit 1
	fi
	# smart way of expanding the path
	cwd=$(cd $1 && pwd)
	if [ ! -d .git ]; then
		echo "$cwd/.git directory doesn't exist" 1>&2
		exit 1
	fi
	cd $cwd
	remote=$(git remote -v | grep fetch | cut -f 2 | cut -d " " -f 1)

	echo "You are about to re-initialize the repository:"
	echo "path: $cwd"
	echo "remote: $remote"
	read -p "Proceed? (y/n): " -n 1
	echo

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		git submodule --quiet foreach 'cd '$cwd' && rm -rf $path' # delete all submodules
		rm -rf .git
		git init
		git add .
		git commit -m "Initial commit"

		# Put back submodules. This is based on how the git-submodule.sh
		# script itself parses the .gitmodules file.
		# https://github.com/git/git/blob/master/git-submodule.sh#L132
		git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
		while read path_key path
		do
			url_key=$(echo $path_key | sed 's/\.path/.url/')
			url=$(git config -f .gitmodules --get "$url_key")
			git submodule add $url $path
		done

		# Check if there are uncommitted changes (eg. submodules were added)
		# http://stackoverflow.com/a/5143914/1104534
		if ! git diff-index --quiet HEAD --; then
			git commit -m "Add submodules"
		fi

		if [ $remote ]; then
			git remote add origin $remote
			git push -u -f origin master
		fi
	fi
else
	help
fi

exit 0
