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
  let targetObj = filereadable(s:pjcfg) ?
        \ get(json_decode(join(readfile(s:pjcfg), "\n")), a:target, {}) : {}
  call extend(targetObj, {'name':a:target, 'make':'-j 2', 'exe_args':''}, 'keep')
  return targetObj
endfunction

" command complete
function! mycpp#makeComplete(ArgLead, CmdLine, CursorPos) abort
  return sort(filter(mycpp#getMakeTargets(), 'stridx(v:val, a:ArgLead)==0'))
endfunction

function! mycpp#getMakeCmd(target) abort
  let obj = mycpp#getTarget(a:target)
  return printf('cd %s && make %s %s', g:mycppBuildDir, obj.make, a:target)
endfunction

function! mycpp#getRunCmd(target, targetArgs) abort
  return printf('cd %s && ./%s %s', mycpp#getBinaryDir(), mycpp#getExe(a:target), a:targetArgs)
endfunction

" jterm, channel for vim8 (close_cb)
" jterm, jobid, data, event for neovim
" not working for tmux
function! s:make_callback(...)
  let jterm = a:1
  if jterm.exitCode == 0 || !has_key(jterm, 'bufnr')
    call setqflist([])
    return
  endif
  sleep 200ms
  exe 'cgetbuffer' s:jobTerm.bufnr
endfunction

function! mycpp#make(args) abort
  let [target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  cclose | call mycpp#sendjob(mycpp#getMakeCmd(target), {'close_cb' : function('s:make_callback')})
endfunction

function! mycpp#makePP() abort

  let cmakeDir = fnamemodify(findfile('CMakeLists.txt', '.;'), ':h')
  if empty(cmakeDir)
    throw 'failed to find CMakeLists.txt'
  endif

  let makeDir = mycpp#getBuildDir() . '/' . cmakeDir
  if !isdirectory(makeDir)
    throw makeDir . ' doesn''t exist'
  endif

  " common makeTarget is src/*.cpp.i
  let makeTarget = expand('%:p')[len(fnamemodify(cmakeDir, ':p')) : ] . '.i'

  let cmd = printf('cd %s && make %s', makeDir, makeTarget)
  call misc#log#debug(cmd)
  call system(cmd)
  if v:shell_error != 0
    throw 'failed to execute ' . cmd
  endif

  let wildignore = &wildignore
  set wildignore&
  vsplit
  exec printf('find %s/**/%s', makeDir, fnamemodify(makeTarget, ':t'))
  let &wildignore = wildignore
endfunction

function! mycpp#makeRun(args) abort
  let [target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  call mycpp#sendjob(printf('%s && %s', mycpp#getMakeCmd(target),
        \ mycpp#getRunCmd(target, targetArgs)))
endfunction

function! mycpp#makeDebug(args) abort
  let [target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  call mycpp#sendjob(printf('%s && [[ ${pipestatus[0]} -eq 0 ]] && %s',
        \ mycpp#getMakeCmd(target), mycpp#getDebugCmd()),
        \ {'close_cb' : function('s:make_callback')})
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
    if(has('nvim'))
      call jobstart(cmd)
    else
      " job_start in vim8 can't handle gui application ?
      " call job_start(printf('bash -c "%s"', cmd))
      exe printf('!bash -c "%s"', cmd)
    endif
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

  if !filereadable(s:pjcfg)
    return a:target
  endif

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
  if exists('s:jobTerm')
    call s:jobTerm.close()
    unlet s:jobTerm
  endif
  let cmd = a:cmd
  if !has('nvim') | let cmd = printf('bash -c "%s"', cmd) | endif
  let opts = get(a:000, 0, {})
  call extend(opts, {'cmd':cmd, 'switch':0, 'autoInsert':1}, 'keep')
  let s:jobTerm = misc#term#jtermopen(opts)
endfunction

function! mycpp#run(args) abort
  let [ target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  call mycpp#sendjob(mycpp#getRunCmd(target, targetArgs))
endfunction

function! mycpp#debug(args) abort
  let [ target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  " exec 'GdbDebug ' . mycpp#getBinaryDir() . mycpp#getExe(target) . ' ' . targetArgs
  exec 'Termdebug ' . mycpp#getBinaryDir() . mycpp#getExe(target) . ' ' . targetArgs
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

function! mycpp#setLastTarget(target)
  let s:lastTarget = a:target
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

function! mycpp#cmake()
  let path = findfile('cmake.sh', '**')
  if empty(path)
    return
  endif
  call mycpp#sendjob('./' . path)
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

function! mycpp#createTempTest()
  if !executable('cpptt')
    echoe 'cpptt not found'
    return
  endif
endfunction

function! mycpp#manualInclude() abort
  call mycpp#gotoLastInclude({'jump':1}) | exec 'normal! o#include ' | startinsert!
endfunction

function mycpp#debugToggleBreak()
  if empty(sign_getplaced('', {'lnum':9, 'group':''})[0].signs)
    Break
  else
    Clear
  endif
endfunction

function mycpp#debugStep()
  Step
endfunction

function mycpp#debugNext()
  Over
endfunction

function mycpp#debugContinue()
  Continue
endfunction

function mycpp#debugFinish()
  Finish
endfunction

function mycpp#debugEvaluate()
  Evaluate
endfunction

function mycpp#debugStop()
  Stop
endfunction

function mycpp#debugFrameUp()
  call TermDebugSendCommand('up')
endfunction

function mycpp#debugFrameDown()
  call TermDebugSendCommand('down')
endfunction
