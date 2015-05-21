if is_osx; then
  if [ ! -d "/Applications/Atom.app" ]; then
    cd /tmp
    curl -L -O $(curl https://api.github.com/repos/atom/atom/releases/latest | grep browser_download_url.*atom-mac.zip | cut -d\" -f4)
    unzip -q -d /Applications/ atom-mac.zip
    rm atom-mac.zip
  else
    log_arrow "Atom is installed"
  fi
fi
