" a jterm represents a job term, it will be closed after it finishes it's job.
let s:jterms=[]
let s:gterm = {}  " unique global term
let s:termbase = {'bufnr':-1, 'autoInsert':0}
let s:jtermlog = system('mktemp /tmp/misc_term_$(date +%H_%M_%S)_XXXXXX.log')

let s:jtermLayout = get(g:, 'miscJtermLayout', {})
call extend(s:jtermLayout, {'position':'bot' , 'psize':0.5}, 'keep')
let s:gtermLayout = get(g:, 'miscGtermLayout', {})
call extend(s:gtermLayout, {'position':'bot', 'psize':0.5}, 'keep')

function! s:term_exists() dict abort
  return self.bufnr != -1 && bufexists(self.bufnr)
endfunction

function! s:term_isOpen() dict abort
  return bufwinid(self.bufnr) != -1
endfunction

function! s:term_isActive() dict abort
  return bufnr('') == self.bufnr
endfunction

function! s:term_gotoWin() dict abort
  call win_gotoid(bufwinid(self.bufnr))
endfunction

function! s:term_winrest() dict abort
  if has_key(self, 'winrestcmd')
    exec printf('winresetcmd %s', self.winrestcmd)
  endif
endfunction

" open buf or jump to buf wnd, do nothing if term buf doesn't exists
function! s:term_open() dict abort
  if self.isOpen()
    call self.gotoWin()
  else
    call misc#term#split(self.layout, printf('sbuffer %d', self.bufnr))
  endif
  if self.autoInsert
    normal! ii
  endif
endfunction

" [hideOnly]
function! s:term_hide(...) dict abort
  if !self.isOpen()
    return
  endif

  let hideOnly = get(a:000, 0, 0)
  if !hideOnly
    let fixedWins = misc#term#getFixedWins()
  endif

  let oldwinid=win_getid('')
  call self.gotoWin()
  q
  if hideOnly
    return
  endif
  call win_gotoid(oldwinid)
  "call self.winrest()
  call misc#term#resetFixedWinSize(fixedWins)
endfunction

function! s:term_toggle() dict abort
  if self.isOpen()
    call self.hide()
  else
    call self.open()
  endif
endfunction

function! s:term_close() dict abort
  if bufexists(self.bufnr)
    exec printf('bdelete! %d', self.bufnr)
  endif
endfunction

function! s:jterm_close() dict abort
  "call system(printf('echo ------------------------------------------------------------>>%s', s:jtermlog))
  "call system(printf('echo $(date +%%H:%%M:%%S)>>%s', s:jtermlog))
  "call system(printf('echo %s>>%s', myvim#literalize(self.cmd, 1), s:jtermlog))
  if bufexists(self.bufnr)
    " copy content to bak
    "let lines = join(getbufline(self.bufnr, 1, '$'), "\n")
    "call system(printf('echo %s>>%s', myvim#literalize(lines, 1), s:jtermlog))
    exec printf('bdelete! %d', self.bufnr)
  endif
  call filter(s:jterms, printf('v:val.bufnr != %d', self.bufnr))
endfunction

function! s:jterm_done() dict abort
  return self.jobFinished
endfunction

function! s:jterm_onJobExit(job_id, data, event) dict abort
  let self.jterm.jobFinished = 1
endfunction

let s:termbase.exists   = function('s:term_exists')
let s:termbase.isOpen   = function('s:term_isOpen')
let s:termbase.isActive = function('s:term_isActive')
let s:termbase.gotoWin  = function('s:term_gotoWin')
let s:termbase.winrest  = function('s:term_winrest')
let s:termbase.open     = function('s:term_open')
let s:termbase.hide     = function('s:term_hide')
let s:termbase.toggle   = function('s:term_toggle')
let s:termbase.close    = function('s:term_close')

let s:jtermbase = deepcopy(s:termbase)
call extend(s:jtermbase, {'jobFinished':0}, 'keep')
let s:jtermbase.close = function('s:jterm_close')
let s:jtermbase.done = function('s:jterm_done')

