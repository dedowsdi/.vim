"load guard
if exists('g:loaded_myvim')
  finish
endif
let g:loaded_myvim = 1

function! myvim#reverseQfList()
  call setqflist(reverse(getqflist()))
endfunction

function! myvim#isNumber(e) abort
  return type(a:e) == 0
endfunction
function! myvim#isString(e) abort
  return type(a:e) == 1
endfunction
function! myvim#isFuncref(e) abort
  return type(a:e) == 2
endfunction
function! myvim#isList(e) abort
  return type(a:e) == 3
endfunction
function! myvim#isDict(e) abort
  return type(a:e) == 4
endfunction
function! myvim#isFloat(e) abort
  return type(a:e) == 5
endfunction

function! myvim#warn(mes) abort
  echohl WarningMsg | echom a:mes | echohl None
endfunction

" a hack, maybe i should do it in another way
function! myvim#hasjob(job) abort
  try
    call jobpid(a:job) | return 1
  catch /^Vim\%((\a\+)\)\=:E900/ " catch error E900
    return 0
  endtry
endfunction

" check if quickfix window is open
function! myvim#isQfListOpen() abort
  for i in range(1, winnr('$'))
    let bufnr = winbufnr(i)
    if getbufvar(bufnr, '&buftype') ==# 'quickfix'
      return 1
    endif
  endfor
  return 0
endfunction

" is this necessary?
function! myvim#open(file) abort
  let nr = bufnr(a:file)
  if nr != -1
    exec printf('buffer %d', nr)
  else
    exec printf('edit %s', a:file)
  endif
endfunction

function! myvim#edit(file) abort
  if expand('%:p') != a:file && expand('%') != a:file
    silent! exec 'edit ' . a:file
  endif
endfunction

function! myvim#getC(lnum, cnum) abort
  return matchstr(getline(a:lnum), '\%' . a:cnum . 'c.')
endfunction
function! myvim#getCC() abort
  return myvim#getC(line('.'), col('.'))
endfunction

function! myvim#getV(lnum, vnum) abort
  return matchstr(getline(a:lnum), '\%' . a:vnum . 'v.')
endfunction
function! myvim#getVV() abort
  return myvim#getV(line('.'), col('.'))
endfunction

function! myvim#getCharacter(lnum, cnum, cv) abort
  return matchstr(getline(a:lnum), '\%' . a:cnum . a:cv)
endfunction

