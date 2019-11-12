" { winid: [ {hid: , start:  , end:  , wise :  }, ... ] , ...  }
" hid : highlight id return from matchadd
" start : start of cursor pos, same as getcurpos()
" end : ditto
" wise : v, V or "\<c-v>"
let s:hblocks = {}

function misc#ahl#op(type, ...) abort
  let visual = get(a:000, 0, 0)
  let hblock = s:create_block(a:type, visual)
  call s:highlight(hblock)
endfunction

function misc#ahl#remove_cursor_highlights() abort
  let wnd_hblocks = s:get_wnd_hblocks( bufwinid('') )

  " clear highlight
  call map( copy(wnd_hblocks),
        \ { i,v -> s:contain( v, getcurpos() ) && matchdelete(v.hid) } )

  " clear hblocks
  call filter( wnd_hblocks, { i,v -> !s:contain( v, getcurpos() ) } )
endfunction

function misc#ahl#remove_wnd_highlights() abort
  let wnd_hblocks = s:get_wnd_hblocks( bufwinid('') )

  " clear highlight
  call map( copy(wnd_hblocks), { i,v -> matchdelete(v.hid) } )

  " clear hblocks
  call remove(wnd_hblocks, 0, len(wnd_hblocks) - 1)
endfunction

function s:create_block(type, visual) abort
  if a:visual
    let wise = visualmode()
    let start = getpos("'<")
    let end = getpos("'>")
  else
    let wise = a:type ==# 'char' ? 'v' : a:type ==# 'line' ? 'V' : "\<c-v>"
    let start = getpos("'[")
    let end = getpos("']")
  endif

  return {'wise':wise, 'start':start, 'end': end}
endfunction

function s:highlight(hblock) abort
  let pattern = s:build_pattern(a:hblock)

  " lazy man's debug register
  let @/ = pattern
  let a:hblock.hid = matchadd('VISUAL', pattern)
  let wnd_hblocks = s:get_wnd_hblocks( bufwinid('') )
  call insert(wnd_hblocks, a:hblock)
endfunction

function s:get_wnd_hblocks(winid)
  if !has_key(s:hblocks, a:winid)
    let s:hblocks[a:winid] = []
  endif
  return s:hblocks[a:winid]
endfunction

function s:contain(hblock, pos)
  let [l0,c0] = a:hblock.start[1:2]
  let [l1,c1] = a:hblock.end[1:2]
  let [l2,c2] = a:pos[1:2]

  if l2 < l0 || l2 > l1
    return 0
  endif

  if a:hblock.wise ==# 'V'
    return 1
  elseif a:hblock.wise ==# "\<c-v>"
    return c2 >= c0 || c2 <= c1
  else

    " not ( cursor in the upper left corner or cursor in the lower right corner)
    return !( l2 == l0 && c2 < c0 || l2 == l1 && c2 > c1 )
  endif
endfunction

function s:build_pattern(hblock)
  let [l0,c0] = a:hblock.start[1:2]
  let [l1,c1] = a:hblock.end[1:2]

  if a:hblock.wise ==# 'V'
    return printf('\v%%>%dl^.*%%<%dl', l0 - 1, l1 + 1)
  elseif a:hblock.wise ==# "\<c-v>"

    " restrict cols on all lines
    return  printf('\v%%>%dl%%>%dc.*%%<%dl%%<%dc', l0 - 1, c0 - 1, l1 + 1, c1 + 1)
  else
    if l0 != l1

      " mid lines | tail of 1st line | head of last line
      return printf('\v%%>%dl^.*%%<%dl|%%%dl%%>%dc.*|%%%dl%%<%dc.*', l0, l1, l0, c0 - 1, l1, c1 + 1)
    else

      " mid of the only line
      return printf('\v%%%dl%%>%dc.*%%%dl%%<%dc', l0, c0 - 1, l1, c1 + 1)
    endif
  endif
endfunction
