#!/bin/sh

# This is a template that provides a starting point for any install script
#
# curl https://raw.githubusercontent.com/clns/dotfiles/master/install/_template.sh | sh

script_name=_template.sh
script_tmp=_template-install-$$.sh

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
    echo 'Mac OS X'
    ;;

  Linux)
    echo 'Linux'
    ;;

  *)
    echo "$script_name is only supported on Mac OS X and Linux" >&2
    exit 1
    ;;
esac
