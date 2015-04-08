autocmd FileType vim setlocal noexpandtab
autocmd FileType text setlocal noexpandtab
autocmd FileType markdown setlocal noexpandtab
autocmd FileType go setlocal noexpandtab

" vim-markdown https://github.com/tpope/vim-markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

autocmd Filetype gitcommit setlocal spell textwidth=72
