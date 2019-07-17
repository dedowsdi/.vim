if exists('b:loaded_lpfg_cfg')
  finish
endif
let b:loaded_lpfg_cfg = 1

nnoremap <buffer> <f5>  :call myl#runLpfg()<cr>
