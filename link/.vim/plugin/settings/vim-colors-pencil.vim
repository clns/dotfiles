" vim-colors-pencil (https://github.com/reedes/vim-colors-pencil)

" If you're using Vim in the terminal and your terminal supports italics, 
" you can opt-in to italic support for some syntax highlighting, such as comments
let g:pencil_terminal_italics = 1


" Integration with goyo.vim (https://github.com/junegunn/goyo.vim)
" Nothing should be put after these lines

if exists("g:loaded_pencil_colorscheme")
	finish
endif
let g:loaded_pencil_colorscheme = 1

function s:IsCorrectFileType()
	return &filetype == "markdown" || &filetype == "mkd" || &filetype == "text"
endfunction

function s:pencil_goyo_before()
	if ! has("gui_running")
		return
	endif

	if s:IsCorrectFileType()
		if exists("&linespace")
			let s:linespace = &linespace
		endif
		if exists("&background")
			let s:background = &background
		endif
		if exists('g:colors_name')
			let s:colorscheme = g:colors_name
		endif
		
		" Change theme
		"execute 'colorscheme pencil'
		"set background=light
		set linespace=8
	endif
endfunction

function s:pencil_goyo_after()
	if ! has("gui_running")
		return
	endif
	
	if s:IsCorrectFileType()
		" Change theme back
		execute 'set linespace=' . s:linespace
		execute 'set background=' . s:background
		execute 'colorscheme ' . s:colorscheme
	endif
endfunction

let g:goyo_callbacks = [ function('s:pencil_goyo_before'), function('s:pencil_goyo_after') ]
