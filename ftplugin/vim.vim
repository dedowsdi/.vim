"load guard
if exists("g:loaded_vim_cfg")
  finish
endif
let g:loaded_vim_cfg = 1

:setlocal shiftwidth=2 tabstop=2 textwidth=80 expandtab
nnoremap <buffer> <leader>J A <bar><esc>J
