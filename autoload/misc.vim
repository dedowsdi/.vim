function! misc#warn(mes)
  echohl WarningMsg | echom a:mes | echohl None
endfunction

function! misc#hasjob(job)
  try | call jobpid(a:job)
    return 1
  catch /^Vim\%((\a\+)\)\=:E900/	" catch error E900
    return 0
  endtry
endfunction

" check if quickfix window is open
function! misc#qfixexists()
  for i in range(1, winnr('$'))
    let bufnr = winbufnr(i)
    if getbufvar(bufnr, '&buftype') == 'quickfix'
      return 1
    endif
  endfor
  return 0
endfunction
