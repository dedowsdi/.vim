let g:mycppCompiler = ($CC =~# '\v.*clang$' || $CXX =~# '\v.*clang\+\+$') ? 'clang' : 'gcc'

let s:pjcfg = fnamemodify('./.vim/project.json', '%:p')
let s:lastTarget = ''
let s:debug_term = {}

function! mycpp#getBuildDir() abort
  return fnamemodify(g:mycppBuildDir, ':p')
endfunction

" use use g:mycppBuildDir/bin or g:mycppBuildDir as binary dir
function! mycpp#getBinaryDir() abort
  let buildDir = mycpp#getBuildDir()
  let dir =  get(g:, 'mycppBinaryDir', buildDir . 'bin/')
  return isdirectory(dir) ? fnamemodify(dir, ':p') : buildDir
endfunction

function! mycpp#getTarget(target)
  if !filereadable(s:pjcfg) | echoe s:pjcfg . ' not found' | return | endif
  let targetObj = get(json_decode(join(readfile(s:pjcfg), "\n")), a:target, {})
  call extend(targetObj, {'name':a:target, 'make':'-j 2', 'exe_args':''}, 'keep')
  return targetObj
endfunction

" command complete
function! mycpp#makeComplete(ArgLead, CmdLine, CursorPos) abort
  return sort(filter(mycpp#getMakeTargets(), 'stridx(v:val, a:ArgLead)==0'))
endfunction

function! mycpp#getMakeCmd(target) abort
  let obj = mycpp#getTarget(a:target)
  return printf('bash -c "cd %s && make %s %s "', g:mycppBuildDir, obj.make, a:target)
endfunction

function! mycpp#getRunCmd(target, targetArgs) abort
  return printf('bash -c "cd %s && ./%s %s "', mycpp#getBinaryDir(), mycpp#getExe(a:target), a:targetArgs)
endfunction

function! mycpp#make(args) abort
  let [target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  cclose | call mycpp#sendjob(mycpp#getMakeCmd(target))
endfunction

function! mycpp#makeRun(args) abort
  let [target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  call mycpp#sendjob(printf('%s && %s', mycpp#getMakeCmd(target),
        \ mycpp#getRunCmd(target, targetArgs)))
endfunction

function! mycpp#makeDebug(args) abort
  let [target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  call mycpp#sendjob(printf('%s && [[ ${pipestatus[0]} -eq 0 ]] && %s',
        \ mycpp#getMakeCmd(target), mycpp#getDebugCmd()))
endfunction

function! mycpp#doTarget(args0, args1, args2, ...) abort
  let jobtype = get(a:000, 0, 0)
  let [target, targetArgs] = mycpp#splitTargetAndArgs(a:args1)
  let runCmd = printf('./%s %s', mycpp#getExe(target), targetArgs)
  let cmd = printf('cd %s && %s %s %s', mycpp#getBinaryDir(), a:args0, runCmd, a:args2)
  if jobtype == 0
    call mycpp#sendjob(cmd)
  else
    " some application(such as render doc) can not be called with term open,
    " don't know why
    call jobstart(cmd)
  endif
endfunction

function! mycpp#openLastApitrace() abort
  let traceCmd = printf('cd %s && ls -t -1 *.trace | head -n 1', mycpp#getBinaryDir())
  let trace = system(traceCmd)[0:-2]
  let cmd = printf('cd %s && qapitrace ./%s', mycpp#getBinaryDir(), trace)
  call mycpp#sendjob(cmd)
endfunction

" Get default make target.
function! mycpp#getMakeDef() abort
  return s:lastTarget ==# '' ? mycpp#getMakeTargets()[0] : s:lastTarget
endfunction

" generate make targets from Makefile
function! mycpp#getMakeTargets() abort
  let cmd = 'cd ' . mycpp#getBuildDir() . ' &&  make help | grep "\.\.\." | cut -d\  -f2'
  return systemlist(cmd)
endfunction

function! s:isTarget(target) abort
  return index(mycpp#getMakeTargets(), a:target) != -1
endfunction

function! mycpp#getExe(target) abort
  if !s:isTarget(a:target)
    call misc#warn(a:target . ' is not a valid make target') | return ''
  endif
  let grepTarget =  printf(
        \ 'grep -Po ''\s+\-o\s+\S*'' `find %s 2>/dev/null -wholename ''*/CMakeFiles/%s.dir/link.txt''` | grep -Po ''[^\\/ \t]+$''', 
        \ mycpp#getBuildDir(), a:target)
  let path = system(grepTarget)[0:-2]
  " if you change directory, but ditn't clean cmake cache, you will get multiple
  " link result from above command.
  if stridx(path, "\n") != -1
    echoe  'found multiple link result : ' . path
  endif
  return path
endfunction

" {cmd [,insert]}
function! mycpp#sendjob(cmd, ...) abort
  let switch=get(a:000, 0, 0)
  let autoInsert=get(a:000, 1, 0)
  let s:debug_term = misc#term#jtermopen({'cmd':a:cmd, 'switch':switch, 'autoInsert':autoInsert})
endfunction

function! mycpp#run(args) abort
  let [ target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  call mycpp#sendjob(mycpp#getRunCmd(target, targetArgs))
endfunction

function! mycpp#debug(args) abort
  let [ target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  exec 'GdbDebug ' . mycpp#getBinaryDir() . mycpp#getExe(target) . ' ' . targetArgs
endfunction

" return [target, args], args will be predefined args if it's empty
function! mycpp#splitTargetAndArgs(cmd) abort
  if a:cmd ==# ''
    let target = mycpp#getMakeDef()
    let targetArgs = mycpp#getTarget(target).exe_args
  else
    let l = matchlist(a:cmd, '\v\s*(\S*)\s*(.*)$')
    let [target, targetArgs ] = [l[1], l[2]]
    if targetArgs ==# '' | let targetArgs = mycpp#getTarget(target).exe_args | endif
  endif
  let s:lastTarget = target
  return [target, targetArgs]
endfunction

function! mycpp#searchDerived(...) abort
  let className = get(a:000, 0, expand('<cword>'))
  if className ==# ''
    call misc#warn('empty class name') | return
  endif
  exec 'Ctags inherits:' . className
endfunction

function! mycpp#getCmakeCache(name) abort
  let cacheStr = system('cd ' . mycpp#getBuildDir() . ' && cmake -LA -N ')
  let rexValue = '\v' . a:name . ':\w+\=\zs.{-}\ze\n' 
  return matchstr(cacheStr, rexValue)
endfunction

function! mycpp#openProjectFile() abort
  silent! exec 'edit ' . s:pjcfg
  if s:lastTarget !=# ''
    call search(printf('\v^\s*"<%s>"\s*:', s:lastTarget))
  endif
endfunction

" opts : {"jump":bool}
function! mycpp#gotoLastInclude(...) abort
  "keepjumps normal! G
  let opts = get(a:000, 0, {'jump':0})
  let jumpFlag = opts.jump ? 's' : ''
  if !search('\v^\s*#include', 'bW'.jumpFlag)
    "if not found, goto 1st blank line
    keepjumps normal! gg
    if !search('\v^\s*$')
      call misc#warn("don't know where last include is") | return 0
    endif
  endif
  normal! zz
  return 1
endfunction

function! mycpp#manualInclude() abort
  call mycpp#gotoLastInclude({'jump':1}) | exec 'normal! o#include ' | startinsert!
endfunction
