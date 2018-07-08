if exists("b:loaded_c_cfg")
  finish
endif
let b:loaded_c_cfg = 1
:setlocal shiftwidth=2 tabstop=2 textwidth=80 expandtab

call myvim#loadFiletypeMap('c')
