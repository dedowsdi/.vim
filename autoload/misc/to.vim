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

    if myvim#getCC() == rightGuard
      call myvim#charLeft()
    endif
    "goto left guard first
    if !myvim#searchWithJumpPair(leftGuard, rightPairs, 'bcW')|return []|endif
    let totalRange[0] = getpos('.')
    call myvim#charRight() " move away from (
    let argRangeStart = getpos('.')
    call myvim#charLeft() " move back to (

    "find item ranges and right guard
    while myvim#searchWithJumpPair(rightGuard.delim, leftPairs, 'W')
      let c = myvim#getCC()
      if c ==# delim
        call myvim#charLeft()  " move cursor away from ','
        let argRanges += [[argRangeStart, getpos('.') ]]
        call myvim#charRight(2) " move cursor forward away from ','
        let argRangeStart = getpos('.')
        call myvim#charLeft()  " move cursor back to  ','
      else
        let totalRange[1] = getpos('.')
        call myvim#charLeft()  " move cursor back away from ','
        let argRanges += [[argRangeStart, getpos('.')]]
        break
      endif
    endwhile

    "find current item index
    let [argIndex, size]  = [0, len(argRanges)]
    while argIndex != size
      let range = argRanges[argIndex]
      if myvim#cmpPos(range[0], curPos) <= 0 && myvim#cmpPos(range[1], curPos) >=0
        break
      endif
      let argIndex += 1
    endwhile

    "set argIndex to -1 if it's invalid
    if argIndex == len(argRanges) | let argIndex = -1 | endif

    "exclude space after find current item, allow current character to be space
    if excludeSpace
      for range in argRanges
        "carefule here, don't use let range = myvim#trimRange(range)
        let trimedRange = myvim#trimRange(range)
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

  if ranges == [] | call myvim#warn('illigal range') | return | endif

  let [argIndex, totalRange, argRanges] = [ranges[0], ranges[1], ranges[2]]
  if argIndex == -1
    call myvim#warn('you should not place your cursor at ' . myvim#getCC() )
    return
  endif

  let curArgRange = ranges[2][argIndex]
  call myvim#visualSelect(curArgRange, 'v')
endfunction

"\w and \d only
function! misc#to#selLetter() abort
  let pattern = '\v[a-zA-Z]+'
  if myvim#getCC() !~# pattern | return -1 | endif
  call search(pattern, 'bc')
  normal! v
  call search(pattern, 'ce')  " \w+ will jump to next word if it's a single letter
  return 1
endfunction

" ov : o for omap, v for v map
" jk : j or k or jk. j for down, k for up.
" visuall block wisely select current column until blank line.
function! misc#to#selColumn(ov, jk) abort
  let [curVnum, curLnum, colLnum0, colLnum1, lnum] =
              \ [virtcol('.')] + repeat([line('.')], 4)
  " do nothing if cursor in blank
  if myvim#getV(curLnum, curVnum) =~# '\v\s'
    if a:ov ==# 'v' | exec 'normal! ' | endif | return
  endif

  " get column end
  if stridx(a:jk, 'j') != -1
    while 1
      let lnum = lnum + 1
      if lnum > line('$') || myvim#getV(lnum, curVnum) =~# '\v^$|\s'
        let colLnum0 = lnum - 1 | break
      endif
    endwhile
  endif

  " get column start
  if stridx(a:jk, 'k') != -1
    let lnum = curLnum
    while 1
      let lnum = lnum - 1
      if lnum <= 0 || myvim#getV(lnum, curVnum) =~# '\v^$|\s'
        let colLnum1 = lnum + 1 | break
      endif
    endwhile
  endif

  " visual select
  call cursor(colLnum0, col('.'))
  exec 'normal! '
  call cursor(colLnum1, col('.'))
endfunction
