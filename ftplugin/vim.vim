"load guard
if exists('b:loaded_vim_cfg')
  finish
endif
let b:loaded_vim_cfg = 1

setlocal shiftwidth=2 tabstop=8 softtabstop=2 textwidth=80
setlocal omnifunc=syntaxcomplete#Complete
setlocal foldmethod=indent
setlocal keywordprg&

function s:add_to(lhs, rhs) abort
    exe printf('vmap <buffer> %s %s', a:lhs, a:rhs)
    exe printf('omap <buffer> %s %s', a:lhs, a:rhs)
endfunction

call s:add_to('if', '<plug>ddd_vim_to_if')
call s:add_to('af', '<plug>ddd_vim_to_af')

nnoremap <buffer> <c-f5>     :VimReloadScript<cr>
nnoremap <buffer> <c-f9>     :VimBreakNumberedFunction<cr>
nnoremap <buffer> <f5>       :so %<cr>
nnoremap <buffer> <f9>       :VimBreakHere<cr>
nnoremap <buffer> <leader>ej :VimJoin<cr>

nnoremap <buffer> <c-f5>     :VimReloadScript<cr>
nnoremap <buffer> <c-f9>     :VimBreakNumberedFunction<cr>
nnoremap <buffer> <f5>       :so %<cr>
nnoremap <buffer> <f9>       :VimBreakHere<cr>
nnoremap <buffer> <leader>df :verbose function{}<left>
nnoremap <buffer> <leader>ej :VimJoin<cr>