" jterm: { cmd:, opts:, switch: }
function! misc#term#jtermopen(jterm) abort
  let oldwinid = win_getid()
  let jterm = copy(a:jterm)
  call extend(jterm, s:jtermbase, 'keep')
  call extend(jterm, {'opts':{}, 'layout':s:jtermLayout, 'switch':0}, 'keep')

  " hook default exit callback
  if !has_key(jterm.opts, 'on_exit')
    call extend(jterm.opts, {'on_exit': function('s:jterm_onJobExit')})
  endif
  call extend(jterm.opts, {'jterm':jterm})

  call misc#term#closeFinishedJterms()

  let s:jterms += [jterm]

  call misc#term#split(jterm.layout, 'new')
  let jterm.bufnr = bufnr('')
  let jterm.jobid = termopen(jterm.cmd, jterm.opts )

  if ! jterm.switch
    call win_gotoid(oldwinid)
  else
    call jterm.open() " trigger insert
  endif

  return jterm
endfunction

function! misc#term#closeFinishedJterms() abort
  for jt in s:jterms
    if jt.done()
      call jt.close()
    endif
  endfor
endfunction

let s:gtermbase=deepcopy(s:termbase)
let s:gtermbase.autoInsert=1

function! misc#term#toggleGterm() abort
  if s:gterm == {} || !s:gterm.exists()
    " create new global termianl
    let s:gterm = deepcopy(s:gtermbase)
    let s:gterm.layout = s:gtermLayout
    call misc#term#split(s:gterm.layout, 'new')
    let s:gterm.bufnr = bufnr('')
    " terminal and term will consume the newly created blank buffer
    exec 'terminal'
    let s:gterm.jobid = b:terminal_job_id
    let s:gterm.title = b:term_title
    let s:gterm.pid = b:terminal_job_pid
    call s:gterm.open()
  else
    call s:gterm.toggle()
  endif
endfunction

" wnd commands and options
let s:wcos={
  \ 'top' : { 'split':'to'     , 'resize':'res', 'searchFix':'wfh', 'fixedSize':'height', 'size':'lines'} ,
  \ 'left': { 'split':'to vert', 'resize':'vert res'     , 'searchFix':'wfw', 'fixedSize':'width' , 'size':'co'   } ,
  \ 'bot':  { 'split':'bo'     , 'resize':'res', 'searchFix':'wfh', 'fixedSize':'height', 'size':'lines'} ,
  \ 'right':{ 'split':'bo vert', 'resize':'vert res'     , 'searchFix':'wfw', 'fixedSize':'width' , 'size':'co'   }
  \ }

function! misc#term#split(layout, splitCmd) abort
  let wco = s:wcos[a:layout.position]
  exec printf('%s %s', wco.split, a:splitCmd)
  if has_key(a:layout, 'psize')
    let wndsize=0
    exec printf('let wndsize = &%s', wco.size)
    exec printf('%s %d', wco.resize, float2nr(wndsize * a:layout.psize) )
  endif
  if has_key(a:layout, 'size')
    exec printf('%s %d', wco.resize, a:layout.size)
  endif
endfunction
" get fixed win id, size pairs
function! misc#term#getFixedWins() abort
  let l:count = winnr('$')
  let res = []
  let wco = s:wcos[s:gtermLayout.position]

  for i in range(l:count)
    " do i have to goto specific window to get option?
    let fix = getwinvar(i+1, '&'.wco.searchFix)
    if fix == 1
      let winid = win_getid(i+1)
      let size = getwininfo(winid)[0][wco.fixedSize]
      let res += [[winid, size]]
    endif
  endfor
  return res
endfunction

function! misc#term#resetFixedWinSize(fixedWins) abort
  let wco = s:wcos[s:gtermLayout.position]
  let resizeCmd = substitute(wco.resize, 'res', '%dres', '') . ' %d'
  for [winid, size] in a:fixedWins
    exec printf(resizeCmd, bufwinnr(winbufnr(winid)), size)
  endfor
endfunction

function! misc#term#openJtermLog() abort
  exec printf('edit %s', s:jtermlog)
endfunction

function! misc#term#hideall() abort
  let oldwinid = win_getid()
  let fixedWins = misc#term#getFixedWins()
  for jt in s:jterms
    call jt.hide(1)
  endfor
  if s:gterm != {}
    call s:gterm.hide(1)
  endif
  call misc#term#resetFixedWinSize(fixedWins)
  call win_gotoid(oldwinid)
endfunction

" vim: set foldmethod=indent:
