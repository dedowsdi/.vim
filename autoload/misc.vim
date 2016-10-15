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
  exec 'let maxSize = &' . s:hvOptions[a:hv].maxSize
  return float2nr(maxSize * a:size)
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
      \ "_" : {"winfix":"winfixheight",  "dir":"",  "maxSize":"lines",  },
      \ "|" : {"winfix":"winfixwidth", "dir":"vertical ", "maxSize":"columns",},
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
" jumpPairs: default to ["()","[]","{}","<>"], guard : default to "[]",
" cursorAction : "f_to_start"(default), "f_to_end", "static" }
function! misc#shiftItem(opts)

  let ranges = misc#getItemRanges(a:opts)
  if ranges == []
    call misc#warn('illigal range')|return
  endif

  let direction = get(a:opts, "direction", "h")
  let cursorActoin = get(a:opts, "cursorAction", "f_to_start")

  let [itemIndex, totalRange, itemRanges] = [ranges[0], ranges[1], ranges[2]]
  if itemIndex == -1
    call misc#warn('you should not place your cursor at ' . misc#getCC() ) 
    return
  endif

  if (itemIndex == 0 && direction == 'h') 
        \ || (itemIndex == len(itemRanges) -1 && direction == 'l') 
    call misc#warn('no more items to shift')|return
  endif
  

  let targetIndex = direction == 'h' ? itemIndex -1 : itemIndex + 1
  if targetIndex < 0 || targetIndex >= len(itemRanges)
    call misc#warn("no more items to shift") 
    return
  endif
  call misc#swapRange(itemRanges[itemIndex], itemRanges[targetIndex])

  if cursorActoin != "static"
     "place cursor at start of total range to avoid inner () problem
     call cursor(totalRange[0])
     "update item ranges
     let ranges = misc#getItemRanges(a:opts)
     let targetRange = ranges[2][targetIndex]
     if cursorActoin == "f_to_start"
       "place cursor at 1st non blank character in this item
       call cursor(targetRange[0])
       call misc#charBackward()
       call search('\v\S')
     elseif cursorActoin == "f_to_end"
       "place cursor at last non blank character in this item
       call cursor(targetRange[1])
       call misc#charForward()
       call search('\v\S', 'bW')
     endif
  endif

endfunction


"return [itemIndex, [total range] [item1 range, item 2 range ....]]
"opts : {"excludeSpace":1}, itemIndex will be -1 if it can not be found(ie,
"cursor on comma or cursor on '(' or ')' )
function! misc#getItemRanges(opts)

  let [startLine, startCol] = [line('.'), col('.')] | try

    let delim = get(a:opts, "delim", ",")
    let guard = get(a:opts, "guard", "()")
    let excludeSpace = get(a:opts, "excludeSpace", 1)
    let jumpPairs = get(a:opts, "jumpPairs", ["()","[]","{}","<>"])
    let [leftGuard, rightGuard] = [guard[0], guard[1]]
    let totalRange = [[0,0], [0,0]]
    let itemRanges = []

    let [leftPairs, rightPairs] = ["", ""]

    for scope in jumpPairs
      let leftPairs .= scope[0]
      let rightPairs .= scope[1]
    endfor

    let c = misc#getCC()
    "do nothing if curson under delim
    "if delim == c
      "return empty if cursor under , or ( or )
      "call misc#warn("you should move your cursor away from delim \"".c."\"") 
      "return []
    "endif

    "goto left guard first
    if c != leftGuard
      if !misc#searchWithJumpPair(leftGuard, rightPairs, {"direction":"h"})|return []|endif
    endif
    let totalRange[0] = [line("."), col(".")]
    call search('\v.')
    let itemRangeStart = [line("."), col(".")]
    call misc#charBackward()

    "find item ranges and right guard
    while misc#searchWithJumpPair(rightGuard.delim, leftPairs, {"direction":"l"})
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
    let [itemIndex, size]  = [0, len(itemRanges)]
    while itemIndex != size
      let range = itemRanges[itemIndex]
      if misc#cmpPos(range[0], cursorRange) <= 0 && misc#cmpPos(range[1], cursorRange) >=0 
        break
      endif
      let itemIndex += 1
    endwhile

    "set itemIndex to -1 if it's invalid
    if itemIndex == len(itemRanges)|let itemIndex = -1 |endif
    

    "exclude space after find current item, allow current character to be space
    if excludeSpace
      for range in itemRanges
        "carefule here, don't use let range = misc#trimRange(range)
        let trimedRange = misc#trimRange(range) 
        let range[0] = trimedRange[0]
        let range[1] = trimedRange[1]
      endfor
    endif


    return [itemIndex, totalRange, itemRanges]

  finally | call cursor(startLine, startCol) | endtry
endfunction

