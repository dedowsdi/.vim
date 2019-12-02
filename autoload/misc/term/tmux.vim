let s:term = deepcopy(misc#term#new())

function misc#term#tmux#new() abort
  return deepcopy(s:term)
endfunction

function s:term.exists() abort
  return has_key(self, 'pane') && self.pane.exists()
endfunction

function s:term.isOpen() abort
  return self.pane.isWindowActive()
endfunction

function s:term.isActive() abort
  return self.pane.isActive()
endfunction

function s:term.gotoWin() abort
  call self.pane.select()
endfunction

" open buf or jump to buf wnd, do nothing if term buf doesn't exists
function s:term.open() abort
  if self.isOpen()
    call self.gotoWin()
  else
    call self.split()
  endif
endfunction

function s:term.hide() abort
  if !self.isOpen() | return | endif
  call self.pane.hide()
endfunction

function s:term.close() abort
  call self.pane.kill()

  " clear job term from jterm list
  if has_key(self, 'jterms')
    call filter(self.jterms, {i,v -> v.pane.pane_id != self.pane.pane_id})
  endif
endfunction

function s:term.spawn(opts) abort
  let self.layout = a:opts.layout
  call self.split()

  if has_key(a:opts, 'cmd')
    call self.pane.last_pane()
    call self.jobStart(a:opts)
  endif
endfunction

function misc#term#tmux#spawn(opts) abort
  let term = misc#term#tmux#new()
  call term.spawn(a:opts)
  return term
endfunction

" start job
function s:term.jobStart(opts) abort
   call self.pane.send([a:opts.cmd, 'Enter'])
endfunction

" start terminal, no job
function s:term.openTerm(opts) abort
  terminal ++curwin
endfunction

" wnd commands and options
let s:wcos={
  \ 'top' : { 'split':'-b -v'     },
  \ 'left': { 'split':'-b -h'},
  \ 'bot':  { 'split':'-v'     },
  \ 'right':{ 'split':'-h'}
  \ }

function s:term.split() abort
  let wco = s:wcos[self.layout.position]

  let cmd = wco.split
  if has_key(self.layout, 'psize')
    let cmd .= ' -p ' . float2nr(self.layout.psize * 100)
  endif

  if has_key(self.layout, 'size')
    let cmd .= ' -l ' . self.layout.size
  endif

  if has_key(self, 'pane')
    call self.pane.join(self.vpane.pane_id, cmd)
  else
    let self.vpane = misc#tmux#pane()
    let self.pane = misc#tmux#split(cmd)
  endif

endfunction
