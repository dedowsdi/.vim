function s:test_get_range_text()
  echom 'test_get_range_text'
  let data = [
        \ ['', ''],
        \
        \ ['++---++--,----++++', '++---++--,----++++'],
        \
        \ ['1', '1'],
        \ [' 1 ', ' 1 '],
        \ [' 1 p', ' 1 '],
        \
        \ ['.', '.'],
        \
        \ ['.+1+++---', '.+1+++---'],
        \
        \ ["'a,'bp", "'a,'b"],
        \
        \ ['/abc/', '/abc/'],
        \ ['/abc/,/def/p', '/abc/,/def/'],
        \
        \ ['\/', '\/'],
        \
        \ ['\?', '\?'],
        \
        \ ['\&', '\&'],
        \ ]

  let index = 0
  for [cmdline, range_text] in data
    let result = misc#cmdline#get_range_text(cmdline)
    if assert_equal(range_text, result) == 1
      echom '--------'
      echom 'test_get_range_text failed at index ' . index
      echom 'cmdline : "' . cmdline . '"'
      echom 'expected : "' . range_text . '"'
      echom 'result : "' . result . '"'
    endif
    let index += 1
  endfor

endfunction

try
  mes clear
  let v:errors = []

  echom repeat('*', 60)
  call s:test_get_range_text()

  echom repeat('*', 60)
  if !empty(v:errors)
    echom 'found' len(v:errors) 'errors'
  else
    echom 'test finished, no error found'
  endif
finally

endtry
