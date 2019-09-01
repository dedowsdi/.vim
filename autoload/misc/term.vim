let g:term_type = get(g:, 'term_type', '')
if empty(g:term_type)
  let g:term_type = has('nvim') ? 'nvim' : 'vim'
endif

let s:jterm_layout = get(g:, 'misc_jterm_layout', {})
call extend(s:jterm_layout, {'position':'bot' , 'psize':0.4}, 'keep')
let s:gterm_layout = get(g:, 'misc_gterm_layout', {})
call extend(s:gterm_layout, {'position':'bot', 'psize':0.5}, 'keep')

let s:term = {'job_finished':0}

" a jterm represents a job term
let s:jterms=[]

" unique global term
let s:gterm = {}

function! misc#term#new()
  return deepcopy(s:term)
endfunction

function! s:term.toggle() abort
  if self.is_open()
    call self.hide()
  else
    call self.open()
  endif
endfunction

function! s:term.done() abort
  return self.job_finished
endfunction

" opts: { cmd:, cmdopts:, switch: }
function! misc#term#jtermopen(opts) abort

  if empty(get(a:opts, 'cmd', ''))
    throw 'missing cmd for job term'
  endif

  let oldwinid = win_getid()

  call extend(a:opts, {'cmdopts':{}, 'layout':s:jterm_layout, 'switch':0, 'list':s:jterms}, 'keep')
  let jterm = s:spawn(a:opts)

  let s:jterms += [jterm]

  if !a:opts.switch
    call win_gotoid(oldwinid)
  endif

  return jterm
endfunction

function! misc#term#close_finished() abort
  for jt in s:jterms
    if jt.done()
      call jt.close()
    endif
  endfor
endfunction

function! misc#term#close_all() abort
  for jt in s:jterms
    call jt.close()
  endfor
endfunction

function! s:spawn(opts) abort

  call extend(a:opts, {'layout': s:gterm_layout}, 'keep')

  if g:term_type ==# 'vim'
    return misc#term#vim#spawn(a:opts)
  elseif g:term_type ==# 'nvim'
    return misc#term#nvim#spawn(a:opts)
  else
    return misc#term#tmux#spawn(a:opts)
  endif

endfunction

function! misc#term#toggle_gterm() abort
  if type(s:gterm) != v:t_dict
    let s:gterm = {}
  endif

  if s:gterm == {} || !s:gterm.exists()
    let s:gterm = s:spawn({})
  else
    call s:gterm.toggle()
  endif
endfunction
