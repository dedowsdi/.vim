function! misc#warn(mes)
  echohl WarningMsg | echom a:mes | echohl None
endfunction

" a hack, maybe i should do it in another way
function! misc#hasjob(job)
  try | call jobpid(a:job)
    return 1
  catch /^Vim\%((\a\+)\)\=:E900/	" catch error E900
    return 0
  endtry
endfunction

" check if quickfix window is open
function! misc#qfixexists()
  for i in range(1, winnr('$'))
    let bufnr = winbufnr(i)
    if getbufvar(bufnr, '&buftype') == 'quickfix'
      return 1
    endif
  endfor
  return 0
endfunction

" jump to buffer win if bufwinnr is not -1
" return 1 if success
function! misc#jumpToBufWin(buf)
  if bufwinnr(a:buf)  != -1
    exec bufwinnr(a:buf).'wincmd w'
    return 1
  endif
  return 0
endfunction

" make sure 1 and only 1 trailing /
function! misc#normDir(splitdir)
  if a:splitdir == ""|return a:splitdir|endif
  return substitute(a:splitdir, '\v//*$', '', '').'/'
endfunction

" _| normalized_size
function! misc#hvSize(hv, size)
  if !has_key(s:hvOptions, a:hv)
    throw "unknown hv: " . a:hv
  endif
  return float2nr(s:hvOptions[a:hv].maxSize * a:size)
endfunction

function! misc#fileExists(file)
  return !empty(glob(a:file))
endfunction

function! misc#writable(file)
  call system('[[ -w ' . a:file . ' ]]')  
  return !v:shell_error
endfunction

function! misc#dirExists(dir)
  call system('[[ -d ' . a:dir . ' ]]')  
  return !v:shell_error
endfunction

let s:hvOptions = {
      \ "_" : {"winfix":"winfixheight",  "dir":"",  "maxSize":&lines,  },
      \ "|" : {"winfix":"winfixwidth", "dir":"vertical ", "maxSize":&columns,},
      \ }

let s:layouts = {
      \ "J": ["botright ", "_"],
      \ "K": ["topleft ",  "_"],
      \ "L": ["botright ", "|"],
      \ "H": ["topleft ",  "|"],
      \ }

" opts{layout:,size:,fix:}, cmd
" return bufnr
function! misc#layoutCmd(opts, cmd)
  let layout = get(a:opts, "layout", 'J')
  let size = get(a:opts, "size", 0.5)
  let fix = get(a:opts, "fix", 0)
  let hv = s:layouts[layout][1]
  let hvOption = s:hvOptions[hv]
  let hvSize = misc#hvSize(hv, size)

  exec s:layouts[layout][0] . hvOption.dir . a:cmd ' | ' . hvSize .  'wincmd ' . hv

  if fix
    exec 'setlocal ' . hvOption.winfix
  endif
  return bufnr('%')
endfunction

function! misc#getCC()
  return matchstr(getline('.'), '\%' . col('.') . 'c.')
endfunction

" opts{direction:"h or l" , delim: default to "," 
" itemScope: default to ["()","[]","{}","<>"], guard : default to "[]"  }
function! misc#shiftItem(opts)

  let ranges = misc#getItemRanges(a:opts)
  if ranges == []
    call misc#warn('illigal range')|return
  endif

  let itemIndex = ranges[0]
  let itemRanges = ranges[2]
  let direction = get(a:opts, "direction", "h")

  if (itemIndex == 0 && direction == 'h') 
        \ || (itemIndex == len(itemRanges) -1 && direction == 'l') 
    call misc#warn('no more items to shift')|return
  endif

  let targetIndex =  direction == 'h' ? itemIndex -1 : itemIndex + 1
  call misc#swapRange(itemRanges[itemIndex], itemRanges[targetIndex])

endfunction


