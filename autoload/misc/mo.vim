
" vertical E,W,B,S(space). it's too much trouble to implement e,w,b.
function! misc#mo#vertical_motion(motion)

  " changed from https://vi.stackexchange.com/questions/15151/move-to-the-first-last-non-whitespace-character-of-the-column-vertical-w-b-e
  let curcol = virtcol('.')
  let nextcol = curcol + 1

  if a:motion ==# 'E'

    " %dv : restrict virtual column
    " \S.* : start from non-blank character
    " (\n.*%%<%dv$|\n.*%%%dv\s|%%$)
    "   \n.*%%<%dv$ : next line that's too short
    "   \n.*%%%dv\s : next line that's empty (only work for space or leading space in tab) in this column
    "   \n.*%%<%dv\t%%>%dv : next line that's empty, tab style.
    "   %%$         : end of file
    let pattern = printf('\v%%%dv\S.*(\n.*%%<%dv$|\n.*%%%dv\s|\n.*%%<%dv\t%%>%dv|%%$)',
          \ curcol, nextcol, curcol, curcol, curcol)
    let flag = 'W'
  elseif a:motion ==# 'B'
    " \v^.*...\n.*\zs : previous line that's too short or has empty or tab in this column
    " %%1l%%%dv : line 1 that has character in this column
    let pattern = printf('\v^.*(%%<%dv$|%%%dv\s.*|%%<%dv\t%%>%dv.*)\n.*\zs%%%dv\S|%%1l%%%dv',
          \ nextcol, curcol, curcol, curcol, curcol, curcol)
    let flag = 'bW'
  elseif a:motion ==# 'W'
    " \v^.*...\n.*\zs : previous line that's too short or has empty or tab in this column
    " |%%%dv\S.*(\_s)*%%$ : last line in the file which has non blank character in this column
    let pattern = printf('\v^.*(%%<%dv$|%%%dv\s.*|%%<%dv\t%%>%dv.*)\n.*\zs%%%dv\S|%%%dv\S.*(\_s)*%%$',
          \ nextcol, curcol, curcol, curcol, curcol, curcol)
    let flag = 'W'
  elseif a:motion ==# 'S'
    " next line that's not space in this column
    let pattern = printf('\v%%%dv\s.*(\n.*%%<%dv$|\n.*%%%dv\S|\n.*%%<%dv\t%%>%dv|%%$)',
          \ curcol, nextcol, curcol, curcol, curcol)
    let flag = 'W'
  else
    echohl ErrorMsg | echo 'Not a valid motion: ' . a:motion | echohl None
  endif
  call search(pattern, flag)
endfunction
