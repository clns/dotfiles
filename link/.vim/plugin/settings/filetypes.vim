autocmd FileType vim setlocal noexpandtab
autocmd FileType text setlocal noexpandtab
autocmd FileTYpe markdown setlocal noexpandtab
autocmd FileType go setlocal noexpandtab

" vim-markdown https://github.com/tpope/vim-markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
