"load guard
if exists("b:loaded_vim_cfg")
  finish
endif
let b:loaded_vim_cfg = 1

:setlocal shiftwidth=2 tabstop=2 textwidth=80 expandtab
call misc#ui#loadFiletypeMap('vim')
vnoremap <buffer> af :<C-U>silent! call misc#viml#selFunction('a')<cr>
vnoremap <buffer> if :<C-U>silent! call misc#viml#selFunction('i')<cr>
onoremap <buffer> af :normal vaf<cr>
onoremap <buffer> if :normal vif<cr>
