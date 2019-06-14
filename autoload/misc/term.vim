let g:termType = get(g:, 'termType', '')
if empty(g:termType)
  let g:termType = has('nvim') ? 'nvim' : 'vim'
endif

let s:jtermLayout = get(g:, 'miscJtermLayout', {})
call extend(s:jtermLayout, {'position':'bot' , 'psize':0.4}, 'keep')
let s:gtermLayout = get(g:, 'miscGtermLayout', {})
call extend(s:gtermLayout, {'position':'bot', 'psize':0.5}, 'keep')

let s:term = {'jobFinished':0}

" a jterm represents a job term
let s:jterms=[]

" unique global term
let s:gterm = {}

function! misc#term#new()
  return deepcopy(s:term)
endfunction

function! s:term.toggle() abort
  if self.isOpen()
    call self.hide()
  else
    call self.open()
  endif
endfunction

function! s:term.done() abort
  return self.jobFinished
endfunction

" opts: { cmd:, cmdopts:, switch: }
function! misc#term#jtermopen(opts) abort

  if empty(get(a:opts, 'cmd', ''))
    throw 'missing cmd for job term'
  endif

  let oldwinid = win_getid()

  call extend(a:opts, {'cmdopts':{}, 'layout':s:jtermLayout, 'switch':0, 'list':s:jterms}, 'keep')
  let jterm = s:spawn(a:opts)

  let s:jterms += [jterm]

  if !a:opts.switch
    call win_gotoid(oldwinid)
  endif

  return jterm
endfunction

function! misc#term#closeFinished() abort
  for jt in s:jterms
    if jt.done()
      call jt.close()
    endif
  endfor
endfunction

function! misc#term#closeAll() abort
  for jt in s:jterms
    call jt.close()
  endfor
endfunction

function! s:spawn(opts) abort

  call extend(a:opts, {'layout': s:gtermLayout}, 'keep')

  if g:termType ==# 'vim'
    return misc#term#vim#spawn(a:opts)
  elseif g:termType ==# 'nvim'
    return misc#term#nvim#spawn(a:opts)
  else
    return misc#term#tmux#spawn(a:opts)
  endif

endfunction

function! misc#term#toggleGterm() abort
  if type(s:gterm) != v:t_dict
    let s:gterm = {}
  endif

  if s:gterm == {} || !s:gterm.exists()
    let s:gterm = s:spawn({})
  else
    call s:gterm.toggle()
  endif
endfunction
