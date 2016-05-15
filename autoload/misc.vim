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
