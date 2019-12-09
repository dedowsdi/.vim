function s:test(content, cmds, expect)

  " prepare buffer
  %del
  call setline(1, a:content)

  " run commands
  for cmd in a:cmds
    exe cmd
  endfor

  " check results
  let result = getline(1, '$')
  if assert_equal( result, a:expect ) ==# 1
    echom 'except : ' . string(a:expect)
    echom 'result : ' . string(result)
  endif
endfunction

try
  mes clear
  let v:errors = []

  " init test buffer
  new
  set buftype=nofile noswapfile

  let test_data = [
        \
        \ [ ["jon jon jon", "jon jon jon"], [1, "norm coipsnow\<esc>"],  ["snow snow snow", "snow snow snow"]] ,
        \ [ ["jon jon jon", "jon jon jon"], [1, "norm wcoipsnow\<esc>"],  ["snow snow snow", "snow snow snow"]] ,
        \ [ ["jon jon jon", "jon jon jon"], [1, "norm 2wcoipsnow\<esc>"],  ["snow snow snow", "snow snow snow"]] ,
        \
        \ [ ["void foo();", "void foo();"], [1, "norm $coip123\<esc>"],  ["void foo()123", "void foo()123"]] ,
        \ [ ["void foo();", "void foo();"], [1, "norm $coip\<cr>{\<cr>}\<esc>"],  ["void foo()", "{", "}", "void foo()", "{", "}"]] ,
        \ [ ["void foo();", "void foo();"], [1, "norm $coip\<cr>{\<cr>}\<cr>\<esc>"],  ["void foo()", "{", "}", "", "void foo()", "{", "}", ""]] ,
        \
        \]

  for [content, cmds, expect] in test_data
    call s:test(content, cmds, expect)
  endfor

  redraw

  if !empty(v:errors)
    echom 'found' len(v:errors) 'errors'
  else
    echom 'test finished, no error found'
  endif
finally

endtry
