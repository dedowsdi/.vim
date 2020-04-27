" Put simple util in this file.

function dddu#warn(mes) abort
  echohl WarningMsg | echom a:mes | echohl None
endfunction

function dddu#get_c(lnum, cnum) abort
  return matchstr(getline(a:lnum), '\%' . a:cnum . 'c.')
endfunction

function dddu#get_cc() abort
  return dddu#get_c(line('.'), col('.'))
endfunction

function dddu#get_v(lnum, vnum) abort
  return matchstr(getline(a:lnum), '\%' . a:vnum . 'v.')
endfunction
function dddu#get_vv() abort
  return dddu#get_v(line('.'), col('.'))
endfunction

function dddu#char_right(...) abort
  try
    let oval = &whichwrap
    set whichwrap&
    exec printf("norm! %d\<space>", get(a:000, 0, 1))
  finally
    let &whichwrap = oval
  endtry
endfunction

function dddu#char_left(...) abort
  try
    let oval = &whichwrap
    set whichwrap&
    exec printf("norm! %d\<bs>", get(a:000, 0, 1))
  finally
    let &whichwrap = oval
  endtry
endfunction

"add lnum, cnum to jump list
function dddu#create_jumps(lnum,cnum) abort
  let [start_line, start_col]= [line('.'), col('.')] | try
    let cview = winsaveview()

    call cursor(a:lnum, a:cnum)
    normal! m'

  finally
    call winrestview(cview)
  endtry
endfunction

" copy last visual without side effect. Won't work for <c-v>$
function dddu#get_visual_string() abort
  return dddu#get_mark_string("'<", "'>", visualmode())
endfunction

function dddu#get_mark_string(m0, m1, vmode)
  return dddu#get_pos_string(getpos(a:m0), getpos(a:m1), a:vmode)
endfunction

function dddu#get_pos_string(p0, p1, vmode)
  let [lnum1, col1] = a:p0[1:2]
  let [lnum2, col2] = a:p1[1:2]

  let lines = getline(lnum1, lnum2)
  if a:vmode =~# "\<c-v>"
    let lines = map(lines, 'v:val[col1-1 : col2-1]')
  elseif a:vmode ==# 'V'
    let lines[-1] .= "\n"
  else
    let lines[-1] = lines[-1][:col2 - 1]
    let lines[0] = lines[0][col1 - 1:]
  endif
  return join(lines, "\n")
endfunction

function dddu#literalize_vim(str)
    return '\V' . substitute(escape(a:str, '\'), '\n', '\\n', 'g')
endfunction

" get change from `[ to `](exclusive), note that if backspace past `[, you won't
" get that part of change.
function dddu#get_last_change() abort
  " try
  "   let [reg_type, reg_content, old_ve] = [@@, getregtype('"'), &virtualedit]
  "   " mark motion is exclusive, but it can't past end of line if 've' is empty
  "   set ve=onemore
  "   let end_with_blank_line = getpos("']")[2] == 1
  "   norm! `[y`]
  "   let change = @@
  "   return end_with_blank_line ? change . "\<cr>" : change
  " finally
  "   call setreg('"', reg_content, reg_type)
  "   let &ve = old_ve
  " endtry

  let pos0 = getpos("'[")
  let pos1 = getpos("']")
  if pos0 == pos1
    return ''
  endif

  let change = dddu#get_pos_string(pos0, pos1, 'v')

  " mark motion is exclusive, '] might past end of line for 1 byte.
  if pos1[2] <= len( getline(pos1[1]) )
    let change = change[0:-2]
  endif

  return change
endfunction
