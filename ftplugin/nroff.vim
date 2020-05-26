if exists('b:loaded_ftplugin_nroff')
  finish
endif
let b:loaded_ftplugin_nroff = 1

nnoremap <f5> :term man ./%<cr>
