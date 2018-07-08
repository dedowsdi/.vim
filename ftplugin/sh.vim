"load guard
if exists("b:loaded_sh_cfg")
  finish
endif
let b:loaded_sh_cfg = 1

:setlocal expandtab textwidth=160 shiftwidth=2 tabstop=2
