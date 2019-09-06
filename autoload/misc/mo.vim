
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
endfunction

" TODO add setting for different filetype?
function! s:search_expression() abort
  if col('.')+1 == col('$')
    return
  endif

  let tail = getline('.')[col('.'):]
  let [next_c, next_2c] = [tail[0], tail[0:1]]

  " only alow space before <{({
  if tail =~# '\v^\s*[([{<]'
    norm! l%
    call s:search_expression()

  " this branch match 'abc()balabala', but that's illegal in most program
  " language, so it shouldn't matter
  elseif next_c =~# '\v\w'
    norm! l
    call search('\v%#\w*', 'e')
    call s:search_expression()
  elseif next_c ==# '.'
    norm! 2l
    call search('\v%#\*?\w*', 'ce')
    call s:search_expression()
  elseif next_2c =~# '->'
    norm! 3l
    call search('\v%#\*?\w*', 'ce')
    call s:search_expression()
  elseif next_2c =~# '::'
    norm! 3l
    call search('\v%#\*?\w*', 'ce')
    call s:search_expression()
  else
    return
  endif
endfunction

function! misc#mo#expr() abort
  if misc#get_cc() !~? '[a-z]'
    return
  endif

  call s:search_expression()
endfunction
