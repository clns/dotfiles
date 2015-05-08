#!/bin/sh

# `tree` command
#
# http://mama.indstate.edu/users/ice/tree/

script_name=tree.sh
script_tmp=tree-install-$$.sh

if [ "x$0" = "xsh" ]; then
  # run as curl | sh
  # on some systems, you can just do cat>npm-install.sh
  # which is a bit cuter.  But on others, &1 is already closed,
  # so catting to another script file won't do anything.
  # Follow Location: headers, and fail on errors
  curl -f -L -s \
    https://raw.githubusercontent.com/clns/dotfiles/master/install/$script_name \
    > $script_tmp
  ret=$?
  if [ $ret -eq 0 ]; then
    (exit 0)
  else
    rm $script_tmp
    echo "Failed to download script" >&2
    exit $ret
  fi
  sh $script_tmp
  ret=$?
  rm $script_tmp
  exit $ret
fi

case "$(uname -s)" in

  Darwin)
    brew install tree
    ;;

  Linux)
    if [ $(which apt-get) ]; then
      sudo apt-get install tree
    elif [ $(which yum) ]; then
      yum install tree
    else
      echo "apt-get or yum not found, cannot install $script_name" >&2
      exit 1
    fi
    ;;

  *)
    echo "$script_name is only supported on Mac OS X and Linux" >&2
    exit 1
    ;;
esac
