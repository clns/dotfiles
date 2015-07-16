" Invisibles
nmap <Leader>l :set list!<CR>	" map shortcut key to toggle invisibles
if has("multi_byte")
  scriptencoding utf-8
  set encoding=utf-8
  if has("win16") || has("win32")
    set listchars=precedes:«,extends:»,tab:·\ ,eol:¬	" set invisible characters
  else
    set listchars=precedes:«,extends:»,tab:▸\ ,eol:¬	" set invisible characters
  endif
endif

set list	" needs to stay like this until tabs are taken care of per filetype
" Tabs and spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Preserve command func (Strip trailing whitespace)
" http://vimcasts.org/episodes/tidying-whitespace/
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>	" strip trailing spaces
nmap _dd :call Preserve(":g/^$/d")<CR>	" delete all blank lines
" Run the command automatically when a file is saved
"autocmd BufWritePre *.py,*.js :call Preserve("%s/\\s\\+$//e")<CR>

" Indentation
nmap _= :call Preserve("normal gg=G")<CR>	" indent whole file
" Emulate TextMate's shift left/right key commands
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Working directory
nnoremap <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" Comment lines with D-/ (on OS X) or <Leader>/ (elsewhere)
" http://stackoverflow.com/questions/10948321/setting-ctrl-for-comment-and-uncomment-in-vim
if has("unix") && system("uname -s") == "Darwin\n"
    map <D-/> :TComment<CR>
    vmap <D-/> :TComment<CR>gv
else
    map <Leader>/ :TComment<CR>
    vmap <Leader>/ :TComment<CR>gv
endif
