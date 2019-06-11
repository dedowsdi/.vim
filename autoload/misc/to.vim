" simple text objects

" return [itemIndex, [total range] [item1 range, item 2 range ....]]
" itemIndex will be -1 if it can not be found.(eg: cursor at ( or , or ) )
"
" search starts at current cursor.
"
" opts : {excludeSpace:1, delim:',', guard:'()', 'jumpPairs':[(),[],{},<>}
function! misc#to#getArgs(opts) abort

  let curPos = getpos('.') | try

    let delim = get(a:opts, 'delim', ',')
    let guard = get(a:opts, 'guard', '()')
    let excludeSpace = get(a:opts, 'excludeSpace', 1)
    let jumpPairs = get(a:opts, 'jumpPairs', ['()','[]','{}','<>'])
    let [leftGuard, rightGuard] = [guard[0], guard[1]]
    let totalRange = [[0,0], [0,0]]
    let argRanges = []

    let [leftPairs, rightPairs] = ['', '']
    for item in jumpPairs
      let leftPairs .= item[0]
      let rightPairs .= item[1]
    endfor

    if misc#getCC() == rightGuard
      call misc#charLeft()
    endif
    "goto left guard first
    if !misc#searchOverPairs(leftGuard, rightPairs, 'bcW')|return []|endif
    let totalRange[0] = getpos('.')
    call misc#charRight() " move away from (
    let argRangeStart = getpos('.')
    call misc#charLeft() " move back to (

    "find item ranges and right guard
    while misc#searchOverPairs(rightGuard.delim, leftPairs, 'W')
      let c = misc#getCC()
      if c ==# delim
        call misc#charLeft()  " move cursor away from ','
        let argRanges += [[argRangeStart, getpos('.') ]]
        call misc#charRight(2) " move cursor forward away from ','
        let argRangeStart = getpos('.')
        call misc#charLeft()  " move cursor back to  ','
      else
        let totalRange[1] = getpos('.')
        call misc#charLeft()  " move cursor back away from ','
        let argRanges += [[argRangeStart, getpos('.')]]
        break
      endif
    endwhile

    "find current item index
    let [argIndex, size]  = [0, len(argRanges)]
    while argIndex != size
      let range = argRanges[argIndex]
      if misc#cmpPos(range[0], curPos) <= 0 && misc#cmpPos(range[1], curPos) >=0
        break
      endif
      let argIndex += 1
    endwhile

    "set argIndex to -1 if it's invalid
    if argIndex == len(argRanges) | let argIndex = -1 | endif

    "exclude space after find current item, allow current character to be space
    if excludeSpace
      for range in argRanges
        "carefule here, don't use let range = misc#trimRange(range)
        let trimedRange = misc#trimRange(range)
        let [range[0], range[1]] = [trimedRange[0], trimedRange[1] ]
      endfor
    endif

    return [argIndex, totalRange, argRanges]

  finally | call setpos('.', curPos) | endtry
endfunction

" visual select cur arg, by default space included
function! misc#to#selCurArg(opts) abort
  call extend(a:opts, {'excludeSpace':0}, 'keep')
  let ranges = misc#to#getArgs(a:opts)

  if ranges == [] | call misc#warn('illigal range') | return | endif

  let [argIndex, totalRange, argRanges] = [ranges[0], ranges[1], ranges[2]]
  if argIndex == -1
    call misc#warn('you should not place your cursor at ' . misc#getCC() )
    return
  endif

  let curArgRange = ranges[2][argIndex]
  call misc#visualSelect(curArgRange, 'v')
endfunction

