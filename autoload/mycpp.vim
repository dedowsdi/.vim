" vars{{{1
let g:mycppCompiler = ($CC =~# '\v.*clang$' || $CXX =~# '\v.*clang\+\+$') ? 'clang' : 'gcc'
let g:mycppDebugger = g:mycppCompiler ==# 'clang' ? 'lldb' : 'gdb'
let g:mycppAutoDebugScript = get(g:, 'mycppAutoDebugScript', 1)
let g:mycppDebugGui = 0

let s:jqtemp = system('mktemp /tmp/mycpp_jq_XXXXXX')[0:-2]
let s:pjcfg = fnamemodify('./.vim/project.json', '%:p')
let s:lastTarget = ''
let s:updatingFunction = {}
let s:ag = 'Ag'
let s:debug_term = {}

let s:dbgCmdsDict = {
  \ 'lldb':{
  \   'run' : 'lldb -s lldb_%s',
  \   'init' : 'file %s',
  \   'launch' : 'process launch --',
  \   'break' : 'breakpoint set --file %s --line %d' ,
  \   'watch' : 'watchpoint set var %s -w write',
  \   'print' : 'expression --',
  \   'setArgs'  : 'settings set target.run-args',
  \ },
  \ 'gdb':{
  \   'run' : 'gdb --silent -command gdb_%s',
  \   'gui' : 'gdbgui -x gdb_%s',
  \   'init' : 'file %s',
  \   'launch' : 'run',
  \   'break' : 'b %s:%d' ,
  \   'watch' : 'watch %s',
  \   'print' : 'expression --',
  \   'setArgs' : 'set args',
  \ }
  \ }

let s:dbgCmds = s:dbgCmdsDict[g:mycppDebugger]

function! mycpp#getBuildDir() abort
  return myvim#normDir(fnamemodify(g:mycppBuildDir, ':p'))
endfunction

function! mycpp#getBinaryDir() abort
  let buildDir = mycpp#getBuildDir()
  let dir =  get(g:, 'mycppBinaryDir', buildDir) . 'bin/'
  return isdirectory(dir) ? dir : buildDir
endfunction

function! mycpp#getMakeResult() abort
  return 'make_result'
  "return mycpp#getBuildDir() . 'make_result'
endfunction

" Get list of enumerations, it's placed at register e by default
" @cursor range : enum name line, not after {
" @param1 reg : result register
function! mycpp#getEnums(...) abort
  let [startLine, startCol] = [line('.'), col('.')]|try
    let reg = a:0 >= 1 ? a:0 : 'g' 
    let res = []
    let tempQ = @"
    call search('{')|keepjumps normal! %
    silent normal! yi{
    let enumStr = mycpp#rmComment(@")
    let enumStr = mycpp#rmBlank(enumStr)
    let enums = split(enumStr, '\v,')
    let strRes = join(enums, "\n")
    execute 'let @'.reg.' = strRes'
    let @" = tempQ
    return enums
  finally|call cursor(startLine, startCol)|endtry
endfunction

" generate case at register 
function! mycpp#genEnumCase(...) abort
  let reg = get(a:000, 0, 'g')
  let enums = mycpp#getEnums()
  let res = ''
  if enums != []
    for enum in enums
      let res .= 'case '. enum . ":\nbreak;\n"
    endfor
  endif
  execute 'let @'.reg.' = res'
endfunction

" deprecated this will cause problem if there is a blank line after head guard
function! mycpp#gotoFirstNonInclude() abort
  keepjumps normal! gg
  call search('\v^(\s*#include)@!.*$')
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
      call myvim#warn("don't know where last include is")
      return 0
    endif
  endif
  normal! zz
  return 1
endfunction

function! mycpp#isCmtLine(...) abort
  let lnum =get(a:000, 0, line('.'))
  return mycpp#getCmtRange(lnum) != []
endfunction

function! s:toggleComment(range) abort
  call cursor(a:range[0], 1)
  exec 'normal! V'
  let numLines = a:range[1]-a:range[0]
  if numLines > 0   " 0j is the same as 1j
    exec 'normal! ' . numLines . 'j'
  endif
  exec 'normal \c '
endfunction

" toggle comment function
function! mycpp#cmtFunc() abort
  if !mycpp#isInHead()
    call myvim#warn('you should call this at head file')
    return
  endif
  let [startLine, startCol, curFile] = [line('.'), col('.'), expand('%')]|try
    if mycpp#isFuncDef()
      "defined while declaring
      let funcDef = mycpp#getFuncDetail()
      "//---- in funcdef will break toggleComment, better avoid it
      call s:toggleComment([funcDef.head[0][0], funcDef.body[1][0]])
    else
      "comment definition
      if mycpp#jumpToFuncDef()
        let funcDef = mycpp#getFuncDetail()
        call s:toggleComment([funcDef.head[0][0], funcDef.body[1][0]])
        silent call mycpp#gotoAlternateFile()
        call cursor(startLine,startCol)
      endif
      "comment declaration
      let funcDec = mycpp#getFuncDetail()
      call s:toggleComment([funcDec.head[0][0], funcDec.head[1][0]])
    endif
  finally|silent! exec 'edit '.curFile|call cursor(startLine, startCol)|endtry
endfunction

" command complete
function! mycpp#makeComplete(ArgLead, CmdLine, CursorPos) abort
  return sort(filter(mycpp#getMakeTargets(), 'stridx(v:val, a:ArgLead)==0'))
endfunction

function! mycpp#getMakeCmd(target) abort
  return printf('cd %s && unbuffer make %s %s |& tee %s',
                \ g:mycppBuildDir, mycpp#getTargetItem(a:target, 'make_args'), a:target, mycpp#getMakeResult())
endfunction

function! mycpp#getRunCmd(target, targetArgs) abort
  return printf('cd %s && ./%s %s', mycpp#getBinaryDir(), mycpp#getExe(a:target), a:targetArgs)
endfunction

function! mycpp#getDebugCmd() abort
    return printf('cd %s && %s', mycpp#getBinaryDir(), get(g:, 'mycppDebugGui') ? s:debug_gui() : s:debug_run() )
endfunction

" (cmd [, tail])
function! mycpp#updateProjectFile(cmd, ...) abort
  let tail = get(a:000, 0, '')
  let cmd = printf('%s %s>%s && mv %s %s %s', a:cmd, s:pjcfg, s:jqtemp, s:jqtemp, s:pjcfg, tail)
  call system(cmd)
endfunction

function! mycpp#createTargetIfNotExist(target) abort
  " init project file
  call system(printf('[[ ! -s "%s" ]] && echo "{}" > %s', s:pjcfg, s:pjcfg))

  " init target
  let cmd = printf('jq -e ''.["%s"]'' %s || ( jq ''. + {"%s" : {"breakpoint":[],"manual":[]}}'' ', a:target, s:pjcfg, a:target )
  call mycpp#updateProjectFile(cmd, ')')
endfunction

" [default value]
" return '' or default value or value in default project if item does not exist
function! mycpp#getTargetItem(target, exp, ...) abort
  call mycpp#createTargetIfNotExist(a:target)
  let cmd = printf('jq -r ''.["%s"].%s'' %s', a:target, a:exp, s:pjcfg)
  let value = system(cmd)[0:-2]
  if value !=# 'null'
    return value
  endif

  if len(a:000) > 0
    return a:1
  endif

  if a:target ==# '__default__'
    return ''
  endif

  return mycpp#getTargetItem('__default__', a:exp)
endfunction

function! mycpp#setTargetItem(target, exp, value) abort
  call mycpp#createTargetIfNotExist(a:target)
  " setpath works nomatter item exists or not
  let jqvalue = substitute(escape(a:value, '"\\'), "'", "'\\\\''", 'g')
  call mycpp#updateProjectFile(printf('jq ''setpath(path(.["%s"].%s); "%s")'' ', a:target, a:exp, jqvalue))
endfunction

function! mycpp#updateTarget(args) abort
  let [target, targetArgs] = mycpp#splitTargetAndArgs(a:args)
  if !s:isTarget(target)
    call myvim#warn(target . ' is not a valid make target') | return [0, target, targetArgs]
  endif

  if targetArgs ==# ''
    let targetArgs = mycpp#getTargetItem(target, 'exe_args')
  else
    call mycpp#setTargetItem(target, 'exe_args', targetArgs)
  endif

  let s:lastTarget = target
  return [1, target, targetArgs]
endfunction

function! mycpp#make(args) abort
  let [success, target, targetArgs] = mycpp#updateTarget(a:args)
  if !success | return | endif
  cclose  " always close quickfix first
  call mycpp#sendjob(mycpp#getMakeCmd(target))
endfunction

function! mycpp#makeRun(args) abort
  let [success, target, targetArgs] = mycpp#updateTarget(a:args)
  if !success | return | endif
  call mycpp#sendjob(printf('%s && [[ ${pipestatus[0]} -eq 0 ]] && %s',
        \ mycpp#getMakeCmd(target), mycpp#getRunCmd(target, targetArgs)))
endfunction

function! mycpp#makeDebug(args) abort
  let [success, target, targetArgs] = mycpp#updateTarget(a:args)
  if !success | return | endif
  call mycpp#sendjob(printf('%s && [[ ${pipestatus[0]} -eq 0 ]] && %s', 
        \ mycpp#getMakeCmd(target), mycpp#getDebugCmd()))
endfunction

function! mycpp#doTarget(args0, args1, args2, ...) abort
  let jobtype = get(a:000, 0, 0)
  let [success, target, targetArgs] = mycpp#updateTarget(a:args1)
  if !success | return | endif
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

function! mycpp#isLastMakeSuccessed() abort
  let cmd = 'tail -n 1 ' . mycpp#getMakeResult()
  let lastline = system(cmd)[0:-2]
  return lastline =~# '^\v\[100\%\]\s*built\s*target\s*\w+'
endfunction

function! mycpp#makeQuickfix() abort
  if !mycpp#isLastMakeSuccessed()
    " remove color 
    let cmd = 'sed -i -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})*)?[mK]//g" ' . mycpp#getMakeResult()
    call system(cmd)
    exec 'cfile ' . mycpp#getMakeResult()
    copen
  endif
endfunction

function! mycpp#cmake() abort
  let buildType = fnamemodify(mycpp#getBuildDir(), ':h:t')
  if filereadable('.vim/cmake.sh')
    let cmd = printf('%s %s %s', '.vim/cmake.sh', buildType, g:mycppCompiler)
  else
    let cmd = 'cd ' . mycpp#getBuildDir() . ' && cmake -DCMAKE_BUILD_TYPE:STRING=' . buildType . ' ' . getcwd()
  endif
  call mycpp#sendjob(cmd)
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

" Deprecated, this func requirs qf get opened first, but cw failed to open it
" when ld error exists.
" @cursor range :
" @return :
function! mycpp#qfBufReadPost() abort
  if search('error:')
    let mycpp#makeSuccess = 0
  endif
endfunction

" generate make targets from Makefile
function! mycpp#getMakeTargets() abort
  let cmd = 'cd ' . mycpp#getBuildDir() . ' &&  make help | grep "\.\.\." | cut -d\  -f2'
  return systemlist(cmd)
endfunction

function! s:isTarget(target) abort
  let targets = mycpp#getMakeTargets()
  return index(targets, a:target) != -1
endfunction

function! mycpp#getExe(target) abort
  if !s:isTarget(a:target)
    call myvim#warn(a:target . ' is not a valid make target') | return ''
  endif
  let grepTarget =  printf(
        \ 'grep -Po ''\s+\-o\s+\S*'' `find %s 2>/dev/null -wholename ''*/CMakeFiles/%s.dir/link.txt''` | grep -Po ''[^\\/ \t]+$''', 
        \ mycpp#getBuildDir(), a:target)
  return system(grepTarget)[0:-2]
endfunction

" {cmd [,insert]}
function! mycpp#sendjob(cmd, ...) abort
  let switch=get(a:000, 0, 0)
  let autoInsert=get(a:000, 1, 0)
  let s:debug_term = misc#term#jtermopen({'cmd':a:cmd, 'switch':switch, 'autoInsert':autoInsert})
endfunction

function! mycpp#run(args) abort
  let [success, target, targetArgs] = mycpp#updateTarget(a:args)
  if !success | return | endif
  call mycpp#sendjob(mycpp#getRunCmd(target, targetArgs))
endfunction

function! mycpp#debug(args) abort
  let [success, target, targetArgs] = mycpp#updateTarget(a:args)
  if !success | return | endif
  call s:updateDebugScript()
  call mycpp#sendjob(mycpp#getDebugCmd(), 1, 1)
endfunction

" return [target, args], args will be predefined args if it's empty
function! mycpp#splitTargetAndArgs(cmd) abort

  if a:cmd ==# ''
    let target = mycpp#getMakeDef()
    let targetArgs = ''
  else
    "extract cmd args
    let l = matchlist(a:cmd, '\v(\S*)\s*(.*)$')
    let target = l[1]
    let targetArgs = l[2]
  endif

  return [target, targetArgs]
endfunction

" You need to create a dir and put all the third libs(or symbolic link) in it.
" @param libsDir : third lib dir name
function! mycpp#addDependencies(libsDir) abort
  if finddir(a:libsDir) ==# ''
    call myvim#warn(a:libsDir . " doesn't exists")
    return
  endif
  silent let thirdlib = systemlist('ls '.a:libsDir)
  for lib in thirdlib
    set path+=lib
  endfor
endfunction

function! mycpp#searchDerived(...) abort
  let className = get(a:000, 0, expand('<cword>'))
  if className ==# ''
    call myvim#warn('empty class name') | return
  endif
  exec 'Ctags inherits:' . className
endfunction

function! mycpp#getCmakeCache(name) abort
  let cacheStr = system('cd ' . mycpp#getBuildDir() . ' && cmake -LA -N ')
  let rexValue = '\v' . a:name . ':\w+\=\zs.{-}\ze\n' 
  return matchstr(cacheStr, rexValue)
endfunction

function! s:updateDebugScript() abort
  if g:mycppAutoDebugScript == 0
    return
  endif

  if empty(s:lastTarget)
    echom 'empty las target, you must make or run it first'
    return
  endif

  let file = printf('%s%s_%s', mycpp#getBinaryDir(), g:mycppDebugger, s:lastTarget)

  " file ..
  call system(printf('echo  ''%s''>%s', s:debug_init(), file ))
  " breakpoint
  

  let cmd = printf('jq -r ''.["%s"].breakpoint[] | "b " + .file + ":" + (.line|tostring) '' %s >> %s', 
        \ s:lastTarget, s:pjcfg, file)
  call system(cmd)

  " manual
  let cmd = printf('jq -r ''.["%s"].manual[]'' %s >> %s', 
        \ s:lastTarget, s:pjcfg, file)
  call system(cmd)

  " launch
  "call system(s:debug_run())
  let args = mycpp#getTargetItem(s:lastTarget, 'exe_args')
  call system(printf('echo %s %s >> %s', s:dbgCmds.setArgs, args, file))
  call system(printf('echo %s >> %s', s:debug_launch(), file))

  return file
endfunction

function! mycpp#openDebugScript() abort
  silent! exec 'edit ' . s:updateDebugScript()
endfunction

function! mycpp#openProjectFile() abort
  silent! exec 'edit ' . s:pjcfg
  if s:lastTarget !=# ''
    call search(printf('\v^\s*"<%s>"\s*:', s:lastTarget))
  endif
endfunction

" {"file":, "line":}
function! mycpp#indexBreakpoint(target, obj)
  let file = a:obj.file
  let line = a:obj.line
  let strObj = printf('{"file":"%s", "line":%i}', a:obj.file, a:obj.line)
  let cmd = printf('jq '' .["%s"].breakpoint | index(%s) '' %s', a:target, strObj, s:pjcfg)
  let idx = system(cmd)
  return idx ==# "null\n" ? -1 : str2nr(idx)
endfunction

" index
function! mycpp#clearBreakpoint(target, ...)
  
  if a:0 == 0
    let cmd = printf('jq ''setpath(path(.["%s"].breakpoint); [])''  ', s:lastTarget)
    call mycpp#updateProjectFile(cmd)
  else
    "let strObj = printf('{"file":%s, "line":%i}', a:obj.file, a:obj.line)
    "let cmd = printf('. as $f | .["%s"].breakpoint | index(%s) as $i
          "\ | if $i >= 0 then $f | del(.["%s"].breakpoint[$i]) else $f end ',
          "\ s:lastTarget, strObj, s:lastTarget)
    let idx = get(a:000, 0)
    let cmd = printf('jq ''del(.["%s"].breakpoint[%i])'' ', s:lastTarget, idx)
    call mycpp#updateProjectFile(cmd)
  endif
endfunction

function! mycpp#addBreakpoint(target, obj)
    let strObj = printf('{"file":"%s", "line":%i}', a:obj.file, a:obj.line)
    let cmd = printf('jq ''.["%s"].breakpoint |= .+ [%s] '' ', a:target, strObj)
    call mycpp#updateProjectFile(cmd)
endfunction

function! mycpp#singleLineBreak() abort
  if empty(s:lastTarget)
    echom 'empty las target, you must make or run it first'
    return
  endif
  call mycpp#createTargetIfNotExist(s:lastTarget)
  let obj = {'file':expand('%:t'), 'line':line('.')}

  call mycpp#clearBreakpoint(s:lastTarget)
  call mycpp#addBreakpoint(s:lastTarget, obj)
endfunction

function! mycpp#toggleBreakpoint() abort
  if empty(s:lastTarget)
    echom 'empty las target, you must make or run it first'
    return
  endif

  call mycpp#createTargetIfNotExist(s:lastTarget)
  let obj = {'file':expand('%:t'), 'line':line('.')}

  let idx = mycpp#indexBreakpoint(s:lastTarget, obj)
  if idx >= 0
    call mycpp#clearBreakpoint(s:lastTarget, idx)
  else
    call mycpp#addBreakpoint(s:lastTarget, obj)
  endif
endfunction

function! mycpp#send_debug_cmd(cmd) abort
  if s:debug_term == {} || ! s:debug_term.is_alive()
    return
  endif

  call jobsend(s:debug_term.jobid, a:cmd)
endfunction

function! mycpp#debugging_break_line() abort
  call mycpp#send_debug_cmd(s:debug_break()."\n")
endfunction

function! mycpp#debugging_print() abort
  call mycpp#send_debug_cmd(printf("%s %s\n", s:debug_print(), expand('<cword>')))
endfunction

function! s:debug_run() abort
  return printf(s:dbgCmds.run, s:lastTarget)
endfunction

function! s:debug_gui() abort
  return printf(s:dbgCmds.gui, s:lastTarget)
endfunction

function! s:debug_break() abort
  return printf(s:dbgCmds.break, expand('%:t'), line('.'))
endfunction

function! s:debug_watch() abort
  return printf(s:dbgCmds.watch, expand('<cword>'))
endfunction

function! s:debug_init() abort
  let file = mycpp#getExe(s:lastTarget)
  return printf(s:dbgCmds.init, fnamemodify(file, ':p:t'))
endfunction

function! s:debug_launch() abort
  return s:dbgCmds.launch
endfunction

function! s:debug_print() abort
  return s:dbgCmds.print
endfunction

function! mycpp#addDebugCommand(type) abort
  if !has_key(s:dbgCmds, a:type)
    echom 'unknown command type ' . a:type
    return
  endif
  let cmd =  call('s:debug_'.a:type, [])
  let @d .= printf("%s\n", cmd)
endfunction

function! mycpp#manualInclude() abort
  call mycpp#gotoLastInclude({'jump':1})
  exec 'normal! o#include ' |:startinsert!
endfunction

" assume head name is the same as cword
function! mycpp#autoInclude() abort
  let filename = printf('<%s>', expand('<cword>'))
  normal! mm
  call mycpp#gotoLastInclude({'jump':1})
  exec printf('normal! o#include %s', filename)
  normal! `m
endfunction
