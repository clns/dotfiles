if ! has("win16") && ! has("win32")
    set background=dark

    " molokai https://github.com/fatih/molokai
    colorscheme molokai
    if ! has("gui_running")
        let g:molokai_original = 1
    endif
    " There is also an alternative scheme under development for color
    " terminals which attempts to bring the 256 color version as close as
    " possible to the default (dark) GUI version. To access, add this to
    " your .vimrc:
    "let g:rehash256 = 1

    " badwolf https://github.com/sjl/badwolf/
    "colorscheme badwolf

    " peaksea https://github.com/vim-scripts/peaksea
    "colorscheme peaksea

    " github https://github.com/croaky/vim-colors-github
    "colorscheme github
endif
