let s:data = []

function! misc#dc#start_copy(reset)
  if a:reset | let s:data = [] | endif
  augroup DATA_COPY_PASTE
    au!
    autocmd TextYankPost * call s:copy()
  augroup END
  echohl Title | echo 'start recording yank delete' | echohl None
endfunction

function! misc#dc#stop_copy()
  augroup DATA_COPY_PASTE
    au!
    autocmd TextYankPost * call s:copy()
  augroup END
  echohl Title | echo 'stop recording' | echohl None
endfunction

function! misc#dc#paste()
  call misc#dc#stop_copy()
  call s:paste()
endfunction

function! misc#dc#get_texts()
  return map(deepcopy(s:data), {i,v -> v.text})
endfunction

function! s:copy()
  let entry = {'text':@", 'mode':getregtype('"')}
  " if s:data[-1] != entry
  call add(s:data, entry)
endfunction

function! s:paste()
  if s:data == [] | return | endif

  let prompt = ''
  let i = 0

  " print only 1st line of multi line entry
  for entry in s:data
    let i += 1
    let idx = stridx(entry.text, "\n")
    let prompt .= printf("%d : %s : %s\n", i,
          \ substitute(entry.mode, '', '^V', ''),
          \ idx != -1 ? entry.text[0:stridx(entry.text, "\n")-1] . '...' : entry.text)
  endfor
  let prompt .= "\n[numbers][*][ex command] : "
  echohl ModeMsg | let input_str = input(prompt, 'norm! ') | echohl None
  if input_str ==# '' | return | endif

  let matches = matchlist(input_str, '\v^([0-9\-,]*)(\*)?\s*(.*)')
  let [range, do_tail, cmd] = [matches[1], matches[2], matches[3]]

  call s:print(s:get_selection(range), cmd, !empty(do_tail))
endfunction

" * or blank : all
" a-b        : range(a, b)
" a,b        : a and b
" a-         : a until last
" -b         : 1 until b
" currently not used
function! s:get_selection(str)
  if empty(a:str)
    return range(len(s:data))
  endif

  let indices = []
  for item in split(a:str, ',')
    if item =~# '-'
      let [i0, i1] = split(item, '\v\s*\-\s*', 1)
      if i0 ==# '' | let i0 = 1 | endif
      if i1 ==# '' | let i1 = len(s:data) | endif
      let indices += range(i0-1, i1-1)
    else
      let indices += [item - 1]
    endif
  endfor
  call filter(indices, 'v:val < len(s:data)') | return indices
endfunction

function! s:print(indices, cmd, do_tail)
  let [reg_text, reg_type, i] = [@", getregtype('"'), 0]
  for index in a:indices
    let [entry, cpos, i] = [s:data[index], getcurpos(), i+1]

    " gp place cursor after the new text if it's not the end of line or file,
    " otherwise it place cursor at end of new text, it's inconsistent, so i
    " choose p instead
    call setreg('"', entry.text, entry.mode) | norm! ""p
    if entry.mode =~# 'V'

      " place cursor at 1st non space character of pasted lines
      let num_lines = count(@", "\n")
      if num_lines >1 | exec '+'.(num_lines-1) | endif
    elseif entry.mode =~# ''

      " place cursor at right up corner of pasted block
      call cursor(line('.'), col('.') + 1 - str2nr(matchstr(entry.mode, '\v\d+')))
    endif
    if empty(a:cmd) || (!a:do_tail && i == len(a:indices)) | continue | endif
    exec a:cmd
  endfor
  call setreg('"', reg_text, reg_type)
endfunction

finish

" ------------------------------------------------------------------------------
" test
" ------------------------------------------------------------------------------

let v:errors = []
let s:data = [{'mode':'v', 'text':'a'}, {'mode':'v', 'text':'b'}, {'mode':'v', 'text':'c'}]
call assert_equal([0,  1,  2], s:get_selection(''))
call assert_equal([0,  1,  2], s:get_selection('1-'))
call assert_equal([0,  1,  2], s:get_selection('1-3'))
call assert_equal([0,  1,  2], s:get_selection('1,2,3'))
call assert_equal([0,  1,  2], s:get_selection('1-1,2-3'))
call assert_equal([0,  1,  2], s:get_selection('-3'))
call assert_equal([0],         s:get_selection('1'))
call assert_equal([2],         s:get_selection('3'))
call assert_equal([1],         s:get_selection('2-2'))
call assert_equal([0,  1],     s:get_selection('1-2'))
call assert_equal([0,  1,  2], s:get_selection('1-9'))
for err in v:errors | echom err | endfor

call s:paste()
