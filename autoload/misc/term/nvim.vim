let s:term = deepcopy(misc#term#vim#new())

function misc#term#nvim#new() abort
  return deepcopy(s:term)
endfunction

" start terminal, no job
function s:term.open_term(opts) abort
  terminal
  let [self.bufnr, self.job, self.title, self.pid]
        \ = [bufnr(''), b:terminal_job_id, b:term_title, b:terminal_job_pid]
endfunction

function s:term.job_start(opts) abort

function
endfunction

function s:term.post_open() abort
  if self.auto_insert && !has_key(self, 'cmd')
    normal! i
  endif
endfunction

function misc#term#nvim#spawn(opts) abort
  let term = misc#term#nvim#new()
  call term.spawn(a:opts)
  return term
endfunction
