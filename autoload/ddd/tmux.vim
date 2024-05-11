function ddd#tmux#exe(cmd) abort
  call ddd#log#debug('tmux : ' . a:cmd)
  silent! return trim(system(ddd#tmux#cmd() . a:cmd))
endfunction

function ddd#tmux#socket() abort
  if empty($TMUX)
    throw 'not in tmux'
  endif
  return split($TMUX, ',')[0]
endfunction

function ddd#tmux#cmd() abort
  return 'tmux -S ' . ddd#tmux#socket() . ' '
endfunction

function ddd#tmux#message(fmt, ...) abort
  let args = get(a:000, 0, '')
  return ddd#tmux#exe(
        \ printf( 'display-message -p %s -F "%s"', args, a:fmt ))
endfunction

function ddd#tmux#session_id() abort
  return ddd#tmux#message('#{session_id}')
endfunction

function ddd#tmux#window_id() abort
  return ddd#tmux#message('#{window_id}')
endfunction

" string in keys will be surround with '', be careful with that
function ddd#tmux#send(keys, ...)
  let tmux_keys = join( map( deepcopy(a:keys), { i,v -> string(v) } ) )
  return ddd#tmux#exe(
        \ printf('send-keys %s %s', get(a:000, 0, ''), tmux_keys) )
endfunction

function ddd#tmux#last_pane_id() abort
  return ddd#tmux#message('#{pane_id}', '-t {last}')
endfunction

function ddd#tmux#split(...) abort
  let pane_id =  ddd#tmux#exe(
        \ printf( 'split-window %s -P -F "#{pane_id}"', get(a:000, 0, '') ) )
  return ddd#tmux#pane( pane_id )
endfunction

" vim wrap for pane
function ddd#tmux#pane( pane_id ) abort
  let pane = deepcopy(s:pane)
  let pane.pane_id = a:pane_id
  call pane.realize()
  return pane
endfunction

let s:pane = {'pane_id':-1}

function s:pane.realize() abort
  " variable that won't change
  let items = [
        \ 'pane_index',
        \ ]

  let format = join( map( deepcopy(items), { i,v->printf('#{%s}', v) }  ), ' ' )
  let results = split( ddd#tmux#message( format, self.target() ), '\v\s+' )
  if v:shell_error != 0
    throw 'realize failed : pane_id : ' . self.pane_id
  endif

  let idx = 0
  for item in items
    let self[item] = results[idx]
    let idx += 1
  endfor

  call ddd#log#debug('realize new pane ' . self.pane_id)
endfunction

function s:pane.target() abort
  return '-t ' . self.pane_id
endfunction

function s:pane.send(cmd_list, ...) abort
  call ddd#tmux#send( a:cmd_list, self.target() . ' ' . get(a:000, 0, '') )
endfunction

function s:pane.exists() abort
  call ddd#tmux#exe(printf('has-session %s 2>/dev/null', self.target()))
  return v:shell_error == 0
endfunction

function s:pane.visible() abort
  return self.exists() && self.window_id() == ddd#tmux#window_id()
endfunction

function s:pane.window_id() abort
  return ddd#tmux#message('#{window_id}', self.target())
endfunction

function s:pane.is_active() abort
  return ddd#tmux#message('#{pane_active}', self.target()) == 1
endfunction

function s:pane.is_window_active() abort
  return ddd#tmux#message('#{window_active}', self.target()) == 1
endfunction

function s:pane.select() abort
  call ddd#tmux#exe('select-pane ' . self.target())
endfunction

function s:pane.hide(...) abort
  call ddd#tmux#exe(
        \ printf( 'break-pane -dP -s %s %s', self.pane_id, get(a:000, 0, '') ) )
endfunction

function s:pane.show(...) abort
  call ddd#tmux#exe(
        \ printf('join-pane -s %s %s', self.pane_id, get(a:000, 0, '') ) )
endfunction

function s:pane.kill() abort
  call ddd#tmux#exe('kill-pane ' . self.target())
endfunction

function s:pane.last_pane() abort
  call ddd#tmux#exe('last-pane')
endfunction

function s:pane.join(target_pane, ...) abort
  call self.exe(printf( 'join-pane -s %s -t %s %s', self.pane_id,
        \ a:target_pane, get(a:000, 0, '') ) )
endfunction

function s:pane.size() abort
  let size = ddd#tmux#message('#{pane_width} #{pane_height}', self.target())
  return split(size, '\v\s+')
endfunction
