let s:term = extend(deepcopy(ddd#term#new()), {'bufnr':-1, 'auto_insert':1})

function ddd#term#vim#new() abort
  return deepcopy(s:term)
endfunction

function s:term.exists() abort
  return self.bufnr != -1 && bufexists(self.bufnr)
endfunction

function s:term.is_open() abort
  return bufwinid(self.bufnr) != -1
endfunction

function s:term.is_active() abort
  return bufnr('') == self.bufnr
endfunction

function s:term.goto_win() abort
  call win_gotoid(self.winid())
endfunction

function s:term.winid() abort
  return bufwinid(self.bufnr)
endfunction

" open buf or jump to buf wnd, do nothing if term buf doesn't exists
function s:term.open() abort
  if self.is_open()
    call self.goto_win()
  else
    call self.split(printf('sbuffer %d', self.bufnr))
  endif
  call self.post_open()
endfunction

function s:term.post_open() abort
  if mode() ==# 'n' && self.auto_insert
    norm! A
  endif
endfunction

function s:term.hide() abort
  if !self.is_open() | return | endif
  call win_execute(self.winid(), 'wincmd q')
endfunction

function s:term.close() abort
  if bufexists(self.bufnr)
    exe printf('bdelete! %d', self.bufnr)
  endif

  " clear job term from jterm list
  if has_key(self, 'jterms')
    call filter(self.jterms, {i,v -> v.bufnr != self.bufnr})
  endif
endfunction

function s:term.spawn(opts) abort
  let self.layout = a:opts.layout
  call self.split('new')
  let self.bufnr = bufnr('')

  if has_key(a:opts, 'cmd')
    call self.job_start(a:opts)
  else
    call self.open_term(a:opts)
  endif
  call self.post_open()
endfunction

function ddd#term#vim#spawn(opts) abort
  let term = ddd#term#vim#new()
  call term.spawn(a:opts)
  return term
endfunction

" start job
function s:term.job_start(opts) abort

  function self.exit_cb(job, status) closure
    let self.job_finished = 1
    let self.exit_code = a:status
    if has_key(a:opts, 'exit_cb')
      call a:opts.exit_cb(self, a:job, a:status)
    endif
  endfunction

  function self.close_cb(channel) closure
    if has_key(a:opts, 'close_cb')
      call a:opts.close_cb(self, a:channel)
    endif
  endfunction

  let opts = {'curwin':1, 'exit_cb':self.exit_cb, 'close_cb':self.close_cb}
  if has_key(a:opts, 'out_cb')
    let opts.out_cb = a:opts.out_cb
  endif
  if has_key(a:opts, 'callback')
    let opts.callback = a:opts.callback
  endif
  if has_key(a:opts, 'err_cb')
    let opts.err_cb = a:opts.err_cb
  endif

  let self.job = term_start(a:opts.cmd, opts)
endfunction

" start terminal, no job
function s:term.open_term(opts) abort
  terminal ++curwin
endfunction

" wnd commands and options
let s:wcos={
  \ 'top' : { 'split':'to'     , 'resize':'res'     , 'fixed_size':'height', 'size':'lines'},
  \ 'left': { 'split':'to vert', 'resize':'vert res', 'fixed_size':'width' , 'size':'co'   },
  \ 'bot':  { 'split':'bo'     , 'resize':'res'     , 'fixed_size':'height', 'size':'lines'},
  \ 'right':{ 'split':'bo vert', 'resize':'vert res', 'fixed_size':'width' , 'size':'co'   }
  \ }

function s:term.split(split_cmd) abort
  let wco = s:wcos[self.layout.position]
  exe printf('%s %s', wco.split, a:split_cmd)

  if has_key(self.layout, 'psize')
    let wndsize=0
    exe printf('let wndsize = &%s', wco.size)
    exe printf('%s %d', wco.resize, float2nr(wndsize * self.layout.psize) )
  elseif has_key(self.layout, 'size')
    exe printf('%s %d', wco.resize, self.layout.size)
  endif
endfunction
