" a jterm represents a job term, it will be closed after it finishes is't job
let s:jterms={}  " unique type : jterm
let s:terminal = {}  " unique terminal, there should be only 1 terminal, nomore
let s:termbase = {"layout":"J", "size":20, "bufnr":-1}

" open buf or jump to buf wnd, do nothing if term buf doesn't exists
function! s:termbase.open() dict
  if self.bufnr == -1 || !bufexists(self.bufnr)
    call misc#warn("buffer " . self.bufnr . "doesn't exists ")
    return
  endif

  if bufwinnr(self.bufnr) != -1
    exec bufwinnr(self.bufnr).'wincmd w'
  else
    call s:newWndBuf(self)
    execute 'buffer ' . self.bufnr
  endif
endfunction

" hide buffer
function! s:termbase.hide() dict
  if self.bufnr == -1 || !bufexists(self.bufnr)
    call misc#warn("buffer " . self.bufnr . "doesn't exists ")
    return
  endif

  if bufwinnr(self.bufnr) != -1
    exec bufwinnr(self.bufnr).'wincmd w | q'
  endif
endfunction


" open unique jterm window
" @param jterm.type : unique type identifier
" @param jterm.layout : J K H L
" @param jterm.size : widh for H L , height for J K
" @param jterm.termmode : true to stay, false to to jump back original window
" @param jterm.cmd : the same as termopen
" @param jterm.opts : the smae as termopen
" @return : newly created jterm  or {}
function! misc#term#jtermopen(jterm) abort
  let jterm = copy(a:jterm)
  call extend(jterm, s:termbase, "keep")
  call extend(jterm, {"termmode":0, "opts":{}, "type":"global"}, "keep")
  let wb = s:openJTermBuffer(jterm)
  if wb == {}
    call misc#warn("failed to open jterm")|return {}
  endif

  call extend(jterm, wb)
  if has_key(s:jterms, jterm.type)
    throw "unknown status, " . a:type . " should be removed , but it doesn't"
  endif
  let s:jterms[jterm.type] = jterm
  "pass jterm to termopen
  let jterm.job = termopen(jterm.cmd, extend(jterm.opts, {"jterm":jterm}))
  if jterm.termmode
    normal! i
  elseif bufwinnr(jterm.origbufnr)  != -1
    exec bufwinnr(jterm.origbufnr) . 'wincmd w'
  endif
  "echom "spawn jterm " . string(jterm)
  return jterm
endfunction


" open buffer for type. If type exists in s:jterms, delete it's buffer if it has
" exited, otherwise show warn message. At last create new buffer and wnd to be
" used in jterm
" @param type : unique type identifier
" @param layout : J K H L
" @param size : widh for H L , height for J K
" @return : {} or {bufnr, origbufnr}
function! s:openJTermBuffer(jterm) abort
  if stridx("JKLH", a:jterm.layout)  == -1
    throw 'invalid layout : ' . a:jterm.layout
  endif
  let origbufnr = bufnr('%')
  if !misc#term#jtermclose(a:jterm.type)
    call misc#warn("failed to open terminal buffer")
    return {}
  endif

  return {"bufnr":s:newWndBuf(a:jterm), "origbufnr":origbufnr}
endfunction

" @param type : unique type
" @param 1 force : send jobstop if old job hasn't exit
" return : 0 if old job hasn't exit and force is not set
function! misc#term#jtermclose(type,...) abort
  let force = get(a:000, 0, 0)
  let oldterm = get(s:jterms, a:type, {})

  if oldterm == {}|return 1|endif
  if misc#hasjob(oldterm.job)
    if force
      call jobstop(oldterm.job)
    else
      call misc#warn(" old ". a:type . " hasn't exit")
      return 0
    endif
  endif

  if bufexists(oldterm.bufnr)
    "force delete jterm buffer which already exits anyway
    exec 'bdelete! '.oldterm.bufnr
  endif

  call remove(s:jterms, a:type)

  return 1
endfunction

" open window
" @param wnd : {"layout":,"size":, "fix":}
" return : newly created bufnr, not winnr
function! s:newWndBuf(wnd)
  let hv = stridx("JK", a:wnd.layout) != -1 ? ['_', 'winfixheight'] : ['|', 'winfixwidth']
  exec 'new | wincmd ' . a:wnd.layout . ' | ' . a:wnd.size . "wincmd" . hv[0]
  if get(a:wnd, "fix", 0)
    exec 'set ' . hv[1]
  endif
  return bufnr('%')
endfunction


" open global terminal. There should be only 1 global terminal.
" @param1 terminal : init option. it's ignored if terminal already exists
function! misc#term#terminal(...)

  if s:terminal != {} && bufexists(s:terminal.bufnr)
    "switch to  existing terminal buffer
    call s:terminal.open()
    return
  endif

  let s:terminal = extend(get(a:000, 0, {}), copy(s:termbase), "keep")
  "create new terminal
  let s:terminal.bufnr = s:newWndBuf(s:terminal)
  exec 'terminal'

endfunction

"test
"let s:testterm = {"cmd":"echo 0", "type":"echo"}
"call misc#term#jtermopen(s:testterm)
