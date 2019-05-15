let s:data = []

function! misc#dc#startCopy(reset)
  if a:reset | let s:data = [] | endif
  echohl Title | echo 'start copy...' | echohl None
  augroup DATA_COPY_PASTE
    au!
    autocmd TextYankPost * call s:copy()
  augroup END
endfunction

function! misc#dc#startPaste()
  augroup DATA_COPY_PASTE
    au!
  augroup END
  call s:paste()
endfunction

function! s:copy()
  let entry = {'text':@", 'mode':getregtype('"')}
  if s:data == [] || s:data[-1] != entry
    call add(s:data, entry)
  endif
endfunction

function! s:paste()
  if s:data == [] | return | endif
  let prompt = "[range][space][normal commands] \n\n"
  let i = 0
  for entry in s:data
    let i += 1
    let idx = stridx(entry.text, "\n")
    let prompt .= printf("%d : %s : %s\n", i,
          \ substitute(entry.mode, '', '^V', ''),
          \ idx != -1 ? entry.text[0:stridx(entry.text, "\n")-1] . '...' : entry.text)
  endfor
  let inputStr = input(prompt)
  if inputStr ==# '' | return | endif
  let matches =  matchlist(inputStr, '\v([0-9,\-]*)\s*(.*)')
  let [selStr, cmds] = [matches[1], matches[2]]
  call s:print(s:getSelection(selStr), cmds, 1)
endfunction

" * or blank : all
" a-b        : range(a, b)
" a,b        : a and b
" a-         : a until last
" -b         : 1 until b
function! s:getSelection(str)
  if a:str ==# '' || a:str ==# '*'
    return range(len(s:data))
  else
    let indices = []
    for item in split(a:str, ',')
      if item =~# '-'
        let [i0, i1] = split(item, '-', 1)
        if i0 ==# '' | let i0 = 1 | endif
        if i1 ==# '' | let i1 = len(s:data) | endif
        let indices += range(i0-1, i1-1)
      else
        let indices += [item - 1]
      endif
    endfor
    call filter(indices, 'v:val < len(s:data)') | return indices
  endif
endfunction

function! s:print(indices, cmds, noTailCmd)
  let [regText, regType, i] = [@a, getregtype('a'), 0]
  for index in a:indices
    let [entry, cpos, i] = [s:data[index], getcurpos(), i+1]
    " gp place cursor after the new text if it's not the end of line or file,
    " otherwise  it place cursor at end of new text, it's inconsistent, so i
    " choose p instead
    call setreg('a', entry.text, entry.mode) | normal! "ap
    if entry.mode =~# 'V'
      let numLines = count(@a, "\n")
      if numLines >1 | exec 'norm! '.(numLines-1).'j' | endif
    elseif entry.mode =~# ''
      " place cursor at right upper corner of newly pasted block
      " p for block paste will place cursor at 1st column of pasted block
      call cursor(line('.'), col('.') + 1 - str2nr(matchstr(entry.mode, '\v\d+')))
    endif
    if empty(a:cmds) || (a:noTailCmd && i == len(a:indices)) | continue | endif
    exec 'norm! ' a:cmds
  endfor
  call setreg('a', regText, regType)
endfunction

finish
" ------------------------------------------------------------------------------
" test
" ------------------------------------------------------------------------------
nnoremap <leader>sc :call misc#dc#startCopy(1)<cr>
nnoremap <leader>sC :call misc#dc#startCopy(0)<cr>
nnoremap <leader>sp :call misc#dc#startPaste()<cr>
vnoremap <leader>sp :call misc#dc#startPaste()<cr>

let s:data = [{'mode':'v', 'text':'a'}, {'mode':'v', 'text':'b'}, {'mode':'v', 'text':'c'}]
let v:errors = []
call assert_equal([0,  1,  2], s:getSelection('*'))
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
