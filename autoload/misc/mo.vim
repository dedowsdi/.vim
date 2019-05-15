
" vertical E,W,B. it's too much trouble to implement e, w, b.
function! misc#mo#vertical_motion(motion)
  " changed from https://vi.stackexchange.com/questions/15151/move-to-the-first-last-non-whitespace-character-of-the-column-vertical-w-b-e
  let curcol = virtcol('.')
  let nextcol = curcol + 1

  if a:motion ==# 'E'
    let pattern = printf('\v%%%dv\S.*(\n.*%%<%dv$|\n.*%%%dv\s|%%$)', curcol, nextcol, curcol)
    let flag = 'W'
  elseif a:motion == 'B'
    let pattern = printf('\v^.*(%%<%dv$|%%%dv\s.*)\n.*\zs%%%dv\S', nextcol, curcol, curcol)
    let flag = 'bW'
  elseif a:motion == 'W'
    let pattern = printf('\v^.*(%%<%dv$|%%%dv\s.*)\n.*\zs%%%dv\S', nextcol, curcol, curcol)
    let flag = 'W'
  else
    echohl ErrorMsg | echo 'Not a valid motion: ' . a:motion | echohl None
  endif
  call search(pattern, flag)
endfunction
