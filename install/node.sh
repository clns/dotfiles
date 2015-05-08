#!/bin/sh

# Install latest node.js and npm according to
# https://gist.github.com/isaacs/579814

script_name=node.sh
script_tmp=node-install-$$.sh

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
    echo 'TODO: Mac OS X'
    exit 1
    # brew install node
    ;;

  Linux)
    if [ $(which apt-get) ]; then
      sudo apt-get install -y build-essential g++
    elif [ $(which yum) ]; then
      echo 'Nothing to do for yum?!'
    fi

    echo 'export PATH=$HOME/local/bin:$PATH' >> $HOME/.profile
    . $HOME/.profile
    mkdir $HOME/local
    mkdir $HOME/node-latest-install
    cd $HOME/node-latest-install
    curl -L -# http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
    ./configure --prefix=$HOME/local
    make install
    curl -L -# https://www.npmjs.org/install.sh | sh
    ret=$?
    exit $ret
    ;;

  *)
    echo "$script_name is only supported on Mac OS X and Linux" >&2
    exit 1
    ;;
esac
