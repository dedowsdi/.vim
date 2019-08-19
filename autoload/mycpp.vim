let g:mycppCompiler = ($CC =~# '\v.*clang$' || $CXX =~# '\v.*clang\+\+$') ? 'clang' : 'gcc'

let s:pjcfg = fnamemodify('./.vim/project.json', '%:p')
let s:lastTarget = ''
let s:debug_term = {}

function! mycpp#getBuildDir() abort
  return fnamemodify(g:mycppBuildDir, ':p')
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

function! mycpp#makePPComplete(ArgLead, CmdLine, CursorPos) abort
  let l = split(a:CmdLine, '\v\s+', 1)
  if l[0] ==# ''
    call remove(l, 0)
  endif
  let makeDir = len(l) < 3 ? mycpp#getBuildDir() : mycpp#getTargetPath(l[1]).makePath
  return sort(filter(mycpp#getMakeTargets(makeDir), 'stridx(v:val, a:ArgLead)==0'))
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
  call mycpp#exe('cd %B && make %t', 1, a:args)
endfunction

function! mycpp#makePP(target, tu) abort
  call mycpp#exe('cd %m && make ' . a:tu, 1, a:target)
endfunction

function! mycpp#makeRun(args) abort
  call mycpp#exe('cd %B && make %t && cd %b &&./%e', 1, a:args)
endfunction

function! mycpp#makeDebug(args) abort
  call mycpp#exe('cd %B && make %t && cd %b && gdb ./%e', 1, a:args)
endfunction

" cmd:
"   %a : args
"   %b : binary dir
"   %B : build dir
"   %e : executable
"   %E : absolute path of executable
"   %m : deepest make dir
"   %t : target
"   %% : literal %
function! mycpp#exe(cmd, term, args) abort
  let [target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  let targetPath = mycpp#getTargetPath(target)
  let absExe = targetPath.exePath
  let makeDir = targetPath.makePath
  let exe = fnamemodify(absExe, ':t')
  let binDir = fnamemodify(absExe, ':h')
  let buildDir = mycpp#getBuildDir()

  let cmd = escape(a:cmd, '"')
  let cmd = substitute(cmd, '\V\C%a', targetArgs, 'g')
  let cmd = substitute(cmd, '\V\C%b', binDir,     'g')
  let cmd = substitute(cmd, '\V\C%B', buildDir,   'g')
  let cmd = substitute(cmd, '\V\C%e', exe,        'g')
  let cmd = substitute(cmd, '\V\C%E', absExe,     'g')
  let cmd = substitute(cmd, '\V\C%m', makeDir,    'g')
  let cmd = substitute(cmd, '\V\C%t', target,     'g')
  let cmd = substitute(cmd, '\V\C%%', '%',        'g')
  call misc#log#debug(cmd)

  if a:term
    call mycpp#sendjob(cmd)
  else
    " some application(such as render doc) can not be called with term open,
    " don't know why
    if(has('nvim'))
      call jobstart(cmd)
    else
      " job_start in vim8 can't handle gui application ?
      " call job_start(printf('bash -c "%s"', cmd))
      exe printf('!bash -c "%s" &', cmd)
    endif
  endif

endfunction

" Get default make target.
function! mycpp#getMakeDef() abort
  return s:lastTarget ==# '' ? mycpp#getMakeTargets()[0] : s:lastTarget
endfunction

" generate make targets from Makefile
function! mycpp#getMakeTargets(...) abort
  let dir = get(a:000, 0, mycpp#getBuildDir())
  let cmd = 'cd ' . dir . ' &&  make help | grep -Po "\.\.\. \K.+"'
  return systemlist(cmd)
endfunction

function! s:isTarget(target) abort
  return index(mycpp#getMakeTargets(), a:target) != -1
endfunction

function! mycpp#getExe(target) abort
  return fnamemodify(mycpp#getTargetPath(a:target).exePath, ':t')
endfunction

function! mycpp#getTargetPath(target) abort
  if a:target ==# 'all'
    throw 'all has no target path'
  endif

  " if !filereadable(s:pjcfg)
    " return a:target
  " endif

  if !s:isTarget(a:target)
    call misc#warn(a:target . ' is not a valid make target') | return ''
  endif

  let buildDir = mycpp#getBuildDir()

  " find make_dir/target.dir/CMakeFiles/link.txt
  let linkTail = printf('CMakeFiles/%s.dir/link.txt', a:target)
  let cmd = printf('find %s -type f -wholename ''*/%s'' ', buildDir, linkTail)
  call misc#log#debug(cmd)
  let linkPath = systemlist(cmd)

  if linkPath == []
    echoe 'failed to get link.txt path for target ' . a:target
  elseif len(linkPath) > 1
    " if you change directory, but ditn't clean cmake cache, you will get multiple
    " link result from above command.
    echoe 'multiple link.txt found for target '
          \ . a:target . ' : ' . string(linkPath)
  endif
  if v:shell_error != 0
    throw 'failed to execute : ' . cmd
  endif

  let linkPath = linkPath[0]
  let makePath = linkPath[ 0 : -len(linkTail) - 1]

  let cmd = printf('grep -Po ''\s+\-o\s+\K\S+'' ''%s'' ', linkPath)
  call misc#log#debug(cmd)
  let exePath = simplify(makePath . systemlist(cmd)[0])
  if v:shell_error != 0
    throw 'failed to execute : ' . cmd
  endif

  return { "makePath" : makePath, "exePath" : exePath }
endfunction

function! mycpp#getArgs()
  let [target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  return targetArgs
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
  call mycpp#exe('cd %b && ./%e', 1, a:args)
endfunction

function! mycpp#debug(args) abort
  let [ target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  exec 'Termdebug ' . mycpp#getTargetPath(target).exePath . ' ' . targetArgs
  wincmd p
  wincmd H
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
