let s:pjcfg = fnamemodify('./.dedowsdi/proj.json', '%:p')
let s:last_target = 'all'
let s:debug_term = {}

function ddd#cpp#get_build_dir() abort
  let dir = $CPP_BUILD_DIR
  if empty(dir)
    let dir = 'build/gcc/Debug' 
  endif
  return fnamemodify(dir, ':p')
endfunction

function ddd#cpp#dump_proj_file() abort
  let targets = ddd#cpp#get_make_targets()
  let obj = {}
  for target in targets

    " skip .i, .o, .s
    if target =~# '\v\..$'
      continue
    endif

    " skip cmake specific target
    if index(['depend', 'edit_cache', 'rebuild_cache', 'clean'], target) != -1
      continue
    endif

    let target_obj = ddd#cpp#get_target(target)

    " clear name and trivial working_dir
    call remove(target_obj, 'name')
    call extend(obj, {target : target_obj})
  endfor
  let tempfile = tempname()
  call writefile( split( json_encode( obj ), "\n" ), tempfile )
  call system(printf('jq "." %s > %s ', tempfile, s:pjcfg))
endfunction

" replace empty string with value in source
function s:extend_blank(target, source) abort
  for [key, value] in items(a:source)
    if !has_key(a:target, key) || empty(a:target[key])
      let a:target[key] = value
    endif
  endfor
endfunction

function ddd#cpp#get_target(target) abort
  let obj = filereadable(s:pjcfg) ?
        \ json_decode( join( readfile(s:pjcfg), "\n" ) ) : v:none
  let target_obj = type(obj) !=# type(v:none) ? get(obj , a:target, {} ) : {}
  call s:extend_blank(target_obj, { 'name':a:target, 'make_args':'-j 3',
        \ 'exe_args':'', 'working_dir':'' })
  return target_obj
endfunction

