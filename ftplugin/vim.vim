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

call s:add_to('if', '<plug>dedowsdi_viml_to_if')
call s:add_to('af', '<plug>dedowsdi_viml_to_af')

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

nnoremap <buffer> <c-n><c-n> :new `mkt -s .vim`<cr>
