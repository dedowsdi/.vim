if exists('b:loaded_cpp_cfg')
  finish
endif
let b:loaded_cpp_cfg = 1
nnoremap <buffer> _io :call mycpp#include_osg()<cr>

call abbre#cpp()

nnoremap <buffer> <c-n><c-n> :Job mktt -t cpp<cr>

com -buffer ReloadCppFtplugin call misc#reload_ftplugin(['b:loaded_cpp_cfg', 'b:loaded_c_cfg'])
