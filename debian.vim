" changed from /usr/share/vim/vim82/debian.vim, must create link for it to
" custom build VIM
if has('gui')
  inoremap <s-insert> <MiddleMouse>
  cnoremap <s-insert> <MiddleMouse>
endif

if filereadable('/etc/papersize')
  let s:papersize = matchstr(readfile('/etc/papersize', '', 1), '\p*')
  if !empty(s:papersize)
    let &printoptions .= 'paper:' . s:papersize
  endif
endif
