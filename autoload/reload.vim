function! reload#reloadLoadedScript() abort
  try
    let oldpos = getpos('.')
    let reScriptGuard = '\v^\s*let\s+\zs[gb]:loaded\w+\ze'
    keepjumps normal! gg
    if search(reScriptGuard, 'W')
      let scriptGuard = matchstr(getline('.'), reScriptGuard) 
      if exists(scriptGuard)
        execute 'unlet ' . scriptGuard
      endif
      source %
    else
      call myvim#warn('script guard not found')
      return
    endif
  finally
    call setpos('.', oldpos)
  endtry
endfunction
