let s:term = deepcopy(misc#term#vim#new())

function! misc#term#nvim#new() abort
  return deepcopy(s:term)
endfunction

" start terminal, no job
function! s:term.open_term(opts) abort
  terminal
  let [self.bufnr, self.job, self.title, self.pid]
        \ = [bufnr(''), b:terminal_job_id, b:term_title, b:terminal_job_pid]
endfunction

function! s:term.job_start(opts) abort

  function self.exit_cb(job_id, data, event) closure
    let self.job_finished = 1
    let self.exit_code = a:data
    if has_key(a:opts, 'exit_cb')
      call a:opts.exit_cb(self, a:job_id, a:data, a:event)
    endif
  endfunction

  call extend(a:opts.cmdopts, {'term':self, 'on_exit':self.on_exit})
  let self.job = termopen(a:opts.cmd, a:opts.cmdopts)
  let self.cmd = a:opts.cmd
  let self.cmdopts = a:opts.cmdopts
endfunction

function! s:term.post_open() abort
  if self.auto_insert && !has_key(self, 'cmd')
    normal! i
  endif
endfunction

function! misc#term#nvim#spawn(opts) abort
  let term = misc#term#nvim#new()
  call term.spawn(a:opts)
  return term
endfunction
