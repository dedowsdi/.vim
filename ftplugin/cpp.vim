if exists('b:loaded_cpp_cfg')
  finish
endif
let b:loaded_cpp_cfg = 1
inoremap <buffer> _] <c-]><esc>T:c2h/<esc>
nnoremap <buffer> _i :call mycpp#include_osg()<cr>
