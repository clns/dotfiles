#!/bin/sh

# git + hub = github
#
# https://github.com/github/hub

script_name=hub.sh
script_tmp=hub-install-$$.sh

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
    brew install hub
    ;;

  Linux)
    ARCH=$(uname -m | sed 's/x86_//;s/i//;s/64/amd64/') # 386 or amd64
    ver=$(curl -s https://github.com/github/hub/releases/latest | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | sed s/v//)
    file="hub-linux-${ARCH}-${ver}"
    url="https://github.com/github/hub/releases/download/v${ver}/${file}.tar.gz"
    dest="/usr/local/bin/"

    curl -#L "$url" | tar xz && \
        mkdir -p "$dest" && \
        sudo cp "$file/hub" "$dest" && \
        sudo chmod +x "$dest/hub"
    rm -rf $file
    ;;

  *)
    echo "$script_name is only supported on Mac OS X and Linux" >&2
    exit 1
    ;;
esac
