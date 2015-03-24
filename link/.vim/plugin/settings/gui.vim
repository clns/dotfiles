if has("gui_running")
	
	" Disable scrollbars (real hackers don't use scrollbars for navigation!)
	set guioptions-=r
	set guioptions-=R
	set guioptions-=l
	set guioptions-=L

	" Set font according to system
	if has("mac") || has("macunix")
			set gfn=Source\ Code\ Pro:h14,Monaco:h10
	elseif has("win16") || has("win32")
			set gfn=Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
	elseif has("linux")
			set gfn=Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
	elseif has("unix")
			set gfn=Monospace\ 11
	endif

endif
