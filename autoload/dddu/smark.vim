function s:default_string_mark()
  return repeat("\x80", 8)
endfunction

" add string mark at cursor
function dddu#smark#insert(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let l = getline('.')
  let c = col('.')
  call setline('.', strpart(l, 0, c - 1) . smark . strpart(l, c - 1) )
endfunction

" append string mark after cursor
function dddu#smark#append(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let l = getline('.')
  let c = col('.')
  call setline('.', strpart(l, 0, c) . smark . strpart(l, c) )
endfunction

function dddu#smark#search(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let flags = get(a:000, 1, '')
  if !search(smark, flags)
    throw 'string mark not found'
  endif
endfunction

" always assume cursor on 1st character of string mark
function dddu#smark#remove(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let l = getline('.')
  let c = col('.')
  call setline('.', strpart(l, 0, c - 1) . strpart(l, c - 1 + len(smark)) )
endfunction
