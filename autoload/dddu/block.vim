function dddu#block#select(block, mode) abort
  " note that '< and '> are not changed until this visual mode finishes
  call setpos('.', a:block[0]) | exec 'normal! ' . a:mode | call setpos('.', a:block[1])
endfunction

function dddu#block#swap(block0, block1, mode) abort
  if dddu#pos#cmp(a:block0[0], a:block1[0]) < 0
     let [left_block, right_block] = [a:block0, a:block1]
  else
     let [left_block, right_block] = [a:block1, a:block0]
  endif

  " replace right rangre 1st, otherwise left block will be corrupted
  let tmp = dddu#block#get(right_block, a:mode)
  call dddu#block#replace_block(right_block, dddu#block#get_block(left_block, a:mode), a:mode)
  call dddu#block#replace_block(left_block, tmp, a:mode)
endfunction

function dddu#block#get(block, mode) abort
  return dddu#block#get_pos_string(a:block[0], a:block[1], a:mode)
endfunction

function dddu#block#replace(block, content, mode) abort
  let [cview, paste, reg_text, reg_type]= [winsaveview(), &paste, @a, getregtype('a')]
  try
    let [&paste, @a]= [1, a:content]
    call dddu#block#select(a:block, a:mode)
    silent normal! "ap
  finally
    call winrestview(cview) | let &paste = paste | call setreg('a', reg_text, reg_type)
  endtry
endfunction

"return new trimed characterwise block
function dddu#block#trim(block) abort
  try
    let cview = winsaveview()
    let new_block = deepcopy(a:block)

    call setpos('.', a:block[0])
    call search('\v\S', 'cW')
    let new_block[0] = getpos('.')

    call setpos('.', a:block[1])
    call search('\v\S', 'bcW')
    let new_block[1] = getpos('.')

    return new_block
  finally
    call winrestview(cview)
  endtry
endfunction