"return [itemIndex, [total range] [item1 range, item 2 range ....]]
function! misc#getItemRanges(opts)

  let [startLine, startCol] = [line('.'), col('.')] | try

    let delim = get(a:opts, "delim", ",")
    let guard = get(a:opts, "guard", "()")
    let itemScope = get(a:opts, "itemScope", ["()","[]","{}","<>"])
    let [leftGuard, rightGuard] = [guard[0], guard[1]]
    let totalRange = [[0,0], [0,0]]
    let itemRanges = []

    let [leftScope, rightScope] = ["", ""]

    for scope in itemScope
      let leftScope .= scope[0]
      let rightScope .= scope[1]
    endfor

    let c = misc#getCC()
    "do nothing if curson under delim
    if delim == c
      "return empty if cursor under , or ( or )
      call misc#warn("you should move your cursor away from delim \"".c."\"") 
      return []
    endif

    "goto left guard first
    if c != leftGuard
      if !misc#searchIgnoreScope(leftGuard, rightScope, a:opts)|return []|endif
    endif
    let totalRange[0] = [line("."), col(".")]
    call search('\v.')
    let itemRangeStart = [line("."), col(".")]
    call misc#charBackward()

    "find item ranges and right guard
    while misc#searchIgnoreScope(rightGuard.delim, leftScope, {"direction":"l"})
      let c = misc#getCC()
      if c == delim
        call misc#charBackward()  " move cursor back away from ','
        let itemRanges += [[itemRangeStart, [line('.'),col('.')] ]]
        " move cursor forward away from ','
        " TODO figure out why call search('\v..', 'e') not working
        "call search('\v..', 'e')
        call misc#charForward(2)
        let itemRangeStart = [line("."), col(".")]
        call misc#charBackward()  " move cursor back to  ','
      else
        let totalRange[1] = [line("."), col(".")]
        call misc#charBackward()  " move cursor back away from ','
        let itemRanges += [[itemRangeStart, [line('.'),col('.')] ]]
        break
      endif
    endwhile

    "find current item index
    let cursorRange = [startLine, startCol]
    let itemIndex = 0
    while itemIndex != len(itemRanges)
      let range = itemRanges[itemIndex]
      if misc#cmpPos(range[0], cursorRange) <= 0 && misc#cmpPos(range[1], cursorRange) >=0 
        break
      endif
      let itemIndex += 1
    endwhile
    return [itemIndex, totalRange, itemRanges]

  finally | call cursor(startLine, startCol) | endtry
endfunction

" search until one of expr found, ignore everything in scope and it's %
" eg : ( ',(',  ')}]>',  {direction:h} )
function! misc#searchIgnoreScope(expr, scope, opts)
  let direction = get(a:opts, "direction", 'h') 
  let flag = direction == 'h' ? 'bW' : ''

  let searchExpr = '\v[' . a:expr . escape(a:scope, '[]') . ']'

  while search(searchExpr, flag)
    let c = misc#getCC()
    if match(a:expr, c) != -1
      return 1
    else
      normal! %
    endif
  endwhile

  return 0
endfunction

function! misc#swapRange(range0, range1)
  if misc#cmpPos(a:range0[0], a:range1[0]) < 0
     let [leftRange, rightRange] = [a:range0, a:range1]
  else
     let [leftRange, rightRange] = [a:range1, a:range0]
  endif

	let leftItem = misc#getRange(leftRange)
	let rightItem = misc#getRange(rightRange)
  " replace right rangre 1st, otherwise left range will be corrupted
  call misc#replaceRange(rightRange, leftItem)
  call misc#replaceRange(leftRange, rightItem)
endfunction

" visual select, place cursor at start of range
function! misc#visualSelect(range)
	let [lnum0,cnum0] = a:range[0]
	let [lnum1,cnum1] = a:range[1]

  call cursor(lnum0, cnum0)
  call setpos("'<",[0,lnum0,cnum0,0])
  call setpos("'>",[0,lnum1,cnum1,0])
  normal! gv
endfunction

function! misc#getRange(range)
  let [startLine, startCol, bak]= [line('.'), col('.'), @t] | try
  call misc#visualSelect(a:range)
  normal! "ty 
  let s = @t "this is needed, because @t is restored at finally clause
  return s 
  finally | let @t = bak | call cursor(startLine, startCol) | endtry
endfunction

function! misc#replaceRange(range, content)
  let [startLine, startCol, paste, rbak]= [line('.'), col('.'), &paste, @t] | try
    let [&paste, @t]= [1, a:content]
    call misc#visualSelect(a:range) 
    silent normal! "tp 
  finally | call cursor(startLine, startCol)| let [&paste, @t] = [paste, rbak] | endtry
endfunction

" lhs:[line, col],  etc
function! misc#cmpPos(lhs, rhs)
  if a:lhs[0] < a:rhs[0]
    return -1
  elseif a:lhs[0] > a:rhs[0]
    return 1
  elseif a:lhs[1] < a:rhs[1]
    return -1
  elseif a:lhs[1] > a:rhs[1]
    return 1
  endif
  return 0
endfunction

function! misc#charForward(...)
  let step = get(a:000, 0, 1)
  " are there any option the same as backspace ?
  exec 'normal! '.step.' '
endfunction

function! misc#charBackward(...)
  let step = get(a:000, 0, 1)
  let backspace = &backspace|try
    let &backspace='indent,eol,start' 
    exec 'normal! '.step.''
  finally|let &backspace = backspace|endtry
endfunction

""
" echom ******
" @param1 msg{String}: msg to print
" @return :
""
function! misc#startScript(...)
  let s:oldmore = &more
  let s:scriptTimer = reltime()
  set nomore
  echom "**********************************************************************"
  echom a:0 ? a:1 : "Starting..."
endfunction!

""
" echom ******
" @param1 msg{String}: msg to print
" @return :
""
function! misc#endScript(...)
  echom a:0 ? a:1 : "Done in " . reltimestr(reltime(s:scriptTimer)) . " seconds"
  echom "**********************************************************************"
  let &more = s:oldmore
endfunction!
