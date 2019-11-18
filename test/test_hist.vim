function! s:build_script_function_alis(name)
  echom 'build alias : s:' . a:name
  return function(printf('<SNR>%d_%s', s:sid, a:name))
endfunction

function! s:test_parse_cmdline()
  echom 'test parse cmdline'
  "              0.text,         1.pos, 2.type, 3.pre,   4.cur,       5.post,     6.etype, 7.event/s0, 8.word/s1, 9.modifier
  let data = [ [ 'echo "hello"', 5,     ':',    '',      'echo',      ' "hello"', '',      '',         '',        ''        ],
             \
             \ [  '^abc^def^',   10,    ':',    '',      '^abc^def^', '',         '^',     'abc',      'def',     ''        ],
             \
             \ [  'echo !! 123', 8,     ':',    'echo ', '!!',        ' 123',     '!',     '!!',       '',        ''        ],
             \ ]

  let index = 0
  for item in data
    let cs = {}
    let cs.text           = item[0]
    let cs.pos            = item[1]
    let cs.type           = item[2]
    let cs.pre            = item[3]
    let cs.cur            = item[4]
    let cs.post           = item[5]
    let cs.expansion_type = item[6]

    if cs.expansion_type  ==# '!'
      let cs.event = item[7]
      let cs.word  = item[8]
      let cs.modifier = item[9]
    elseif cs.expansion_type ==# '^'
      let cs.string1 = item[7]
      let cs.string2 = item[8]
      let cs.modifier = item[9]
    endif

    let result = s:parse_cmdline(cs.text, cs.type, cs.pos)
    if assert_equal(cs, result, '') == 1
       echom '--------'
       echom 'parse_cmdline failed at' index
       echom 'expected : ' string(cs)
       echom 'result   : ' string(result)
    endif
    let index += 1
  endfor
endfunction

function! s:test_split_designator()
  echom 'test split designator'
  let data = [
        "\ event only
        \
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
        "\ event:word
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
        \ [ '!:-5', ['!!', '-5', ''] ],
        \
        \ [ '!*', ['!!', '*', ''] ],
        \
        \ [ '!-', ['!!', '-', ''] ],
        \
        "\ event:modifier
        \
        \ [ '!!:h:h', ['!!', '', 'h:h'] ],
        \
        \ [ '!abc:*:h:h', ['!abc', '*', 'h:h'] ],
        \
        "\ event:word:modifier
        \
        \ [ '!$:h', ['!!', '$', 'h'] ],
        \
        \ ]

  let index = 0
  for item in data
    let [designator, expect] = item
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

function! s:test_expand_history() abort
  echom 'test expand'
  let cmd1 = 'test_hist 1 2 3 4 5 6 7 8 9'
  let cmd2 = 'echo /a/bb/bb/c/c/d.ext'
  call histadd(':', cmd2)
  call histadd(':', cmd1)
  let num_cmds = histnr(':')

  let data = [
        \
       "\ event only
        \
        \ [ '!' . num_cmds, -1, cmd1 ],
        \
        \ [ '!-1',          -1, cmd1 ],
        \
        \ [ '!-2',          -1, cmd2 ],
        \
        \ [ '!!',           -1, cmd1 ],
        \
        \ [ '!test',        -1, cmd1 ],
        \
        \ [ '!?hist',       -1, cmd1 ],
        \
       "\ event:word
        \
        \ [ '!!:0',         -1, 'test_hist' ],
        \
        \ [ '!!:5',         -1, '5' ],
        \
        \ [ '!^',           -1, '1' ],
        \
        \ [ '!$',           -1, '9' ],
        \
        \ [ '!-1$',         -1, '9' ],
        \
        \ [ '!:1-9',        -1, '1 2 3 4 5 6 7 8 9' ],
        \
        \ [ '!*',           -1, '1 2 3 4 5 6 7 8 9' ],
        \
        \ [ '!:5*',         -1, '5 6 7 8 9' ],
        \
        \ [ '!:5-',         -1, '5 6 7 8' ],
        \
       "\ event:modifier
        \
        \ [ '!-2:h',       -1, fnamemodify(cmd2, ':h')],
        \
        \ [ '!-2:t',       -1, fnamemodify(cmd2, ':t')],
        \
        \ [ '!-2:r',       -1, fnamemodify(cmd2, ':r')],
        \
        \ [ '!-2:e',       -1, fnamemodify(cmd2, ':e')],
        \
        \ [ '!-2:h:t',     -1, fnamemodify(cmd2, ':h:t')],
        \
        \ [ '!?abc?:%',     -1, 'abc'],
        \
       "\ event:word:modifier
        \
        \ [ '!-2:s/a/x/',  -1, substitute(cmd2, 'a', 'x', '')],
        \
        \ [ '!-2:gs/b/x/',  -1, substitute(cmd2, 'b', 'x', 'g')],
        \
        \ [ '!-2:s/b/x/:g&',  -1, substitute(cmd2, 'b', 'x', 'g')],
        \
        \ [ '!!:G:s/\d/x/', -1, substitute(cmd1, '\d', 'x', 'g')],
        \
        \ ]

  let index = 0
  for item  in data
    let [text, pos, expect] = item
    if pos == -1
      let pos = len(text) + 1
    endif
    let result = s:expand_history(s:parse_cmdline(text, ':', pos))
    if assert_equal(expect, result, '') == 1
       echom '--------'
       echom 'expand failed at' index
       echom 'pattern : ' text
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

  " create function alias
  let s:script = fnamemodify(expand('<sfile>'), ':h:h') . '/autoload/misc/hist.vim'
  let s:sid = misc#viml#get_sid(s:script)
  echom 'get sid of hist.vim : ' . s:sid
  let s:parse_cmdline = s:build_script_function_alis('parse_cmdline')
  let s:split_designator = s:build_script_function_alis('split_designator')
  let s:expand_history = s:build_script_function_alis('expand_history')

  echom repeat('*', 60)
  call s:test_split_designator()
  call s:test_parse_cmdline()
  call s:test_expand_history()

  echom repeat('*', 60)
  if !empty(v:errors)
    echom 'found' len(v:errors) 'errors'
  else
    echom 'test finished, no error found'
  endif
finally

endtry
