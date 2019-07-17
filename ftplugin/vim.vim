"load guard
if exists('b:loaded_vim_cfg')
  finish
endif
let b:loaded_vim_cfg = 1

:setlocal shiftwidth=2 tabstop=8 softtabstop=2 textwidth=80

vnoremap <buffer> af :<C-U>silent! call misc#viml#selFunction('a')<cr>
vnoremap <buffer> if :<C-U>silent! call misc#viml#selFunction('i')<cr>
onoremap <buffer> af :normal vaf<cr>
onoremap <buffer> if :normal vif<cr>

nnoremap <buffer> <c-f5>     :VimlReloadScript<cr>
nnoremap <buffer> <c-f9>     :VimlBreakNumberedFunction<cr>
nnoremap <buffer> <f5>       :so %<cr>
nnoremap <buffer> <f9>       :VimlBreakHere<cr>
nnoremap <buffer> <leader>ej :VimlJoin<cr>

nnoremap <buffer> <c-f5>     :VimlReloadScript<cr>
nnoremap <buffer> <c-f9>     :VimlBreakNumberedFunction<cr>
nnoremap <buffer> <f5>       :so %<cr>
nnoremap <buffer> <f9>       :VimlBreakHere<cr>
nnoremap <buffer> <leader>df :verbose function{}<left>
nnoremap <buffer> <leader>ej :VimlJoin<cr>
