" Set up map, slide step, slide save.
function ddd#slide#prepare(save, step) abort

  if a:step == 1 && !a:save
    silent! nunmap <c-a>
    silent! nunmap <c-x>
    return
  endif

  nnoremap <c-a> :<c-u>call <sid>slide(1, v:count1)<cr>
  nnoremap <c-x> :<c-u>call <sid>slide(0, v:count1)<cr>
  let s:slide_step = str2float(a:step)
  let s:slide_save = a:save

endfunction

let s:slide_step = 0.1
let s:slide_save = 0

function s:slide(positive, steps) abort

  " split current line into 3 parts by first number whose ends column is no less
  " then current column
  "
  "                               match 1, 1., 1.1,   or .1, with
  "                               optional leading -, the ending must
  "                               occur after cursor column
  "             leading part------++++++++++++++++++++++++++++++++++++---- tail part
  let pattern = printf( '\v^(.{-})(%%(-?\d+\.?%%(\d+)?|-?\.\d+)%%>%dc)(.*$)', col('.') )
  let matches = matchlist( getline('.'),  pattern )
  if empty(matches)
    return
  endif
  let [part0, part1, part2] = matches[1:3]

  " update number, join line
  let number = str2float(part1)
  let number += s:slide_step * a:steps * (a:positive ? 1 : -1)

  " convert float to string, remove trailing 0
  let new_part1 = substitute(printf('%f', number), '\v\..{-}\zs0+$', '', 'g')
  call setline('.', part0 . new_part1 . part2)

  " place cursor at number end
  call cursor( line('.'), len(part0) + len(new_part1) )

  if s:slide_save
    noautocmd w
  endif
endfunction