"visual select cur arg, by default space included
function! misc#selCurArg(opts)
  call extend(a:opts, {"excludeSpace":0}, "keep") 
  let ranges = misc#getItemRanges(a:opts)

  if ranges == []
    call misc#warn("illigal range")|return
  endif

  let [itemIndex, totalRange, itemRanges] = [ranges[0], ranges[1], ranges[2]]
  if itemIndex == -1
    call misc#warn('you should not place your cursor at ' . misc#getCC() ) 
    return
  endif

  let curItemRange = ranges[2][ranges[0]]
  call misc#visualSelect(curItemRange)
endfunction

" search until one of expr found, ignore everything in scope and it's %
" eg : ( ',(',  ')}]>',  {direction:h} )
function! misc#searchWithJumpPair(expr, jumpPairs, opts)
  let direction = get(a:opts, "direction", 'h') 
  let flag = direction == 'h' ? 'bW' : ''

  let searchExpr = '\v[' . a:expr . escape(a:jumpPairs, '[]') . ']'

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

function! misc#deleteRange(range)
  let [startLine, startCol]= [line('.'), col('.')] | try
  call misc#visualSelect(a:range)
  normal! d 
  finally | call cursor(startLine, startCol) | endtry
endfunction

function! misc#replaceRange(range, content)
  let [startLine, startCol, paste, rbak]= [line('.'), col('.'), &paste, @t] | try
    let [&paste, @t]= [1, a:content]
    call misc#visualSelect(a:range) 
    silent normal! "tp 
  finally | call cursor(startLine, startCol)| let [&paste, @t] = [paste, rbak] | endtry
endfunction

