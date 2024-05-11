if exists('b:loaded_quicifix_cfg')
  finish
endif
let b:loaded_quicifix_cfg = 1

function s:rm_qf_item(visual)
  let r = a:visual ? [getpos("'<")[1], getpos("'>")[1]] : [line('.'), line('.')]
  let l = getqflist() | call remove(l, r[0]-1, r[1]-1)
              \ | call setqflist(l) | call cursor(r[0], 1)
endfunction

nnoremap <buffer> dd :call <sid>rm_qf_item(0)<cr>
vnoremap <buffer> d  :<c-u>call <sid>rm_qf_item(1)<cr>
