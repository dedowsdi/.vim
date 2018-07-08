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

call abbre#cpp()
call myvim#loadFiletypeMap('c')
call myvim#loadFiletypeMap('cpp')
