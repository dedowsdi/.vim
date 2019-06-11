let s:data = []

function! misc#dc#startCopy(reset)
  if a:reset | let s:data = [] | endif
  augroup DATA_COPY_PASTE
    au!
    autocmd TextYankPost * call s:copy()
  augroup END
  echohl Title | echo 'start recording yank delete' | echohl None
endfunction

function! misc#dc#stopCopy()
  augroup DATA_COPY_PASTE
    au!
    autocmd TextYankPost * call s:copy()
  augroup END
  echohl Title | echo 'stop recording' | echohl None
endfunction

function! misc#dc#paste()
  call misc#dc#stopCopy()
  call s:paste()
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
  echohl ModeMsg | let inputStr = input(prompt, 'norm! ') | echohl None
  if inputStr ==# '' | return | endif

  let matches = matchlist(inputStr, '\v^([0-9\-,]*)(\*)?\s*(.*)')
  let [range, doTail, cmd] = [matches[1], matches[2], matches[3]]

  call s:print(s:getSelection(range), cmd, !empty(doTail))
endfunction

" * or blank : all
" a-b        : range(a, b)
" a,b        : a and b
" a-         : a until last
" -b         : 1 until b
" currently not used
function! s:getSelection(str)
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

function! s:print(indices, cmd, doTail)
  let [regText, regType, i] = [@", getregtype('"'), 0]
  for index in a:indices
    let [entry, cpos, i] = [s:data[index], getcurpos(), i+1]

    " gp place cursor after the new text if it's not the end of line or file,
    " otherwise it place cursor at end of new text, it's inconsistent, so i
    " choose p instead
    call setreg('"', entry.text, entry.mode) | norm! ""p
    if entry.mode =~# 'V'

      " place cursor at 1st non space character of pasted lines
      let numLines = count(@", "\n")
      if numLines >1 | exec '+'.(numLines-1) | endif
    elseif entry.mode =~# ''

      " place cursor at right up corner of pasted block
      call cursor(line('.'), col('.') + 1 - str2nr(matchstr(entry.mode, '\v\d+')))
    endif
    if empty(a:cmd) || (!a:doTail && i == len(a:indices)) | continue | endif
    exec a:cmd
  endfor
  call setreg('"', regText, regType)
endfunction

finish

" ------------------------------------------------------------------------------
" test
" ------------------------------------------------------------------------------
command! RecordYank :call misc#dc#startCopy(1)
command! RecordYankAppend :call misc#dc#startCopy(0)
command! RecordPaste :call misc#dc#paste()
command! RecordStop :call misc#dc#stopCopy()

nnoremap <leader>ry :call misc#dc#startCopy(1)<cr>
nnoremap <leader>rY :call misc#dc#startCopy(0)<cr>
nnoremap <leader>rp :call misc#dc#paste()<cr>

let v:errors = []
let s:data = [{'mode':'v', 'text':'a'}, {'mode':'v', 'text':'b'}, {'mode':'v', 'text':'c'}]
call assert_equal([0,  1,  2], s:getSelection(''))
call assert_equal([0,  1,  2], s:getSelection('1-'))
call assert_equal([0,  1,  2], s:getSelection('1-3'))
call assert_equal([0,  1,  2], s:getSelection('1,2,3'))
call assert_equal([0,  1,  2], s:getSelection('1-1,2-3'))
call assert_equal([0,  1,  2], s:getSelection('-3'))
call assert_equal([0],         s:getSelection('1'))
call assert_equal([2],         s:getSelection('3'))
call assert_equal([1],         s:getSelection('2-2'))
call assert_equal([0,  1],     s:getSelection('1-2'))
call assert_equal([0,  1,  2], s:getSelection('1-9'))
for err in v:errors | echom err | endfor

call s:paste()
