let s:term = deepcopy(misc#term#vim#new())

function! misc#term#nvim#new() abort
  return deepcopy(s:term)
endfunction

" start terminal, no job
function! s:term.openTerm(opts) abort
  terminal
  let [self.bufnr, self.job, self.title, self.pid]
        \ = [bufnr(''), b:terminal_job_id, b:term_title, b:terminal_job_pid]
endfunction

function! s:term.onExit(job_id, data, event) abort
  let self.term.jobFinished = 1
endfunction

function! s:term.jobStart(opts) abort
  call extend(a:opts.cmdopts, {'term':self, 'on_exit':self.onExit})
  let self.job = termopen(a:opts.cmd, a:opts.cmdopts)
  let self.cmd = a:opts.cmd
  let self.cmdopts = a:opts.cmdopts
endfunction

function! s:term.postOpen() abort
  if self.autoInsert && !has_key(self, 'cmd')
    normal! i
  endif
endfunction

function! s:term.doHide() abort
  hide
endfunction

function! misc#term#nvim#spawn(opts) abort
  let term = misc#term#nvim#new()
  call term.spawn(a:opts)
  return term
endfunction