"return new trimed range
function! misc#trimRange(range)
  let [startLine, startCol]= [line('.'), col('.')] | try
    let newRange = deepcopy(a:range)

    call cursor(a:range[0])
    if match(" \t", misc#getCC()) != -1|call search('\v\S')|endif
    let newRange[0] = [line('.'), col('.')]

    call cursor(a:range[1])
    if match(" \t", misc#getCC()) != -1|call search('\v\S', 'bW')|endif
    let newRange[1] = [line('.'), col('.')]

    return newRange
  finally | call cursor(startLine, startCol) | endtry
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
" @param1 {"option":value}
" @return :
""
function! misc#startScript(desc, ...)

  let s:scriptTimer = reltime()
  let opts = get(a:000, 0, {"more":0, "eventignore":"all"})
  "set option, create back up
  let s:oldOpts = {}
  for [key,value] in items(opts)
    exec 'let s:oldOpts[key] = &'.key
    exec 'let &'.key . ' = value'
  endfor

  echom "**********************************************************************"
  echom a:desc
endfunction!

""
" echom ******
" @param1 msg{String}: msg to print
" @return :
""
function! misc#endScript()
  echom "Done in " . reltimestr(reltime(s:scriptTimer)) . " seconds"
  echom "**********************************************************************"
  for [key,value] in items(s:oldOpts)
    exec 'let &'.key.' = value '
  endfor
endfunction!

function! misc#openScript(file)
  "if bufexists(a:file)
    "throw a:file . " exists in buffer, it should not happen"
  "endif
  silent execute 'edit ' . a:file
  setl noswapfile nobuflisted
  setl bufhidden=unload
  setl autowriteall
endfunction


""
" Get sid of specified plugin file.
" @param fileName : plugin filename
" @return : sid or '' if not found
""
function! misc#getSid(fileName)
  let temp = @t|execute 'redir @t'
  try
    let plugfile = fnamemodify(a:fileName , ':p')
    let plugfile = plugfile[stridx(plugfile, '.'):]
    silent execute 'scriptnames'
    "becareful string is different from file
    let sid = matchstr(@t, '\v\zs\d+\ze:[^:]+' . escape(plugfile, '.'))
    if empty(sid)
      throw a:fileName . ' not found'
    endif	
  finally
    let @t = temp|execute 'redir End'|return sid
  endtry
endfunction

function! misc#isNumber(e)
  return type(a:e) == 0
endfunction
function! misc#isString(e)
  return type(a:e) == 1
endfunction
function! misc#isFuncref(e)
  return type(a:e) == 2
endfunction
function! misc#isList(e)
  return type(a:e) == 3
endfunction
function! misc#isDict(e)
  return type(a:e) == 4
endfunction
function! misc#isFloat(e)
  return type(a:e) == 5
endfunction

""
" If name doesn't exists, let name = value, only work for number and string.
" @param name : variable name
" @param value : variable value
""
function! misc#addCfgVar(name, value)
  if !exists(a:name)
    execute 'let '.a:name.' = a:value'
  endif
endfunction

""
" @param c : check if c belongs to A-Z
" @return : 0 or 1
""
function! misc#isUpperCase(c)
  let nr = char2nr(a:c)
  return nr >= 0x41 && nr <= 0x5a
endfunction

""
" @param c : check if c belongs to a-z
" @return : 0 or 1
""
function! misc#isLowerCase(c)
  let nr = char2nr(a:c)
  return nr >= 0x61 && nr <= 0x7a
endfunction

function! misc#getTail(str, delim)
  let idx = strridx(a:str, a:delim)
  return idx >= 0 ? a:str[(idx+len(a:delim)):] : a:str
endfunction

""
" param0 [[lnum0,cnum0][lnum1,cnum1]] or [lnum0,cnum0] or lnum0
" param1 [lnum1,cnum1] or cnum0
" param2 lnum1
" param3 cnum1
" @return :
""
function! misc#getFragment(...)
  if a:0 == 4 && misc#isNumber(a:1)
    let [lnum0,cnum0,lnum1,cnum1] = a:000
  elseif a:0 == 2 && misc#isList(a:1)
    let [lnum0,cnum0] = a:1
    let [lnum1,cnum1] = a:1
  elseif a:0 == 1 && misc#isList(a:1)
    let [lnum0,cnum0] = a:1[0]
    let [lnum1,cnum1] = a:1[1]
  else
    throw "illigal args, it should be [[lnum,cnum][lnum,cnum]] or [lnum,cnum],[lnum,cnum]
          \ or lnum0, cnum0, lnum1, cnum1 "
  endif

  let fragment = getline(lnum0, lnum1)
  if len(fragment) == 0
    let x = 5
  endif
  "becareful here, last fragment must be picked first, it will break cnum1 if
  "if lnum0 = lnum1
  let fragment[-1] = fragment[-1][: cnum1 - 1]
  let fragment[0] = fragment[0][cnum0 - 1:]
  return fragment
endfunction

function! misc#visualSelect(...)
  if a:0 == 4 && misc#isNumber(a:1)
    let [lnum0,cnum0,lnum1,cnum1] = a:000
  elseif a:0 == 2 && misc#isList(a:1)
    let [lnum0,cnum0] = a:1
    let [lnum1,cnum1] = a:2
  elseif a:0 == 1 && misc#isList(a:1)
    let [lnum0,cnum0] = a:1[0]
    let [lnum1,cnum1] = a:1[1]
  else
    throw "illigal args, it should be [[lnum,cnum][lnum,cnum]] or [lnum,cnum],[lnum,cnum]
          \ or lnum0, cnum0, lnum1, cnum1 "
  endif

  call cursor(lnum0, cnum0)
  "don't know why '< failed to be sett by cursor, have to do it again by setpos
  call setpos("'<",[0,lnum0,cnum0,0])
  normal! v
  call cursor(lnum1, cnum1)
  call setpos("'>",[0,lnum1,cnum1,0])
endfunction

""
" trim string
" @param s : string to be trim
" @param1 noLeft{bool}  : don't trim left
" @param2 noRight{bool} : don't trim right
" @return : trimed string
""
function! misc#trim(s, ...)
  let noLeft = a:0 >= 1 && a:1
  let noRight = a:0 >= 2 && a:2
  let res = a:s
  if !noLeft|let res = matchstr(res, '\v^\s*\zs.*')|endif
  if !noRight|let res = matchstr(res, '\v.{-}\ze\s*$')|endif
  return res
endfunction

"\w and \d only
function! misc#selectSmallWord()
  let c = misc#getCC()
  if match(c, '\v\w') == -1
    "do nothing if c is not a \w
    return -1 
  endif

  call misc#charForward()
  call search('\v\w*', 'bW')  " don't add flag e to ?
  normal! v
  call search('\v\w*', 'e')  " \w+ will jump to next word if it's a single letter

  "check tail character
  let c = misc#getCC()
  if match(c, '\v\w') == -1
    "TODO this doesn't work if whol match is a single character, don't know y
    call misc#charBackward()
  endif

endfunction

" lnum, cnum
function! misc#isSingleWord(...)
  let [startLine, startCol]= [line('.'), col('.')] | try
  let lnum = get(a:000, 0, line('.'))
  let cnum = get(a:000, 1, col('.'))
  call cursor(lnum, cnum)
  let w = expand('<cword>')
  return len(w) == 1
  finally |  call cursor(startLine, startCol) | endtry
endfunction

function! misc#searchDo(pattern, flag, func, ...)
  while(search(a:pattern, a:flag))
    call call(a:func, a:000)
  endwhile
endfunction

" ------------------------------------------------------------------------------
" chrono 
" ------------------------------------------------------------------------------
let misc#chrono = { "time":reltime()}
function misc#chrono.reset() dict
  let self.time = reltime()
endfunction

function! misc#chrono.get() dict
  return reltimestr(reltime(self.time))   
endfunction

function! misc#newChrono()
  return deepcopy(g:misc#chrono) 
endfunction
