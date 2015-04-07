#dotfiles

## Getting Started

To get started run the following command in Terminal:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/clns/dotfiles/master/bin/dotfiles)"
```

This command will clone the repository into `~/.dotfiles` and make the `dotfiles`
command available in the shell. It will also install git if not available (eg. on Ubuntu).

For detailed usage use `dotfiles -h`.

## Usage Example

A common example usage that configures and installs everything using user interaction is:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/clns/dotfiles/master/bin/dotfiles)"
dotfiles copy link
dotfiles -q install
```

## About

This repository contains scripts to automate the installation and configuration of various
stuff I use while developing, mainly on OS X. Ubuntu is also supported.

The heart of the project is the [`dotfiles`](bin/dotfiles) command.

### The "copy" step

Any files in the [`/copy`][copy] directory will be copied to `~/`. For example `.gitconfig` contains
your email address so it's not a good idea to modify it directly in the `/link` directory
because you may accidentally add it to the repository.

### The "link" step

Any files in the [`/link`][link] directory will be symlinked with `ln -s` to `~/`. Files here shouldn't
contain any sensitive information.

### The "install" step

Any files in the [`/install`][install] directory will get sourced and will install/update stuff. 
You can specify which things to install by appending arguments to the install command.

### Other Directories

* The `/backups` directory is created when necessary and it's used to store any file that may get
overwritten in the link or copy steps.
* The `/bin` directory contains executable shell scripts, including the `dotfiles` command.
This directory is added to the PATH.
* The `/source` directory contains files that are sourced whenever a new shell is opened.
This happens in alphanumeric order, hence the funky names.

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
