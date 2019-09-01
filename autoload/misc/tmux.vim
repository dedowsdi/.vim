function! misc#tmux#exe(cmd) abort
  call misc#log#debug('tmux : ' . a:cmd)
  silent! return trim(system(misc#tmux#cmd() . a:cmd))
endfunction

function! misc#tmux#socket() abort
  if empty($TMUX)
    throw 'not in tmux'
  endif
  return split($TMUX, ',')[0]
endfunction

function! misc#tmux#cmd() abort
  return 'tmux -S ' . misc#tmux#socket() . ' '
endfunction

function! misc#tmux#message(fmt, ...) abort
  let target = a:0 > 0 ? ('-t ' . a:1) : ''
  return misc#tmux#exe(
        \ printf('display-message -p %s -F ''%s''', target, a:fmt))
endfunction

" string in keys will be surround with '', be careful with that
function! misc#tmux#send(keys, ...)
  let target = a:0 > 0 ? ('-t ' . a:1) : ''
  let key_string = "'" . join(a:keys, "' '") . "'"
  return misc#tmux#exe(
        \ printf('send-keys %s %s', target, key_string))
endfunction

function! misc#tmux#last_pane_id() abort
  return trim(system(
        \ misc#tmux#cmd() . 'display-message -p -t {last} -F "#{pane_id}"'))
endfunction

" split and come back, return new pane id
function! misc#tmux#split(args) abort
  cal misc#tmux#exe(printf('split-window %s', a:args))
  return misc#tmux#pane(misc#tmux#current_pane_id())
endfunction

" vim wrap
function! misc#tmux#pane(...)
  let pane_id = get(a:000, 0, misc#tmux#current_pane_id())
  let pane = deepcopy(s:pane)
  let pane.pane_id = pane_id
  call pane.realize()
  return pane
endfunction

function! misc#tmux#current_pane_id()
  return trim(system(misc#tmux#cmd() . 'display-message -p -F "#{pane_id}"'))
endfunction

let s:pane = {"pane_id":-1}

function! s:pane.realize() abort

  " variable that won't change
  let items = [
        \ 'session_id',
        \ 'pane_index',
        \ ]

  let format = join(map(deepcopy(items), { i,v->printf('#{%s}', v) } ), ' ')
  let results = split(self.message(format), '\v\s+')
  if v:shell_error != 0
    throw 'realize failed : pane_id : ' . self.pane_id
  endif

  let idx = 0
  for item in items
    let self[item] = results[idx]
    let idx += 1
  endfor

endfunction

function! s:pane.message(fmt) abort
  return misc#tmux#message(a:fmt, self.pane_id)
endfunction

function! s:pane.exe(cmd) abort
  call misc#tmux#exe(a:cmd)
endfunction

function! s:pane.send(cmd) abort
  call misc#tmux#send(a:cmd, self.pane_id)
endfunction

function! s:pane.exists() abort
  call misc#tmux#exe(printf('has-session -t %s 2>/dev/null', self.pane_id))
  return v:shell_error == 0
endfunction

function! s:pane.window_id()
  return self.message('#{window_id}')
endfunction

function! s:pane.is_active()
  return self.message('#{pane_active}') == 1
endfunction

function! s:pane.is_window_active()
  return self.message('#{window_active}') == 1
endfunction

function! s:pane.target_string()
  return ' -t ' . self.pane_id
endfunction

function! s:pane.select()
  call self.exe('select-pant ' . self.target_string())
endfunction

function! s:pane.hide()
  call self.exe('break-pane')
endfunction

function! s:pane.kill()
  call self.exe('kill-pane ' . self.target_string())
endfunction

function! s:pane.last_pane()
  call self.exe('last-pane')
endfunction

" args : -t target -h -p percent
function! s:pane.join(target_pane, args)
  call self.exe(printf('join-pane -s %s -t %s %s', self.pane_id, a:target_pane, a:args))
  "call self.last_pane()
endfunction
