" viml stuff
"
" [lnum]
function! misc#viml#gotoFunction(...) abort
  let lnum = get(a:000, 0, 0)
  let range = misc#viml#getFunctionRange()
  if range == [] | return 0 | endif
  call setpos('.', range[0])
  if lnum == 0 | return 1 | endif
  execute 'normal! '. lnum .'j' | return 1
endfunction

function! misc#viml#getFunctionRange() abort
  let cpos = getcurpos()
  exec 'norm! v' | call misc#viml#selFunction('i') | exec "norm! \<esc>"
  call setpos('.', cpos)
  let [pos0, pos1] = [getpos("'<"), getpos("'>")]
  return pos0 == pos1 ? [] : [pos0, pos1]
endfunction

function! misc#viml#selFunction(ai)
  call misc#to#selLines('\v^\s*fu%[nction]?\!?\s+\S+\(',
        \ '\v^\s*endf%[unction]?\s*$', a:ai, 1)
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
  let range = misc#viml#getFunctionRange()
  if range != []
    let candidates = misc#viml#searchNumberedFunctions(
          \ join(getline(range[0][1], range[1][1]), "\n"), 1000)
    let n = len(candidates)
    if n == 0 | echom 'no candidates found' | return | endif
    if n >= 1

      let breakLine = line('.') - range[0][1]
      for fnum in keys(candidates)
        let cmd = 'breakadd func ' . breakLine . ' ' . fnum | echom cmd
        execute cmd
      endfor
      return
    endif

  else
    echoe 'function not found' | return
  endif
endfunction

" return {fnum : def}
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


function! misc#viml#join() abort
  exec "normal! A |\<esc>gJ"
  if misc#getCC() =~# '\v\s'
    exec 'normal! cw '
  else
    exec 'normal! i '
  endif
endfunction

" [+-][size]
function! misc#viml#list(sfile, slnum, ...) abort
  let symbol = a:0 > 0 ? matchstr(a:1, '\v^[+\-]') : ''
  let size = a:0 > 0 ? matchstr(a:1, '\v\d+') : 10
  if empty(size) | let size = 10 | endif

  let fname = a:sfile
  let lnum = a:slnum

  if a:sfile =~# '\v^function.*'

    " note that function head and end is also returned from :function. slnum
    " starts from 1 after function head
    let lidx = a:slnum
    let funcName = split(a:sfile[9:], '\v\.\.')[-1]

    " take care of numbered function
    if funcName =~# '\v^\d+$'
      let funcName = printf('{%d}', funcName)
    endif

    " get script file of this function
    let def = split(execute('verbose function ' . funcName), "\n")[1]
    let [fname, funcLnum] = matchlist(def, '\v\s*Last set from\s*(.*) line (\d+)')[1:2]
    let lnum += funcLnum
  endif

  let lidx = lnum - 1
  let lines = readfile(fname)
  let digits = len(len(lines) + '')
  call map(lines, {idx, val -> printf('%s%*d : ',
        \ (idx == lidx ? '* ' : '  '), digits, idx+1) . val})

  if symbol ==# '+'
    let start_line = lidx
    let end_line = lidx + size - 1
  elseif symbol ==# '-'
    let start_line = lidx - size + 1
    let end_line = lidx
  else
    let hsize = (size - 1) * 0.5
    if hsize < 0 | let hsize = 0 | endif
    " display one more line after current line if slnum is even
    let start_line = max([lidx - float2nr(floor(hsize)), 0])
    let end_line = min([lidx + float2nr(round(hsize)), len(lines) - 1])
  endif

  while start_line <= end_line
    if start_line >= 0 && start_line < len(lines)
      echo lines[start_line]
    endif
    let start_line += 1
  endwhile
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
