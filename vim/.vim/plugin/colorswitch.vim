" switch between light and dark colors

if !empty($ITERM_PROFILE)
	let iterm = $ITERM_PROFILE
	if iterm ==# "light"
		silent! colorscheme tango-morning
	else
		silent! colorscheme inori
	endif
endif
