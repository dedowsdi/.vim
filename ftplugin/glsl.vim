if exists("b:loaded_glsl_cfg")
  finish
endif
let b:loaded_glsl_cfg = 1

:setlocal shiftwidth=2 tabstop=2 textwidth=80 expandtab
call myvim#loadFiletypeMap('glsl')
