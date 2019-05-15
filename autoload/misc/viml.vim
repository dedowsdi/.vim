" viml stuff
"
" [lnum]
function! misc#viml#gotoFunction(...) abort
  let lnum = get(a:000, 0, 0)
  let range = misc#viml#getFunctionRange()
  if range[0] == [] | return 0 | endif
  call setpos('.', range[0])
  if lnum == 0 | return 1 | endif
  execute 'normal! '. lnum .'j' | return 1
endfunction

" [leadingSpace]
function! misc#viml#getFunctionRange(...) abort
  let [cpos, range] = [getcurpos(), [[],[]]] | normal! $
  let re = get(a:000, 0, 0) ? '\v^\s*' : '\v^'
  if search(re.'fu(n(c(t(i(on?)?)?)?)?)?\!?\s+\S+\(' , 'bW')
    let start = getpos('.')
    if search(re.'endf(u(n(c(t(i(on?)?)?)?)?)?)?\s*$')
      let end = getpos('.')
      if misc#cmpPos(start, cpos) <= 0 && misc#cmpPos(cpos, end) <= 0
        let range = [start, end]
      endif
    endif
  endif
  call setpos('.', cpos) | return range
endfunction

function! misc#viml#selFunction(ai)
  let range = misc#viml#getFunctionRange()
  if range == [] | return | endif
  call setpos('.', range[0])
  normal! V
  call setpos('.', range[1])

  " add trailing or preceding space for 'a'
  if a:ai ==# 'a'
    " | branch is used to handle leader and trailing blank lines in the buffer
    if search('\v^.*\S.*$|%$', 'W')
      if getline('.') =~# '\S' | :- | endif
    endif
    if line('.') == range[1][1]
      normal! o
      " include preceding spaces if no following spaces exist
      if search('\v^.*\S.*$|%1l', 'bW')
        if getline('.') =~# '\S' | :- | endif
      endif
      normal! o
    endif
  endif
endfunction

" support both relative and absolute filename
function! misc#viml#getSid(fileName) abort
  redir => str | silent execute 'scriptnames' | redir END
  let [absName, baseName] = [fnamemodify(a:fileName, ':p'), fnamemodify(a:fileName, ':t')]
  " item format in scriptnames: 18: script name
  let scriptList = filter(split(str, "\n"), printf('v:val =~"%s"', baseName))
  let scriptList = filter(scriptList,
        \ printf('fnamemodify(matchstr(v:val, "\\v^\\s*\\d+:\\s*\\zs.+"), ":p") ==# "%s" ', absName))
  if empty(scriptList)
    throw a:fileName . ' not loaded'
  elseif len(scriptList) > 1
    throw a:fileName . ' loaded more than once?'
  endif
  return matchstr(scriptList[0], '\v\s*\zs\d+') + 0
endfunction

" break at current line in current function, doesn't work if it's a dict
" [funcName [,line, [,plugFileName]]]
function! misc#viml#breakHere() abort
  let cpos = getcurpos() | try
    if misc#viml#gotoFunction()

      let [scope, funcName] = matchlist(getline('.'), '\v(\w:)?(\k+)\ze\s*\(.*\)')[1:2]
      let breakLine = cpos[1] - line('.')
      if scope ==# 's:'
        "add <SNR>SID_ prefix
        let funcName = '<SNR>'.misc#viml#getSid(@%).'_'.funcName
      endif
    else
      echom 'breakadd here' | breakadd here | return
    endif

    let cmd = 'breakadd func ' . breakLine . ' ' . funcName | echom cmd
    execute cmd
  finally | call setpos('.', cpos) | endtry
endfunction

function! misc#viml#breakNumberedFunction() abort
  let range = misc#viml#getFunctionRange(1)
  if range[0] != []
    let candidates = misc#viml#searchNumberedFunctions(
          \ join(getline(range[0][1], range[1][1]), "\n"), 1000)
    let n = len(candidates)
    if n == 0 | echom 'no candidates found' | return | endif
    if n > 1
      " print results, and return
      for item in values(candidates)
        echo item | echo '' | echo ''
      endfor
      return
    endif

    let funcNumber = keys(candidates)[0]
    let breakLine = line('.') - range[0][1]
    let cmd = 'breakadd func ' . breakLine . ' ' . funcNumber | echom cmd
    execute cmd
  else
    echoe 'function not found' | return
  endif
endfunction

function! misc#viml#searchNumberedFunctions(funcDef, maxNumber)
  let lines0 = map(split(a:funcDef, "\n"), 'trim(v:val)')
  let prototype = matchstr(lines0[0], '\v(\(.*\))')
  let candidates = {}
  for i in range(a:maxNumber)
    try
      let def = execute(printf('function {%d}', i))
      let lines1 = split(def, "\n")
      if stridx(lines1[0], prototype) != -1
        let matched = 1
        for j in range(1, len(lines0)-1)
          if j >= len(lines1) | break | endif
          if trim(lines1[j][3:]) !=# lines0[j]
            let matched = 0 | break
          endif
        endfor
        if matched | let candidates[i] = def | endif
      endif
    catch /\v.*/
    endtry
  endfor
  return candidates
endfunction

function! misc#viml#isComment(lineString) abort
  return matchstr(a:lineString, '\v^\s*\zs\S') ==# '"'
endfunction

function! misc#viml#isScopeScript() abort
  return stridx(getline('.'), 's:') >= 0
endfunction

" be careful, you can't redefine misc#viml#reloadloadedScript while it's being
" called
if exists('*misc#viml#reloadLoadedScript')
  finish
endif

function! misc#viml#reloadLoadedScript() abort
  try
    let oldpos = getcurpos()
    let reScriptGuard = '\v^\s*let\s+\zs[gb]:loaded\w+\ze'
    keepjumps normal! gg
    if search(reScriptGuard, 'W')
      let scriptGuard = matchstr(getline('.'), reScriptGuard)
      if exists(scriptGuard) | execute 'unlet ' . scriptGuard | endif
      source %
    else
      throw 'script guard not found' | return
    endif
  finally
    call setpos('.', oldpos)
  endtry
endfunction

function! misc#viml#join() abort
  exec "normal! A |\<esc>gJ"
  if misc#getCC() =~# '\v\s'
    exec 'normal! cw '
  else
    exec 'normal! i '
  endif
endfunction
