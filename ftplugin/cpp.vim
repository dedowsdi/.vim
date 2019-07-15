if exists('b:loaded_cpp_cfg')
  finish
endif
let b:loaded_cpp_cfg = 1

setlocal cinoptions&
setlocal cinoptions+=l1  " case indent
setlocal cinoptions+=g0  " no accessor indent
"setlocal cinoptions+=h-s " no statement indent after accessor
setlocal cinoptions+=N-s " no namespace indent
" no indent for contiuous state ment, avoid indent after Q_OBJECT kind stuff.
" you need to manually indent for continuous line.
setlocal cinoptions+=+0

:setlocal shiftwidth=2 tabstop=2 textwidth=80 expandtab
setlocal commentstring=//\ %s
setlocal formatoptions-=o

vnoremap <buffer> af :<C-U>silent! call cdef#selPf('a')<cr>
vnoremap <buffer> if :<C-U>silent! call cdef#selPf('i')<cr>
onoremap <buffer> af :normal vaf<cr>
onoremap <buffer> if :normal vif<cr>
call abbre#cpp()