" opts{direction:'h or l' , delim: default to "," 
" jumpPairs: default to ["()","[]","{}","<>"], guard : default to "[]",
" cursorAction : 'f_to_start'(default), 'f_to_end', 'static' }
function! myvim#shiftItem(opts) abort

  let ranges = myvim#getArgs(a:opts)
  if ranges == []
    call myvim#warn('illigal range')|return
  endif

  let direction = get(a:opts, 'direction', 'h')
  let cursorActoin = get(a:opts, 'cursorAction', 'f_to_start')

  let [itemIndex, totalRange, itemRanges] = [ranges[0], ranges[1], ranges[2]]
  if itemIndex == -1
    call myvim#warn('you should not place your cursor at ' . myvim#getCC() ) 
    return
  endif

  if (itemIndex ==# 0 && direction ==# 'h') 
        \ || (itemIndex ==# len(itemRanges) -1 && direction ==# 'l') 
    call myvim#warn('no more items to shift')|return
  endif

  let targetIndex = direction ==# 'h' ? itemIndex -1 : itemIndex + 1
  if targetIndex < 0 || targetIndex >= len(itemRanges)
    call myvim#warn('no more items to shift') 
    return
  endif
  call myvim#swapRange(itemRanges[itemIndex], itemRanges[targetIndex], 'v')

  if cursorActoin !=# 'static'
     "place cursor at start of total range to avoid inner () problem
     call cursor(totalRange[0])
     "update item ranges
     let ranges = myvim#getArgs(a:opts)
     let targetRange = ranges[2][targetIndex]
     if cursorActoin ==# 'f_to_start'
       "place cursor at 1st non blank character in this item
       call cursor(targetRange[0])
       call myvim#charLeft()
       call search('\v\S')
     elseif cursorActoin ==# 'f_to_end'
       "place cursor at last non blank character in this item
       call cursor(targetRange[1])
       call myvim#charRight()
       call search('\v\S', 'bW')
     endif
  endif

endfunction

" search until one of expr found, ignore everything in pairs, doesn't include
" current character
" jumpPairs and expr should be completely different
" expr : desired pattern
" jumpPairs : such as (<{[ or )>}], when meet, execute %
function! myvim#searchOverPairs(expr, jumpPairs, flags) abort

  let searchExpr = '\v[' . a:expr . escape(a:jumpPairs, ']') . ']'
  " c in flags will be used only for the 1st time search.
  let [firstTime, flags] = [1, a:flags]
  while search(searchExpr, flags)
    if firstTime
      let firstTime = 0
      let flags = substitute(flags, 'c', '', 'g')
    endif
    if stridx(a:expr, myvim#getCC()) != -1
      return 1
    else
      keepjumps normal! %
    endif
  endwhile
  return 0

endfunction

" if you want to search > for < , make sure start is greater than pos of <
function! myvim#searchStringOverPairs(str, start, target, openPairs, closePairs, direction) abort
  if a:start >= len(a:str) | return -1 | endif

  let step = a:direction ==# 'l' ? 1 : -1
  let pairs0 = a:direction ==# 'l' ? a:openPairs : a:closePairs
  let pairs1 = a:direction ==# 'l' ? a:closePairs : a:openPairs

  " pair index stack
  let [stack, pos, size] = [a:start, len(a:str)]

  while pos >= 0 && pos < size
    let c = a:str[pos]
    if len(stack) == 0 && stridx(a:target, c) != -1 | return pos | endif
    let pos += step

    " ignore everyting except open or close char of current pair
    if len(stack) != 0
      " search matching pair
      if c ==# pairs1[ stack[-1] ]
        call remove(stack, -1)
      elseif c ==# pairs0[ stack[-1] ]
        let stack += stack[-1]
      endif
      continue
    endif

    " check open pair
    let idx = stridx(pairs0, c)
    if idx != -1 | let stack += [ idx ] | continue | endif

  endwhile

  return -1
endfunction

function! myvim#visualSelect(range, mode) abort
  call setpos('.', a:range[0]) | exec 'normal! ' . a:mode | call setpos('.', a:range[1])
endfunction

function! myvim#swapRange(range0, range1, mode) abort
  if myvim#cmpPos(a:range0[0], a:range1[0]) < 0
     let [leftRange, rightRange] = [a:range0, a:range1]
  else
     let [leftRange, rightRange] = [a:range1, a:range0]
  endif

  " replace right rangre 1st, otherwise left range will be corrupted
  let tmp = myvim#getRange(rightRange, a:mode)
  call myvim#replaceRange(rightRange, myvim#getRange(leftRange, a:mode), a:mode)
  call myvim#replaceRange(leftRange, tmp, a:mode)
endfunction

function! myvim#getRange(range, mode) abort
  let [cursorPos, regText, regType]= [getcurpos(), @a, getregtype('a')] | try
  call myvim#visualSelect(a:range, a:mode)
  normal! "ay
  let s = @a "this is needed, because @t is restored at finally clause
  return s
  finally | call setreg('a', regText, regType) | call setpos('.', cursorPos) | endtry
endfunction

function! myvim#replaceRange(range, content, mode) abort
  let [cursorPos, paste, regText, regType]= [getcurpos(), &paste, @a, getregtype('a')] 
  try
    let [&paste, @a]= [1, a:content]
    call myvim#visualSelect(a:range, a:mode)
    silent normal! "ap
  finally 
    call setpos('.', cursorPos) | let &paste = paste | call setreg('a', regText, regType) 
  endtry
endfunction

"return new trimed characterwise range
function! myvim#trimRange(range) abort
  let pos = getcurpos() | try
    let newRange = deepcopy(a:range)

    call setpos('.', a:range[0]) | call search('\v\S', 'cW') | let newRange[0] = getpos('.')
    call setpos('.', a:range[1]) | call search('\v\S', 'bcW') | let newRange[1] = getpos('.')

    return newRange
  finally | call setpos('.', pos) | endtry
endfunction

function! myvim#cmpPos(lhs, rhs) abort
  if a:lhs[0] != a:rhs[0]
    throw 'cmpPos support only pos on the same buffer'
  endif

  if a:lhs[1] < a:rhs[1]
    return -1
  elseif a:lhs[1] > a:rhs[1]
    return 1
  elseif a:lhs[2] < a:rhs[2]
    return -1
  elseif a:lhs[2] > a:rhs[2]
    return 1
  endif

  return 0
endfunction

function! myvim#translatePos(pos, step) abort
  let [startLine, startCol]= [line('.'), col('.')] | try
    call cursor(a:pos)
    if(a:step < 0)
      call myvim#charLeft(-a:step)
    else 
      call myvim#charRight(a:step)
    endif
    return getpos('.')[1:2]
  finally | call cursor(startLine, startCol) | endtry
endfunction

"TODO handle illigal range and step
"stretch range, based on real content, set step to negative to shink it
function! myvim#stretchRange(range, step) abort
  return [myvim#translatePos(a:range[0], -a:step), myvim#translatePos(a:range[1], a:step)]
endfunction

function! myvim#charRight(...) abort
  let step = get(a:000, 0, 1)
  " are there any option the same as backspace ?
  exec 'normal! '.step.' '
endfunction

function! myvim#charLeft(...) abort
  let step = get(a:000, 0, 1)
  let backspace = &backspace|try
    let &backspace='indent,eol,start' 
    exec 'normal! '.step.''
  finally|let &backspace = backspace|endtry
endfunction

function! myvim#trim(s, ...) abort
  let noLeft = get(a:000, 0, 0)
  let noRight = get(a:000, 1, 0)
  let res = a:s
  if !noLeft|let res = matchstr(res, '\v^\s*\zs.*')|endif
  if !noRight|let res = matchstr(res, '\v.{-}\ze\s*$')|endif
  return res
endfunction

"add lnum, cnum to jump list
function! myvim#createJumps(lnum,cnum) abort
  let [startLine, startCol]= [line('.'), col('.')] | try
    let oldpos = getpos('.')

    call cursor(a:lnum, a:cnum)
    normal! m'

  finally
    call setpos('.', oldpos)
  endtry
endfunction

" copy last visual without side effect
function! myvim#getVisualString() abort
  let [regText, regType] = [getreg('a'), getregtype('a')] | norm! gv"ay
  let str = @a | call setreg('a', regText, regType) | return str
endfunction

" type:
"   0 : vim very no magic forward search pattern
"   1 : :grep
"   2 : Fag
function! myvim#literalize(str, type) abort

  if a:type == 0
    return '\V' . substitute(escape(a:str, '\'), "\n", '\\n', 'g')
  endif

  " shellescale will escape ! and \n, but ! and \n doesn't need to be escaped in
  " a literal match. shellescape also doesn't escape |, which will cause problem
  " in ex command
  let s = substitute(a:str, "'", "'\\\\''", 'g')
  if a:type == 1
    let s = escape(s, '%#|')
  else
    " don't need to escape |, Fag has no -bar option 
    let s = escape(s, '%#')
  endif

  " wrap in ''
  return printf("'%s'", s)
endfunction

" [literalType, []]
function! myvim#literalCopy(wiseType, literalType, visual)
  if a:visual " visual mode
    silent exe printf('normal! gv"%sy', v:register)
  elseif a:wiseType ==# 'line'
    silent exe printf("normal! '[V']\"%sy", v:register)
  else
    silent exe printf("normal! `[v`]\"%sy", v:register)
  endif
  exec printf('let @%s = myvim#literalize(@%s, a:literalType)', v:register, v:register)
endfunction

function! myvim#literalCopyVim(wiseType, ...)
  call myvim#literalCopy(a:wiseType, 0, a:0)
endfunction

function! myvim#literalCopyGrep(wiseType, ...)
  call myvim#literalCopy(a:wiseType, 1, a:0)
endfunction

function! myvim#switchRtp(path) abort
  if !has_key(s:, 'originalRtp')
    let s:originalRtp = &rtp
  endif

  let &rtp = printf('%s,%s,%s', s:originalRtp, a:path, a:path.'/after')
endfunction

function! myvim#updateTags() abort
  if filereadable('.vim/ctags.sh')
    call jobstart('.vim/ctags.sh')
  endif
endfunction
