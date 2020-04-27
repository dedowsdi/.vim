function dddu#os#is_real_unix()
  return has('unix') && !dddu#env#isWsl()
endfunction

function dddu#os#is_wsl()
  if !has('unix') | return 0 | endif
  call system('grep -q "Microsoft" /proc/version') | return v:shell_error == 0
endfunction
