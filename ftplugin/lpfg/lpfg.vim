if exists('b:loaded_lpfg_cfg')
  finish
endif
let b:loaded_lpfg_cfg = 1

augroup autocmd_lpfg_group
  au!
  autocmd BufWritePost <buffer> call myl#runLpfg()
augroup end

nnoremap <buffer> <f5>  :call myl#runLpfg()<cr>
