let s:term = extend(deepcopy(misc#term#new()), {'bufnr':-1, 'autoInsert':1})

function! misc#term#vim#new() abort
  return deepcopy(s:term)
endfunction

function! s:term.exists() abort
  return self.bufnr != -1 && bufexists(self.bufnr)
endfunction

function! s:term.isOpen() abort
  return bufwinid(self.bufnr) != -1
endfunction

function! s:term.isActive() abort
  return bufnr('') == self.bufnr
endfunction

function! s:term.gotoWin() abort
  call win_gotoid(bufwinid(self.bufnr))
endfunction

" open buf or jump to buf wnd, do nothing if term buf doesn't exists
function! s:term.open() abort
  if self.isOpen()
    call self.gotoWin()
  else
    call self.split(printf('sbuffer %d', self.bufnr))
  endif
  call self.postOpen()
endfunction

function! s:term.postOpen() abort
  if mode() ==# 'n' && self.autoInsert
    norm! A
  endif
endfunction

function! s:term.hide() abort
  if !self.isOpen() | return | endif

  let oldwinid = win_getid('')
  call self.gotoWin()
  call self.doHide()
  call win_gotoid(oldwinid)
endfunction

function! s:term.doHide() abort
  " :hide will cause the buffer in normal mode
  call feedkeys("\<c-w>q")
endfunction

function! s:term.close() abort
  if bufexists(self.bufnr)
    exe printf('bdelete! %d', self.bufnr)
  endif

  " clear job term from jterm list
  if has_key(self, 'jterms')
    call filter(self.jterms, {i,v -> v.bufnr != self.bufnr})
  endif
endfunction

function! s:term.spawn(opts) abort
  let self.layout = a:opts.layout
  call self.split('new')
  let self.bufnr = bufnr('')

  if has_key(a:opts, 'cmd')
    call self.jobStart(a:opts)
  else
    call self.openTerm(a:opts)
  endif
  call self.postOpen()
endfunction

function! misc#term#vim#spawn(opts) abort
  let term = misc#term#vim#new()
  call term.spawn(a:opts)
  return term
endfunction

" start job
function! s:term.jobStart(opts) abort

  function self.exit_cb(job, status) closure
    let self.jobFinished = 1
    let self.exitCode = a:status
    if has_key(a:opts, 'exit_cb')
      call a:opts.exit_cb(self, a:job, a:status)
    endif
  endfunction

  function self.close_cb(channel) closure
    if has_key(a:opts, 'close_cb')
      call a:opts.close_cb(self, a:channel)
    endif
  endfunction

  let self.job = term_start(a:opts.cmd, {'curwin':1, 'exit_cb':self.exit_cb, 'close_cb':self.close_cb})
endfunction

" start terminal, no job
function! s:term.openTerm(opts) abort
  terminal ++curwin
endfunction

" wnd commands and options
let s:wcos={
  \ 'top' : { 'split':'to'     , 'resize':'res'     , 'fixedSize':'height', 'size':'lines'},
  \ 'left': { 'split':'to vert', 'resize':'vert res', 'fixedSize':'width' , 'size':'co'   },
  \ 'bot':  { 'split':'bo'     , 'resize':'res'     , 'fixedSize':'height', 'size':'lines'},
  \ 'right':{ 'split':'bo vert', 'resize':'vert res', 'fixedSize':'width' , 'size':'co'   }
  \ }

function! s:term.split(splitCmd) abort
  let wco = s:wcos[self.layout.position]
  exe printf('%s %s', wco.split, a:splitCmd)

  if has_key(self.layout, 'psize')
    let wndsize=0
    exe printf('let wndsize = &%s', wco.size)
    exe printf('%s %d', wco.resize, float2nr(wndsize * self.layout.psize) )
  elseif has_key(self.layout, 'size')
    exe printf('%s %d', wco.resize, self.layout.size)
  endif
endfunction