" command complete
function ddd#cpp#make_complete(arg_lead, cmd_line, cursor_pos) abort
  return sort(filter(ddd#cpp#get_make_targets(), 'stridx(v:val, a:arg_lead)==0'))
endfunction

function ddd#cpp#make_pp_complete(arg_lead, cmd_line, cursor_pos) abort
  let l = split(a:cmd_line, '\v\s+', 1)
  if l[0] ==# ''
    call remove(l, 0)
  endif
  let make_dir = len(l) < 3 ? ddd#cpp#get_build_dir() : ddd#cpp#get_target_path(l[1]).make_path
  return sort(filter(ddd#cpp#get_make_targets(make_dir), 'stridx(v:val, a:arg_lead)==0'))
endfunction

" jterm, channel for vim8 (close_cb)
" jterm, jobid, data, event for neovim
" not working for tmux
function s:make_callback(...)
  let jterm = a:1
  if jterm.exit_code == 0 || !has_key(jterm, 'bufnr')
    call setqflist([])
    return
  endif
  sleep 200ms
  exe 'cgetbuffer' s:job_term.bufnr
endfunction

function ddd#cpp#make_pp(target, tu) abort
  call ddd#cpp#exe('cd %m && make ' . a:tu, 1, a:target)
endfunction

" cmd:
"   %a : exe args
"   %A : cmd args
"   %b : binary dir
"   %B : build dir
"   %w : working dir
"   %e : executable
"   %E : absolute path of executable
"   %m : deepest make dir
"   %t : target
"   %% : literal %
function ddd#cpp#exe(cmd, term, args, ...) abort
  let exe_arg_idx = get(a:000, 0, 1)
  let [target, exe_args, cmd_args] = ddd#cpp#parse_command(a:args, exe_arg_idx)
  let target_path = ddd#cpp#get_target_path(target)
  let abs_exe = target_path.exe_path
  let make_dir = target_path.make_path
  let working_dir = target_path.working_dir
  let exe = fnamemodify(abs_exe, ':t')
  let bin_dir = fnamemodify(abs_exe, ':h')
  let build_dir = ddd#cpp#get_build_dir()

  if exe ==# '' && a:cmd =~? '\v\%e'
    echom target 'doesn''t have a corresponding executable file'
    return
  endif

  let $CPP_MAKE_PATH = make_dir
  let $CPP_BINARY_PATH = abs_exe
  let $CPP_BUILD_PATH = build_dir
  let $CPP_WORKING_PATH = working_dir

  let cmd = escape(a:cmd,   '"')
  let cmd = substitute(cmd, '\V\C%a', exe_args, 'g')
  let cmd = substitute(cmd, '\V\C%A', cmd_args, 'g')
  let cmd = substitute(cmd, '\V\C%b', bin_dir,  'g')
  let cmd = substitute(cmd, '\V\C%B', build_dir, 'g')
  let cmd = substitute(cmd, '\V\C%w', working_dir, 'g')
  let cmd = substitute(cmd, '\V\C%e', exe,      'g')
  let cmd = substitute(cmd, '\V\C%E', abs_exe,  'g')
  let cmd = substitute(cmd, '\V\C%m', make_dir,  'g')
  let cmd = substitute(cmd, '\V\C%t', target,   'g')
  let cmd = substitute(cmd, '\V\C%%', '%',      'g')

  call ddd#log#debug(cmd)

  if a:term
    call ddd#cpp#sendjob(cmd)
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

function ddd#cpp#get_default_target() abort
  return s:last_target ==# '' ? ddd#cpp#get_make_targets()[0] : s:last_target
endfunction

" generate make targets from Makefile
function ddd#cpp#get_make_targets(...) abort
  let dir = get(a:000, 0, ddd#cpp#get_build_dir())
  let cmd = 'cd ' . dir . ' &&  make help | grep -Po "\.\.\. \K.+"'
  return systemlist(cmd)
endfunction

function s:is_target(target) abort
  return index(ddd#cpp#get_make_targets(), a:target) != -1
endfunction

function ddd#cpp#get_target_path(target) abort
  let build_dir = ddd#cpp#get_build_dir()
  let blank_res = { 'make_path' : build_dir, 'exe_path' : '', 'working_dir' : '' }
  if a:target =~# '\v^all>'
    return blank_res
  endif

  if !s:is_target(a:target)
    call dddu#warn(a:target . ' is not a valid make target')
    return blank_res
  endif

  " find make_dir/target.dir/CMakeFiles/link.txt
  let link_tail = printf('CMakeFiles/%s.dir/link.txt', a:target)
  let cmd = printf('find %s -type f -wholename ''*/%s'' ', build_dir, link_tail)
  call ddd#log#debug(cmd)
  let link_path = systemlist(cmd)

  if link_path == []
    " echoe 'failed to get link.txt path for target ' . a:target
    return blank_res
  elseif len(link_path) > 1
    " if you change directory, but ditn't clean cmake cache, you will get multiple
    " link result from above command.
    echoe 'multiple link.txt found for target '
          \ . a:target . ' : ' . string(link_path)
  endif
  if v:shell_error != 0
    throw 'failed to execute : ' . cmd
  endif

  let link_path = link_path[0]
  let make_path = link_path[ 0 : -len(link_tail) - 1]

  let cmd = printf('grep -Po ''\s+\-o\s+\K\S+'' ''%s'' ', link_path)
  call ddd#log#debug(cmd)
  let exe_path = trim( system(cmd) )
  if !empty(exe_path)
    let exe_path = simplify(make_path . exe_path)
  endif

  let working_dir = ddd#cpp#get_target(a:target).working_dir
  if empty(working_dir)
    let working_dir = fnamemodify(exe_path, ':h')
  endif

  " it's possible taht grep exit non 0, some library build doesn't use -o
  " if v:shell_error != 0
  "   throw 'failed to execute : ' . cmd
  " endif

  return { 'make_path' : make_path,
        \  'exe_path' : exe_path,
        \  'working_dir': working_dir }
endfunction

" {cmd [,insert]}
function ddd#cpp#sendjob(cmd, ...) abort
  if exists('s:job_term')
    call s:job_term.close()
    unlet s:job_term
  endif
  let cmd = a:cmd
  if !has('nvim') | let cmd = printf('bash -c "%s"', cmd) | endif
  let opts = get(a:000, 0, {})
  call extend(opts, {'cmd':cmd, 'switch':0, 'auto_insert':1}, 'keep')
  let s:job_term = ddd#term#jtermopen(opts)
endfunction

function ddd#cpp#run(args) abort
  call ddd#cpp#exe('cd %b && ./%e', 1, a:args)
endfunction

function ddd#cpp#debug(args) abort
  set nofoldenable
  let [target, exe_args, cmd_args] = ddd#cpp#parse_command(a:args, 0)
  let path = ddd#cpp#get_target_path(target)
  exec 'Termdebug ' . path.exe_path
  if !empty(exe_args)
    call term_sendkeys('', printf("set args %s\<cr>",  exe_args) )
  endif
  call term_sendkeys('', printf("set cwd %s\<cr>",
        \ fnameescape(fnamemodify(path.exe_path, ':h')) ) )
  wincmd p
  wincmd H
  wincmd p
endfunction

" return [target, exe_args, cmd_args]
function ddd#cpp#parse_command(cmd, exe_arg_idx) abort
  if a:cmd ==# ''
    let target = ddd#cpp#get_default_target()
    let exe_args = ''
    let cmd_args = ''
  else
    let [cmd, target, args; rest] = matchlist(a:cmd, '\v\s*(\S*)\s*(.*)$')
    let l = split(args, ' -- ')
    while len(l) < 2
      call add(l, '')
    endwhile

    if a:exe_arg_idx >= 2
      throw 'exe arg index overflow : ' . a:exe_arg_idx
    endif

    let exe_args = l[a:exe_arg_idx]
    let cmd_args = l[xor(a:exe_arg_idx, 1)]

    if l[a:exe_arg_idx] ==# ''
      let exe_args = ddd#cpp#get_target(target).exe_args
    endif
  endif

  if exe_args ==# ''
    let exe_args = ddd#cpp#get_target(target).exe_args
  endif

  let s:last_target = target

  return [target, exe_args, cmd_args]
endfunction

function ddd#cpp#set_last_target(target)
  let s:last_target = a:target
endfunction

function ddd#cpp#get_cmake_cache(name) abort
  let cache_str = system('cd ' . ddd#cpp#get_build_dir() . ' && cmake -LA -N ')
  let rex_value = '\v' . a:name . ':\w+\=\zs.{-}\ze\n'
  return matchstr(cache_str, rex_value)
endfunction

function ddd#cpp#cmake(args)
  let path = findfile('cmake.sh', '.dedowsdi')
  if empty(path)
    call ddd#cpp#sendjob( printf('mycmake %s', a:args))
  else
    call ddd#cpp#sendjob( printf('./%s %s', path, a:args) )
  endif
endfunction

function ddd#cpp#open_project_file() abort
  silent! exec 'edit ' . s:pjcfg
  if s:last_target !=# ''
    call search(printf('\v^\s*"<%s>"\s*:', s:last_target))
  endif
endfunction

" opts : {"jump":bool}
function ddd#cpp#goto_last_include(...) abort
  "keepjumps normal! G
  let opts = get(a:000, 0, {'jump':0})
  let jump_flag = opts.jump ? 's' : ''
  if !search('\v^\s*#include', 'bW'.jump_flag)
    "if not found, goto 1st blank line
    keepjumps normal! gg
    if !search('\v^\s*$')
      call dddu#warn("don't know where last include is") | return 0
    endif
  endif
  normal! zz
  return 1
endfunction

function ddd#cpp#createTempTest()
  if !executable('cpptt')
    echoe 'cpptt not found'
    return
  endif
endfunction

function ddd#cpp#debug_toggle_break()
  if empty(sign_getplaced('', {'lnum':9, 'group':''})[0].signs)
    Break
  else
    Clear
  endif
endfunction

function ddd#cpp#include_osg() abort
  let class_name = matchstr(getline('.'),
        \ printf('\v%%<%dc<osg\w*::\w+>%%>%dc', col('.') + 1, col('.')) )

  if empty(class_name)
    return
  endif

  let head = printf('#include <%s>', substitute(class_name, '::', '/', 'g'))
  if searchpos('\V\C\^\s\*' . head, 'bnW')[0] != 0
    call ddd#log#notice(head . ' already exists, skipped')
    return
  endif

  " try osg block
  let lnum = searchpos('\v\C^\#include\s*\<osg', 'bnW')[0]

  " try other include block
  if lnum == 0
    let lnum = searchpos('\v^\#include\s*["<]', 'bnW')[0]
  endif

  if lnum != 0
    call append(lnum, head)
  else

    " no include, this must be a new file, try the first #define
    try
      let cview = winsaveview()
      keepjump norm! gg
      let lnum = searchpos('\v^\#define\s+\S+', 'Wn')[0]
    finally
      call winrestview( cview )
    endtry
    call append(lnum, head)
    call append(lnum, '')
  endif

  " avoid :h :echo-redraw
  redraw
  call ddd#log#notice(head)
endfunction

function ddd#cpp#debug_step()
  Step
endfunction

function ddd#cpp#debug_next()
  Over
endfunction

function ddd#cpp#debug_continue()
  Continue
endfunction

function ddd#cpp#debug_finish()
  Finish
endfunction

function ddd#cpp#debug_evaluate()
  Evaluate
endfunction

function ddd#cpp#debug_stop()
  Stop
endfunction

function ddd#cpp#_debug_frame_up()
  call TermDebugSendCommand('up')
endfunction

function ddd#cpp#debug_frame_down()
  call TermDebugSendCommand('down')
endfunction