function! misc#env#isRealUnix()
  return has('unix') && !misc#env#isWsl()
endfunction

function! misc#env#isWsl()
  if !has('unix') | return 0 | endif
  call system('grep -q "Microsoft" /proc/version') | return v:shell_error == 0
endfunction
