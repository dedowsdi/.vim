if exists('b:loaded_osgt_cfg')
  finish
endif
let b:loaded_osgt_cfg = 1

nnoremap <buffer> <right> zr
nnoremap <buffer> <left> zm
nnoremap <buffer> <up> zc
nnoremap <buffer> <down> zo

setl nomodifiable
setl foldmethod=expr
setl foldexpr=FoldOsgt(v:lnum)

function FoldOsgt(lnum) abort
  let l = getline(a:lnum)

  " indent data block
  if stridx(l, ' ') == -1 || l ==# '" }'
    return '='
  else
    return len( matchstr(l , '\v^\s+' ) ) / 2
  endif
endfunction

