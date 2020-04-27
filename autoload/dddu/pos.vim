" pos can be [l,c] or getpos() format
function dddu#pos#cmp(p0, p1) abort
  if len(a:p0) != len(a:p1)
    throw 'can not compare different type position'
  endif

  if len(a:p0) == 2
    let [l0, c0, l1, c1] = a:p0 + a:p1
  elseif len(a:p0) == 4 || len(a:p0) == 5
    let [l0, c0, l1, c1] = a:p0[1:2] + a:p1[1:2]
  else
    throw 'unknow position data'
  endif

  if l0 < l1
    return -1
  elseif l0 > l1
    return 1
  elseif c0 < c1
    return -1
  elseif c0 > c1
    return 1
  endif

  return 0
endfunction

function dddu#pos#translate(pos, step) abort
  let [start_line, start_col]= [line('.'), col('.')] | try
    call cursor(a:pos)
    if(a:step < 0)
      call dddu#char_left(-a:step)
    else
      call dddu#char_right(a:step)
    endif
    return getpos('.')[1:2]
  finally | call cursor(start_line, start_col) | endtry
endfunction
