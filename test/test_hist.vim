function! s:build_alias(name)
  echom 'build alias : s:' . a:name
  return function(printf('<SNR>%d_%s', s:sid, a:name))
endfunction

function! s:test_split_cmdline()
  echom 'test split cmdline'
  let data = [
        \ [ 'echo "hello"', '5', ['', 'echo', ' "hello"'] ],
        \
        \ [ '^abc^def^', '10', ['^', '',  'abc', 'def', ''] ],
        \ 
        \ [ '!!', '3' , ['!' , '', '!!', ''] ],
        \ 
        \ [ 'echo !! abc', '8', ['!', 'echo ', '!!', ' abc'] ] ,
        \ ]

  let index = 0
  for [cmdline, cmdpos, expect] in data
    let result = s:split_cmdline(cmdline, cmdpos)
    if assert_equal(expect, result, '') == 1
       echom '--------'
       echom 'split_cmdline failed at' index
       echom 'cmdline : ' cmdline
       echom 'cmdpos : ' cmdpos
       echom 'expected : ' expect
       echom 'result   : ' result
    endif
    let index += 1
  endfor
endfunction

function! s:test_split_designator()
  echom 'test split designator'
  let data = [
        \ [ '!!', ['!!', '', ''] ],
        \
        \ [ '!10', ['!10', '', ''] ],
        \
        \ [ '!-1', ['!-1', '', ''] ],
        \
        \ [ '!abc', ['!abc', '', ''] ],
        \
        \ [ '!?abc', ['!?abc', '', ''] ],
        \
        \ [ '!:0', ['!!', '0', ''] ],
        \
        \ [ '!^', ['!!', '^', ''] ],
        \
        \ [ '!$', ['!!', '$', ''] ],
        \
        \ [ '!%', ['!!', '%', ''] ],
        \
        \ [ '!:1-5', ['!!', '1-5', ''] ],
        \
        \ [ '!*', ['!!', '*', ''] ],
        \
        \ [ '!-', ['!!', '-', ''] ],
        \
        \
        \ ]

  let index = 0
  for [designator, expect] in data
    let result = s:split_designator(designator)
    if assert_equal(expect, result, '') == 1
       echom '--------'
       echom 'split_designator failed at' index
       echom 'designator : ' designator
       echom 'expected : ' expect
       echom 'result   : ' result
    endif
    let index += 1
  endfor

endfunction

function! s:test_expand_event() abort
  echom 'test expand event'
  let cmd = 'test_hist 1 2 3 4 5 6 7 8 9'
  call histadd(':', cmd)
  let num_cmds = histnr(':')

  let data = [
        \ [ '!' . num_cmds, ':', cmd ],
        \
        \ [ '!-1', ':', cmd ],
        \
        \ [ '!!', ':', cmd ],
        \
        \ [ '!test', ':', cmd ],
        \
        \ [ '!?hist', ':', cmd ],
        \
        \ ]

  let index = 0
  for [event, cmdtype, expect] in data
    let result = s:expand_event(event, cmdtype)
    if assert_equal(expect, result, '') == 1
       echom '--------'
       echom 'expand_event failed at' index
       echom 'event : ' event
       echom 'cmdtype : ' cmdtype
       echom 'expected : ' expect
       echom 'result   : ' result
    endif
    let index += 1
  endfor
endfunction

function! s:test_expand_word() abort
  echom 'test expand word'
  let cmd = 'test_hist 1 2 3 4 5 6 7 8 9'

  let data = [
        \ [ '0', 'test_hist' ],
        \
        \ [ '5', '5' ],
        \
        \ [ '^', '1' ],
        \
        \ [ '$', '9' ],
        \
        \ [ '1-9', '1 2 3 4 5 6 7 8 9' ],
        \
        \ [ '*', '1 2 3 4 5 6 7 8 9' ],
        \
        \ [ '5*', '5 6 7 8 9' ],
        \
        \ [ '5-', '5 6 7 8' ],
        \
        \ ]

  let index = 0
  for [word, expect] in data
    let result = s:expand_word(word, cmd, ':')
    if assert_equal(expect, result, '') == 1
       echom '--------'
       echom 'expand_word failed at' index
       echom 'word : ' word
       echom 'cmd : ' cmd
       echom 'expected : ' expect
       echom 'result   : ' result
    endif
    let index += 1
  endfor
endfunction

function! s:test_expand() abort
  echom 'test expand'
  let cmd = 'test_hist 1 2 3 4 5 6 7 8 9'
  call histadd(':', cmd)

  let data = [
        \ [ '!!:0', 'test_hist' ],
        \
        \ [ '!!:5', '5' ],
        \
        \ [ '!^', '1' ],
        \
        \ [ '!$', '9' ],
        \
        \ [ '!:1-9', '1 2 3 4 5 6 7 8 9' ],
        \
        \ [ '!*', '1 2 3 4 5 6 7 8 9' ],
        \
        \ [ '!:5*', '5 6 7 8 9' ],
        \
        \ [ '!:5-', '5 6 7 8' ],
        \
        \ ]

  let index = 0
  for [designator, expect] in data
    let result = s:expand(designator, ':')
    if assert_equal(expect, result, '') == 1
       echom '--------'
       echom 'expand failed at' index
       echom 'designator : ' designator
       echom 'cmd : ' cmd
       echom 'expected : ' expect
       echom 'result   : ' result
    endif
    let index += 1
  endfor
endfunction

" ------------------------------------------------------------
try
  mes clear
  let v:errors = []
  let s:cur_file = expand('%')

  " create function alias
  let s:script = fnamemodify(expand('<sfile>'), ':h:h') . '/autoload/misc/hist.vim'
  let s:sid = misc#viml#get_sid(s:script)
  echom 'get sid of hist.vim : ' . s:sid
  let s:split_cmdline = s:build_alias('split_cmdline')
  let s:split_designator = s:build_alias('split_designator')
  let s:expand_event = s:build_alias('expand_event')
  let s:expand_word = s:build_alias('expand_word')
  let s:expand = s:build_alias('expand')

  echom repeat('*', 60)
  call s:test_split_cmdline()
  call s:test_split_designator()
  call s:test_expand_event()
  call s:test_expand_word()
  call s:test_expand()

  echom repeat('*', 60)
  if !empty(v:errors)
    echom 'found' len(v:errors) 'errors'
  else
    echom 'test finished, no error found'
  endif
finally

endtry
