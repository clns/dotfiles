#dotfiles

## Getting Started

To get started run the following commands in Terminal:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/clns/dotfiles/master/bin/dotfiles)"
dotfiles install
```

The first command will only clone the repository into ~/.dotfiles and make the `dotfiles`
command available in the shell. The second command will link everything into the $HOME directory
and install stuff.

For help use `dotfiles -h`.

## About

This repository contains scripts to automate the installation and configuration of various
stuff I use while developing, mainly on OS X. Ubuntu is also supported.

The heart of the project is the [`dotfiles`](bin/dotfiles) command. On first run it does:

1. On Ubuntu, installs git via APT if not there (on OS X it's bundled by default)
2. Clones the repository into ~/.dotfiles
3. Copies files from [`/copy`][copy] into `~/` ([read more](#the-copy-step))
4. Links files from [`/link`][link] into `~/` ([read more](#the-link-step))
5. Installs stuff from the [`/install`][install] directory ([read more](#the-install-step))

On subsequent runs, step 1 is skipped and step 2 just updates the repository with `git pull`.
The other steps are the same, but it only copies/links/installs stuff that changed or
is not yet installed.

### Other Directories

* The `/backups` directory is created when necessary and it's used to store any file that may get
overwritten in the link or copy steps.
* The `/bin` directory contains executable shell scripts, including the `dotfiles` command.
This directory is added to the PATH.
* The `/source` directory contains files that are sourced whenever a new shell is opened.
This happens in alphanumeric order, hence the funky names.

### The "copy" step

Any files in the [`/copy`][copy] directory will be copied to `~/`. For example `.gitconfig` contains
your email address so it's not a good idea to modify it directly in the /link directory
because you may accidentally add it to the repository.

### The "link" step

Any files in the [`/link`][link] directory will be symlinked with `ln -s` to `~/`. Files here shouldn't
contain any sensitive information.

### The "install" step

Any files in the [`/install`][install] directory will get sourced and will install/update stuff.

TODO: Decide how to make this step customizable so the user can choose what to install. Maybe
we can just use interactivity while fetching all the scripts from the /install directory.

### Vim Setup

Among the linked stuff are Vim [configurations](link/.vim/plugin/settings)
(+ [.vimrc](link/.vimrc)) and [plugins](link/.vim/bundle).

The [vim-go](https://github.com/fatih/vim-go) plugin uses some go binaries like `gocode`, `godef`, `goimports` etc.
You can install them automatically from Vim by using the `:GoInstallBinaries` command.
It will put all necessary binaries in your `$GOBIN`, or `$GOPATH/bin` if not set.

## Credits

https://github.com/cowboy/dotfiles  
https://github.com/kevva/dotfiles  
http://natelandau.com/bash-scripting-utilities/  

[copy]: copy
[link]: link
[install]: install
