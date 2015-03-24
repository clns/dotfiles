#dotfiles

## Getting Started

To get started run the following commands in Terminal:

```sh
git clone --recursive https://github.com/clns/dotfiles.git
cd dotfiles
make
```

This will:

- Configure Vim
  - install [Pathogen](https://github.com/tpope/vim-pathogen)
  - install [goyo.vim](https://github.com/junegunn/goyo.vim)
  - install [vim-go](https://github.com/fatih/vim-go)
  - install [neocomplete](https://github.com/Shougo/neocomplete.vim)
  - install [tagbar](https://github.com/majutsushi/tagbar)
    - install [ctags](http://ctags.sourceforge.net/) using Homebrew if not already installed, required by tagbar
    - install [gotags](https://github.com/jstemmer/gotags) if not present at $GOPATH/bin/gotags, required by tagbar
    - install [markdown2ctags](https://github.com/jszakmeister/markdown2ctags) in ~/.vim/external-deps/ for Markdown support in tagbar
  - install [ctrlp.vim](https://github.com/kien/ctrlp.vim.git)
  - install [tcomment_vim](https://github.com/tomtom/tcomment_vim)
  - install the following color schemes:
    - [molokai](https://github.com/fatih/molokai) - best for programming, doesn't work properly when switching between color schemes
    - [badwolf](https://github.com/sjl/badwolf/) - good for everything, works correctly when switching between color schemes
    - [peaksea](https://github.com/vim-scripts/peaksea) - weird coloring
    - [github](https://github.com/croaky/vim-colors-github) - not really used
    - [pencil](https://github.com/reedes/vim-colors-pencil) - good for text and Markdown files (zen mode), works correctly when switching between color schemes
  - copy .ctags to ~/
- Copy .gitconfig to ~/
- Copy .bash_profile and .bashrc to ~/

The vim-go plugin uses some go binaries like `gocode`, `godef`, `goimports` etc. You can install them automatically by using the `:GoInstallBinaries` command. It will put all necessary binaries in your `$GOBIN`, or `$GOPATH/bin` if not set.

## Requirements

[Homebrew](http://brew.sh/) - for installing ctags, MacVim (or Vim with if_lua).

neocomplete requires Vim compiled with `if_lua`. You can check if you have it 
by running `:echo has("lua")` in Vim. If it returns `1`, you're good. If not, 
install one of two Vims with homebrew, for Mac OS X.

```sh
# MacVim is recommended on OS X
brew install macvim --with-lua

# Normal version of Vim (not recommended on OS X)
brew install vim --with-lua
``` 

Python 2 for markdown2ctags plugin.
