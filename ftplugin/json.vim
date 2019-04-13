"load guard
if exists("g:loaded_json_cfg")
  finish
endif
let g:loaded_json_cfg = 1

:setlocal shiftwidth=2 tabstop=2 expandtab
call misc#ui#loadFiletypeMap('json')
