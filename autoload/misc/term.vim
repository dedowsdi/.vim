" a term is a dict has keys: type, size, pos,job, cmd, opts,winnr, bufnr
let s:terms={}  " unique type : term

" open unique term window
" @param term.type : unique type identifier
" @param term.pos : J K H L
" @param term.size : widh for H L , height for J K
" @param term.termmode : true to stay, false to to jump back original window
" @param term.cmd : the same as termopen
" @param term.opts : the smae as termopen
" @return : newly created term  or {}
function! misc#term#termopenUnique(term) abort
  let term = deepcopy(a:term)
  call extend(term, {"pos":"J", "size":20, "termmode":0, "opts":{}, "type":"__term_global"}, "keep")
  let wb = s:openTermBuffer(term)
  if wb == {}
    call misc#warn("failed to open term")|return {}
  endif

  call extend(term, wb)
  if has_key(s:terms, term.type)
    throw "unknown status, " . a:type . " should be removed , but it doesn't"
  endif
  let s:terms[term.type] = term
  "pass term to termopen
  let term.job = termopen(term.cmd, extend(term.opts, {"term":term}))
  if term.termmode
    normal! i 
  elseif bufwinnr(term.origbufnr)  != -1
    exec bufwinnr(term.origbufnr) . 'wincmd w'
  endif 
  "echom "spawn term " . string(term)
  return term
endfunction

" open buffer for type. If type exists in s:terms, delete it's buffer if it has
" exited, otherwise show warn message. At last create new buffer and wnd to be
" used in term
" @param type : unique type identifier
" @param pos : J K H L
" @param size : widh for H L , height for J K
" @return : {} or {bufnr, origbufnr}
function! s:openTermBuffer(term) abort
  if stridx("JKLH", a:term.pos)  == -1
    throw 'invalid pos : ' . a:term.pos
  endif
  let origbufnr = bufnr('%')
  let hv = stridx("JK", a:term.pos) != -1 ? ['_', 'winfixheight'] : ['|', 'winfixwidth']
  if !misc#term#termcloseUnique(a:term.type)
    call misc#warn("failed to open terminal buffer")
    return {}
  endif

  exec 'new | wincmd ' . a:term.pos . ' | ' . a:term.size . 'wincmd ' . hv[0]
  "exec 'setl ' . hv[1]

  return {"bufnr":bufnr('%'), "origbufnr":origbufnr}
endfunction

" @param type : unique type
" @param 1 force : send jobstop if old job hasn't exit
" return : 0 if old job hasn't exit and force is not set
function! misc#term#termcloseUnique(type,...) abort
  let force = get(a:000, 0, 0)
  let oldterm = get(s:terms, a:type, {})

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
    "force delete term buffer which already exits anyway
    exec 'bdelete! '.oldterm.bufnr
  endif

  call remove(s:terms, a:type)

  return 1
endfunction

"test
"let s:testterm = {"cmd":"echo 0", "type":"echo"}
"call misc#term#termopenUnique(s:testterm)
