function dddu#os#is_real_unix()
  return has('unix') && !dddu#env#isWsl()
endfunction

function dddu#os#is_wsl()
  if !has('unix') | return 0 | endif
  call system('grep -q "Microsoft" /proc/version') | return v:shell_error == 0
endfunction

function dddu#os#systemlist(unix_cmd)
  if has('win32')
    try
      let bak = &shellslash
      set noshellslash

      " replace c: with /mnt/c
      let cmd = substitute(a:unix_cmd, '\v\c<([c-z]):/', '/mnt/\l\1/', 'g')
      let l = systemlist("bash -c " . shellescape(cmd))
      " replace /mnt/c with c:
      let l = map(l, {_,v -> substitute(v, '\v/mnt/([a-z])>', '\1:', 'g')})
      return l
    finally
      let &shellslash = bak
    endtry
  else
    return systemlist(a:unixcmd)
  endif
endfunction