" opts{direction:'h or l' , delim: default to ","
" jumpPairs: default to ["()","[]","{}","<>"], guard : default to "()",
" cursorAction : 'argFirstChar'(default), 'argLastChar', 'static' }
function! misc#to#bubbleArg(opts) abort

  let args = misc#to#getArgs(a:opts)
  if args == [] | call misc#warn('illigal range')| return | endif

  let direction = get(a:opts, 'direction', 'h')
  let cursorActoin = get(a:opts, 'cursorAction', 'argFirstChar')

  let [argIndex, totalRange, argRanges] = [args[0], args[1], args[2]]
  if argIndex == -1
    call misc#warn('you should not place your cursor at ' . misc#getCC() )  | return
  endif

  let targetIndex = direction ==# 'h' ? argIndex - 1 : argIndex + 1
  if targetIndex < 0
    let targetIndex = len(argRanges) - 1
  elseif targetIndex >= len(argRanges)
    let targetIndex = 0
  endif
  call misc#swapRange(argRanges[argIndex], argRanges[targetIndex], 'v')

  " place cursor
  if cursorActoin !=# 'static'
     " cursor might in inner () after bubble, to be safe, place it at outmost (
     call setpos('.', totalRange[0])
     " get new args
     let args = misc#to#getArgs(a:opts)
     let targetRange = args[2][targetIndex]
     if cursorActoin ==# 'argFirstChar'
       "place cursor at 1st non blank character in this arg
       call setpos('.', targetRange[0]) |  call search('\v\S', 'cW')
     elseif cursorActoin ==# 'argLastChar'
       "place cursor at last non blank character in this arg
       call setpos('.', targetRange[1]) | call search('\v\S', 'bcW')
     endif
  endif

endfunction

"\w and \d only
function! misc#to#selLetter() abort
  let pattern = '\v[a-zA-Z]+'
  if misc#getCC() !~# pattern | return -1 | endif
  call search(pattern, 'bc')
  normal! v
  call search(pattern, 'ce')  " \w+ will jump to next word if it's a single letter
  return 1
endfunction

function! misc#to#verticalE() abort
  exec "norm! \<c-v>"
  call misc#mo#vertical_motion('E')
endfunction

" select lines if current line is between patterns, otherwise do nothing
" style : 0 : use ai to include or exclude pattern line
" style : 1 : use ai to include or exclude space
function! misc#to#selLines(pattern0, pattern1, ai, style)
  let cpos = getcurpos()

  try

    " jump to start line or exit
    if !search(a:pattern0, 'bcW') | return | endif
    let startline = line('.')

    " jump to end line or exit
    if !search(a:pattern1, 'W') | return | endif
    let endline = line('.')
    if endline < cpos[1] | return | endif

    " adjust start and end for i
    if a:ai ==# 'i' && a:style == 0
      let startline += 1
      let endline -= 1
      if startline > endline | return | endif
    endif

    " add trailing or preceding space for 'a' if style is 1
    if a:style == 1 && a:ai ==# 'a'

      " | branch is used to handle leading and trailing blank lines in the buffer
      if search('\v^.*\S|%$', 'W')
        if getline('.') =~# '\S' | - | endif
      endif

      " if no space after endline, search backward from startline
      if line('.') != endline
        let endline = line('.')
      else
        exec startline
        if search('\v^.*\S|%1l', 'bW')
          if getline('.') =~# '\S' | + | endif
          let startline = line('.')
        endif
      endif
    endif

  finally

    " restore current position before return
    call setpos('.', cpos)
  endtry

  " visually select from startline to endline
  norm! V
  exec startline
  norm! o
  exec endline
endfunction

" ov : o for omap, v for v map
" jk : j or k or jk. j for down, k for up.
" visuall block wisely select current column until blank line.
"function! misc#to#selColumn(ov, jk) abort
  "let [curVnum, curLnum, colLnum0, colLnum1, lnum] =
              "\ [virtcol('.')] + repeat([line('.')], 4)
  "" do nothing if cursor in blank
  "if misc#getV(curLnum, curVnum) =~# '\v\s'
    "if a:ov ==# 'v' | exec 'normal! ' | endif | return
  "endif

  "" get column end
  "if stridx(a:jk, 'j') != -1
    "while 1
      "let lnum = lnum + 1
      "if lnum > line('$') || misc#getV(lnum, curVnum) =~# '\v^$|\s'
        "let colLnum1 = lnum - 1 | break
      "endif
    "endwhile
  "endif

  "" get column start
  "if stridx(a:jk, 'k') != -1
    "let lnum = curLnum
    "while 1
      "let lnum = lnum - 1
      "if lnum <= 0 || misc#getV(lnum, curVnum) =~# '\v^$|\s'
        "let colLnum0 = lnum + 1 | break
      "endif
    "endwhile
  "endif

  "" visual select
  "call cursor(colLnum0, col('.'))
  "exec "normal! \<c-v>"
  "call cursor(colLnum1, col('.'))
"endfunction
