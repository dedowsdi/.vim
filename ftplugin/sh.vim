"load guard
if exists("b:loaded_sh_cfg")
  finish
endif
let b:loaded_sh_cfg = 1

setlocal textwidth=160
nnoremap <buffer> <f5> :terminal ./%<cr><c-w><c-p>
