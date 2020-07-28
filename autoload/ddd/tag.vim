function ddd#tag#readtagsi(args) abort
  let cmd = printf( 'readtagsi %s %s',
              \ join( map( tagfiles(), { i,v-> printf('-t "%s"', v)  } ) ),
              \ a:args )
  call ddd#log#debug(cmd)
  call append( line('.'), systemlist(cmd) )
endfunction

function ddd#tag#connect_server() abort
  " The server is running in a sibling process, it's possible that tag/pipe has
  " not been created at this moment, but pid should always exists.
  if !exists('$CTAG_SERVER_PID')
    return
  endif

  augroup ddd_ctag_client | au!
    autocmd BufWritePost * call s:update_tag()
  augroup end
endfunction

function ddd#tag#disconnect_server() abort
  autocmd! ddd_ctag_client
endfunction

function s:send_update_tag(timer) abort
  let uniq_files = uniq( sort(s:update_files) )
  unlet s:update_timer
  let s:update_files = []

  if has('win32')
    try
      let bak = &shellslash
      set noshellslash
      call map(uniq_files, { i,v -> shellescape(v) })
    finally
      let &shellslash = bak
    endtry
    " simply append tags for windows
    let cmd = printf( 'cmd /c ctags --append=yes %s', join(uniq_files) )
  else

    if !filewritable($CTAG_SERVER_PIPE)
      return
    endif

    call map(uniq_files, { i,v -> shellescape(v) })
    let l = map( uniq_files, {i,v -> printf( 'echo update:%s', v )} )
    let cmd = printf( "{\n%s\n}>%s &", join(l, "\n"),
                \ shellescape($CTAG_SERVER_PIPE) )
  endif

  call job_start(cmd)
endfunction

let s:update_files=[]

function s:update_tag() abort
  " skip non children
  let f = expand('%')
  if has('win32')
    if f =~? '^[c-z]:' || f[0] ==# '/'
      return
    endif
  else
    if f[0] ==# '/'
      return
    endif
  endif

  if exists('s:update_timer')
    call timer_stop(s:update_timer)
  endif

  let s:update_files += [f]
  let s:update_timer = timer_start(g:ddd_ctag_update_delay,
        \ function('s:send_update_tag', []))
endfunction
