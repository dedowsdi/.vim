function! misc#test#assert(v, ...)
  if !a:v
    if a:0
      echom string(a:000)
    endif
    throw 'misc#test#assert failed.'
  endif
endfunction

function! misc#test#assertEqual(lhs, rhs, ...)

  if type(a:lhs) != type (a:rhs)
    if a:0
      echom join(a:000, ',')
    endif
    echom "you can not compare different type"
    echom string(a:lhs)
    echom string(a:rhs)
    throw "different type"
  endif

  if a:lhs != a:rhs
    if a:0
      echom string(a:000)
    endif
    echom "misc#test#assert failed. lhs not equal to rhs:"
    echom string(a:lhs)
    echom string(a:rhs)
    throw "assertEqual failed"
  endif
endfunction

function! misc#test#assertLine(l, ...)
  let curLine = line('.')
  if curLine != a:l

    if a:0
      echom string(a:000)
    endif

    throw 'misc#test#assert failed. current line:' . curLine
          \ . ' not equal to targte line:' . a:l

  endif
endfunction

function! misc#test#assertCol(c, ...)
  let curCol = col('.')
  if curCol != a:c
    if a:0
      echom string(a:000)
    endif

    throw 'misc#test#assert failed. current col:' . curCol
          \ . ' not equal to targte col:' . a:c

  endif
endfunction
