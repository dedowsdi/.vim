" debian load /usr/share/vim/vimrc->/usr/share/vim/vim*/debian.vim, my custom
" build in usually installed at /usr/local/share, you must link this file to
" /usr/local/share/vim/vimrc to let vim load it as system vimrc.

" system vimrc is load as compatible mode by default
set nocp

if has('gui_running')
  inoremap <s-insert> <MiddleMouse>
  cnoremap <s-insert> <MiddleMouse>
endif

if filereadable('/etc/papersize')
  let s:papersize = matchstr(readfile('/etc/papersize', '', 1), '\p*')
  if !empty(s:papersize)
    let &printoptions .= 'paper:' . s:papersize
  endif
endif
