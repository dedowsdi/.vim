if exists('g:loaded_misc_viml')
  finish
endif
let g:loaded_misc_viml = 1

" viml stuff
"
" [lnum]
function! misc#viml#gotoFunction(...) abort
  let lnum = get(a:000, 0, 0)
  normal! $
  if search('\v^\s*fu' , 'bW')
    if lnum == 0 | return 1 | endif
    execute 'normal! '. lnum .'j' | return 1
  endif
  return 0
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
function! misc#viml#breakFunction() abort
  let [startLine, startCol] = [line('.'), col('.')]|try
    if misc#viml#gotoFunction()

      let funcName = matchstr(getline('.'), '\v\zs[^ \t]+\ze\s*\(.*\)')
      let breakLine = startLine - line('.')
      if misc#viml#isScopeScript()
        "add <SNR>SID_ prefix
        let funcName = '<SNR>'.misc#viml#getSid(@%).'_'.funcName[2:]
      endif
    else
      echoe 'function not found'
    endif

    execute 'breakadd func ' . breakLine . ' ' . funcName
  finally|call cursor(startLine, startCol)|endtry
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
      if exists(scriptGuard)
        execute 'unlet ' . scriptGuard
      endif
      source %
    else
      throw 'script guard not found'
      return
    endif
  finally
    call setpos('.', oldpos)
  endtry
endfunction

