"load guard
if exists("g:loaded_json_cfg")
  finish
endif
let g:loaded_json_cfg = 1

:setlocal shiftwidth=2 tabstop=2 expandtab
nnoremap <buffer> <leader>J A <bar><esc>J
