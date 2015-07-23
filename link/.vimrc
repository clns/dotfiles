" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" don't keep a backup file
set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set number		" show line numbers
set showcmd		" display incomplete commands
set cursorline		" highlight current line
set incsearch		" do incremental searching
"set ignorecase		" ignore case when searching
set smartcase		" try to be smart about cases when searching
set cmdheight=1		" height of the command bar
set magic		" turn magic on for regular expressions
set showmatch		" show matching brackets when text indicator is over them
set mat=2		" how many tenths of a second to blink when matching brackets
set wildmenu		" visual autocomplete for command menu
set lazyredraw		" redraw only when we need to
set autoread		" Set to auto read when a file is changed from outside
set so=7		" Set 7 lines to the cursor - when moving verically using j/k
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize
set hidden
set completeopt-=preview " disable Scratch/Preview window http://stackoverflow.com/a/15963488/1104534
set laststatus=2

let mapleader = ","

" clear highlighted search on <esc>
nnoremap <silent> <Esc><Esc> :noh<CR> :call clearmatches()<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " PATHOGEN https://github.com/tpope/vim-pathogen
  runtime bundle/vim-pathogen/autoload/pathogen.vim
  execute pathogen#infect()
  call pathogen#helptags()

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

if ! has("gui_running")
	set t_Co=256
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
