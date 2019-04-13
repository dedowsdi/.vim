"load guard
if exists("b:loaded_vim_cfg")
  finish
endif
let b:loaded_vim_cfg = 1

:setlocal shiftwidth=2 tabstop=2 textwidth=80 expandtab
call misc#ui#loadFiletypeMap('vim')
