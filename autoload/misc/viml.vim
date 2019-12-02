" viml stuff
"
" [lnum]
function misc#viml#goto_function(...) abort
  let lnum = get(a:000, 0, 0)
  let range = misc#viml#get_function_range()
  if range == [] | return 0 | endif
  call setpos('.', range[0])
  if lnum == 0 | return 1 | endif
  execute 'normal! '. lnum .'j' | return 1
endfunction

function misc#viml#get_function_range() abort
  let cpos = getcurpos()
  exec 'norm! v' | call misc#viml#sel_function('i') | exec "norm! \<esc>"
  call setpos('.', cpos)
  let [pos0, pos1] = [getpos("'<"), getpos("'>")]
  return pos0 == pos1 ? [] : [pos0, pos1]
endfunction

function misc#viml#sel_function(ai)
  call misc#to#sel_lines('\v^\s*fu%[nction]?\!?\s+\S+\(',
        \ '\v^\s*endf%[unction]?\s*$', a:ai, 1)
endfunction

" support both relative and absolute filename
function misc#viml#get_sid(file_name) abort
  redir => str | silent execute 'scriptnames' | redir END
  let [abs_name, base_name] = [fnamemodify(a:file_name, ':p'), fnamemodify(a:file_name, ':t')]
  " item format in scriptnames: 18: script name
  let script_list = filter(split(str, "\n"), {i,v -> v =~# base_name})
  let script_list = filter(script_list,
        \ {i,v -> fnamemodify(matchstr(v, '\v\s*\d+:\s*\zs.+'), ':p') ==# abs_name})
  if empty(script_list)
    throw a:file_name . ' not loaded'
  elseif len(script_list) > 1
    throw a:file_name . ' loaded more than once?'
  endif
  return matchstr(script_list[0], '\v\s*\zs\d+') + 0
endfunction

" break at current line in current function, doesn't work if it's a dict
" [func_name [,line, [,plugFileName]]]
function misc#viml#break_here() abort
  let cpos = getcurpos() | try
    if misc#viml#goto_function()

      let [scope, func_name] = matchlist(getline('.'), '\v(\w:)?(\k+)\ze\s*\(.*\)')[1:2]
      let break_line = cpos[1] - line('.')
      if scope ==# 's:'
        "add <SNR>SID_ prefix
        let func_name = '<SNR>'.misc#viml#get_sid(@%).'_'.func_name
      endif
    else
      echom 'breakadd here' | breakadd here | return
    endif

    let cmd = 'breakadd func ' . break_line . ' ' . func_name | echom cmd
    execute cmd
  finally | call setpos('.', cpos) | endtry
endfunction

function misc#viml#break_numbered_function() abort
  let range = misc#viml#get_function_range()
  if range != []
    let candidates = misc#viml#search_numbered_functions(
          \ join(getline(range[0][1], range[1][1]), "\n"), 1000)
    let n = len(candidates)
    if n == 0 | echom 'no candidates found' | return | endif
    if n >= 1

      let break_line = line('.') - range[0][1]
      for fnum in keys(candidates)
        let cmd = 'breakadd func ' . break_line . ' ' . fnum | echom cmd
        execute cmd
      endfor
      return
    endif

  else
    echoe 'function not found' | return
  endif
endfunction

" return {fnum : def}
function misc#viml#search_numbered_functions(func_def, max_number)
  let lines0 = map(split(a:func_def, "\n"), 'trim(v:val)')
  let prototype = matchstr(lines0[0], '\v(\(.*\))')
  let candidates = {}
  for i in range(a:max_number)
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

function misc#viml#is_comment(line_string) abort
  return matchstr(a:line_string, '\v^\s*\zs\S') ==# '"'
endfunction

function misc#viml#is_scope_script() abort
  return stridx(getline('.'), 's:') >= 0
endfunction


function misc#viml#join() abort
  exec "normal! A |\<esc>gJ"
  if misc#get_c_c() =~# '\v\s'
    exec 'normal! cw '
  else
    exec 'normal! i '
  endif
endfunction

" [+-][size]
function misc#viml#list(sfile, slnum, ...) abort

  " you can't get argument when you change stack frame?
  if !has_key(a:, 'sfile')
    echom 'List skipped, only allowed in stack top'
    return
  endif

  let symbol = a:0 > 0 ? matchstr(a:1, '\v^[+\-]') : ''
  let size = a:0 > 0 ? matchstr(a:1, '\v\d+') : 10
  if empty(size) | let size = 10 | endif

  let fname = a:sfile
  let lnum = a:slnum

  if a:sfile =~# '\v^function.*'

    " note that function head and end is also returned from :function. slnum
    " starts from 1 after function head
    let lidx = a:slnum
    let func_name = split(a:sfile[9:], '\v\.\.')[-1]

    " take care of numbered function
    if func_name =~# '\v^\d+$'
      let func_name = printf('{%d}', func_name)
    endif

    " get script file of this function
    let def = split(execute('verbose function ' . func_name), "\n")[1]
    let [fname, func_lnum] = matchlist(def, '\v\s*Last set from\s*(.*) line (\d+)')[1:2]
    let lnum += func_lnum
  endif

  let lidx = lnum - 1
  let lines = readfile(expand(fname))
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
if exists('*misc#viml#reload_loaded_script')
  finish
endif

function misc#viml#reload_loaded_script() abort
  try
    let oldpos = getcurpos()
    let re_script_guard = '\v^\s*let\s+\zs[gb]:loaded\w+\ze'
    keepjumps normal! gg
    if search(re_script_guard, 'W')
      let script_guard = matchstr(getline('.'), re_script_guard)
      if exists(script_guard) | execute 'unlet ' . script_guard | endif
      source %
    else
      throw 'script guard not found' | return
    endif
  finally
    call setpos('.', oldpos)
  endtry
endfunction
