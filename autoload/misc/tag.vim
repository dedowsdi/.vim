function misc#tag#readtagsi(args) abort
  let cmd = printf( 'readtagsi %s %s',
              \ join( map( tagfiles(), { i,v-> printf('-t "%s"', v)  } ) ),
              \ a:args )
  call misc#log#debug(cmd)
  call append( line('.'), systemlist(cmd) )
endfunction

function misc#tag#connect_server() abort
  if !filewritable($CTAG_SERVER_PIPE)
    " echoe printf('pipe %s not found', $CTAG_SERVER_PIPE)
    return
  endif

  augroup dedowsdi_ctag_client | au!
    autocmd BufWritePost * call s:update_tag()
  augroup end
endfunction

function s:send_update_tag(timer) abort
  if !filewritable($CTAG_SERVER_PIPE)
    return
  endif

  let s:update_files = map( uniq( sort(s:update_files) ),
        \ {i,v -> printf( 'echo update:%s', v )} )
  let cmd = printf( "{\n%s}>%s &", join(s:update_files, "\n"),
              \ shellescape($CTAG_SERVER_PIPE) )
  call system(cmd)

  unlet s:update_timer
  let s:update_files = []
endfunction

let s:update_files=[]

function s:update_tag() abort
  " skip non children
  let f = expand('%:.')
  if f[0] ==# '/'
    return
  endif

  if exists('s:update_timer')
    call timer_stop(s:update_timer)
  endif

  let s:update_files += [shellescape(f)]
  let s:update_timer = timer_start(g:ctag_update_delay,
        \ function('s:send_update_tag', []))
endfunction
