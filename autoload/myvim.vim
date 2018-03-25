"load guard
if exists('g:loaded_myvim')
  finish
endif
let g:loaded_myvim = 1

"search regex------------------------------------------------
let s:reFuncStart = '^s*fu'
let s:reFuncEnd = '^s*endfu'

"extract regex------------------------------------------
let s:rexFuncName = '\v\zs[^ \t]+\ze\s*\(.*\)'
let s:timing = 0
let s:timeText = ''
let s:optionStack = []
let s:blockFile = system('mktemp /tmp/myvim_block_XXXXXX')[0:-2]

function! myvim#getSid(fileName) abort
  let temp = @t|execute 'redir @t'
  try
    silent execute 'scriptnames'
    "becareful string is different from file
    let sid = matchstr(@t, printf('\v\zs\d+\ze:[^:]+%s%(\n|$)', escape(a:fileName, '.%~+-\')))
    if empty(sid)
      throw a:fileName . ' not found'
    endif	
  finally
    let @t = temp|execute 'redir End'|return sid
  endtry
endfunction

" reserve ~
function! myvim#filename() abort
  return substitute(@%, '\V\^'.expand('~'), '~', '')
endfunction

" break at current line in current function, doesn't work if it's a dict
" [funcName [,line, [,plugFileName]]]
function! myvim#breakFunction() abort
  let [startLine, startCol] = [line('.'), col('.')]|try
    if myvim#gotoFunction()
      let funcName = matchstr(getline('.'), s:rexFuncName)
      let breakLine = startLine - line('.')
      if myvim#isScopeScript()
        "add <SNR>SID_ prefix
        let plugFileName = myvim#filename()
        let funcName = '<SNR>'.myvim#getSid(plugFileName).'_'.funcName[2:]
      endif
    else
      echoe 'function not found'
    endif

    execute 'breakadd func ' . breakLine . ' ' . funcName
  finally|call cursor(startLine, startCol)|endtry
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

function! myvim#isScopeScript() abort
  return stridx(getline('.'), 's:') >= 0
endfunction

" [lnum]
function! myvim#gotoFunction(...) abort
  let oldpos = getpos('.')
  let lnum = get(a:000, 0, 0)

  normal! $
  if search(s:reFuncStart, 'bW')
      if lnum == 0 | return 1 | endif
      execute 'normal! '. lnum .'j'
      return 1
  endif

  return 0
endfunction

function! myvim#getFuncBlock() abort
  let [startLine, startCol] = [line('.'), col('.')]|try
    if myvim#gotoFunction()
      let funcStartLine = startLine
      if search(s:reFuncEnd, 'W')
        return [funcStartLine, line('.')]
      else
        throw 'function end not found!'
      endif
    endif
    return [0,0]
  finally|call cursor(startLine, startCol)|endtry
endfunction


function! myvim#scanGarbage() abort
  let re = '\v^\s*\w+\s*\='
  if search(re)
    echoe 'missing let in line ' . line('.')
  endif

  " false positive for normal! A;
  let re = '\v\;\s*%($|\|)'
  if search(re)
    echoe 'illegal semicolon in line ' . line('.')
  endif

  let re = '\v^\s*[1234567890~!@#$%^&*()_\-+={}[\]|;:'',<.>/?]'
  if search(re)
    echoe 'illegal start letter in line ' . line('.')
  endif
endfunction

function! myvim#warn(mes) abort
  echohl WarningMsg | echom a:mes | echohl None
endfunction

" a hack, maybe i should do it in another way
function! myvim#hasjob(job) abort
  try | call jobpid(a:job)
    return 1
  catch /^Vim\%((\a\+)\)\=:E900/	" catch error E900
    return 0
  endtry
endfunction

" check if quickfix window is open
function! myvim#qfixexists() abort
  for i in range(1, winnr('$'))
    let bufnr = winbufnr(i)
    if getbufvar(bufnr, '&buftype') ==# 'quickfix'
      return 1
    endif
  endfor
  return 0
endfunction

function! myvim#isUppercase(s) abort
  let re = '\v^\C[A-Z_0-9]+$'
  return match(a:s, re) == 0
endfunction

function! myvim#isLowercase(s) abort
  let re = '\v^\C[a-z_0-9]+$'
  return match(a:s, re) == 0
endfunction

function! myvim#open(file)
  let nr = bufnr(fnamemodify(a:file, ':p'))
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

function! myvim#countLines(file) abort
  let s = system('wc -l ' . a:file)
  return s[0 : stridx(s, ' ') - 1]
endfunction

" make sure 1 and only 1 trailing /
function! myvim#normDir(splitdir) abort
  if a:splitdir ==# ''|return a:splitdir|endif
  return substitute(a:splitdir, '\v//*$', '', '').'/'
endfunction

function! myvim#fileExists(file) abort
  return !empty(glob(a:file))
endfunction

function! myvim#dirExists(dir) abort
  call system('[[ -d ' . a:dir . ' ]]')  
  return !v:shell_error
endfunction

function! myvim#getCC() abort
  return matchstr(getline('.'), '\%' . col('.') . 'c.')
endfunction

function! myvim#getC(lnum, cnum) abort
  return matchstr(getline(a:lnum), '\%' . a:cnum . 'c.')
endfunction

function! myvim#sourceBlock(lnum0, lnum1) abort
  exec printf('%d,%dwrite! %s', a:lnum0, a:lnum1, s:blockFile)
  exec printf('source %s', s:blockFile)
endfunction

" opts{direction:'h or l' , delim: default to "," 
" jumpPairs: default to ["()","[]","{}","<>"], guard : default to "[]",
" cursorAction : 'f_to_start'(default), 'f_to_end', 'static' }
function! myvim#shiftItem(opts) abort

  let ranges = myvim#getItemRanges(a:opts)
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
  call myvim#swapRange(itemRanges[itemIndex], itemRanges[targetIndex])

  if cursorActoin !=# 'static'
     "place cursor at start of total range to avoid inner () problem
     call cursor(totalRange[0])
     "update item ranges
     let ranges = myvim#getItemRanges(a:opts)
     let targetRange = ranges[2][targetIndex]
     if cursorActoin ==# 'f_to_start'
       "place cursor at 1st non blank character in this item
       call cursor(targetRange[0])
       call myvim#charBackward()
       call search('\v\S')
     elseif cursorActoin ==# 'f_to_end'
       "place cursor at last non blank character in this item
       call cursor(targetRange[1])
       call myvim#charForward()
       call search('\v\S', 'bW')
     endif
  endif

endfunction

"return [itemIndex, [total range] [item1 range, item 2 range ....]]
"opts : {'excludeSpace':1}, itemIndex will be -1 if it can not be found(ie,
"cursor on comma or cursor on '(' or ')' )
function! myvim#getItemRanges(opts) abort

  let [startLine, startCol] = [line('.'), col('.')] | try

    let delim = get(a:opts, 'delim', ',')
    let guard = get(a:opts, 'guard', '()')
    let excludeSpace = get(a:opts, 'excludeSpace', 1)
    let jumpPairs = get(a:opts, 'jumpPairs', ['()','[]','{}','<>'])
    let [leftGuard, rightGuard] = [guard[0], guard[1]]
    let totalRange = [[0,0], [0,0]]
    let itemRanges = []

    let [leftPairs, rightPairs] = ['', '']

    for scope in jumpPairs
      let leftPairs .= scope[0]
      let rightPairs .= scope[1]
    endfor

    let c = myvim#getCC()
    "do nothing if curson under delim
    "if delim == c
      "return empty if cursor under , or ( or )
      "call myvim#warn("you should move your cursor away from delim \''.c."\'') 
      "return []
    "endif

    "goto left guard first
    if c != leftGuard
      if !myvim#searchWithJumpPair(leftGuard, rightPairs, {'direction':'h'})|return []|endif
    endif
    let totalRange[0] = [line('.'), col('.')]
    call search('\v.')
    let itemRangeStart = [line('.'), col('.')]
    call myvim#charBackward()

    "find item ranges and right guard
    while myvim#searchWithJumpPair(rightGuard.delim, leftPairs, {'direction':'l'})
      let c = myvim#getCC()
      if c == delim
        call myvim#charBackward()  " move cursor back away from ','
        let itemRanges += [[itemRangeStart, [line('.'),col('.')] ]]
        " move cursor forward away from ','
        " TODO figure out why call search('\v..', 'e') not working
        "call search('\v..', 'e')
        call myvim#charForward(2)
        let itemRangeStart = [line('.'), col('.')]
        call myvim#charBackward()  " move cursor back to  ','
      else
        let totalRange[1] = [line('.'), col('.')]
        call myvim#charBackward()  " move cursor back away from ','
        let itemRanges += [[itemRangeStart, [line('.'),col('.')] ]]
        break
      endif
    endwhile

    "find current item index
    let cursorRange = [startLine, startCol]
    let [itemIndex, size]  = [0, len(itemRanges)]
    while itemIndex != size
      let range = itemRanges[itemIndex]
      if myvim#cmpPos(range[0], cursorRange) <= 0 && myvim#cmpPos(range[1], cursorRange) >=0 
        break
      endif
      let itemIndex += 1
    endwhile

    "set itemIndex to -1 if it's invalid
    if itemIndex == len(itemRanges)|let itemIndex = -1 |endif

    "exclude space after find current item, allow current character to be space
    if excludeSpace
      for range in itemRanges
        "carefule here, don't use let range = myvim#trimRange(range)
        let trimedRange = myvim#trimRange(range) 
        let range[0] = trimedRange[0]
        let range[1] = trimedRange[1]
      endfor
    endif

    return [itemIndex, totalRange, itemRanges]

  finally | call cursor(startLine, startCol) | endtry
endfunction

"visual select cur arg, by default space included
function! myvim#selCurArg(opts) abort
  call extend(a:opts, {'excludeSpace':0}, 'keep') 
  let ranges = myvim#getItemRanges(a:opts)

  if ranges == []
    call myvim#warn('illigal range')|return
  endif

  let [itemIndex, totalRange, itemRanges] = [ranges[0], ranges[1], ranges[2]]
  if itemIndex == -1
    call myvim#warn('you should not place your cursor at ' . myvim#getCC() ) 
    return
  endif

  let curItemRange = ranges[2][ranges[0]]
  call myvim#visualSelect(curItemRange)
endfunction

" search until one of expr found, ignore everything in scope and it's %
" eg : ( ',(',  ')}]>',  {direction:h} )
function! myvim#searchWithJumpPair(expr, jumpPairs, opts) abort
  let direction = get(a:opts, 'direction', 'h') 
  let flag = direction ==# 'h' ? 'bW' : 'W'

  let searchExpr = '\v[' . a:expr . escape(a:jumpPairs, ']') . ']'

  while search(searchExpr, flag)
    let c = myvim#getCC()
    if match(a:expr, c) != -1
      return 1
    else
      keepjumps normal! %
    endif
  endwhile

  return 0
endfunction

function! myvim#swapRange(range0, range1) abort
  if myvim#cmpPos(a:range0[0], a:range1[0]) < 0
     let [leftRange, rightRange] = [a:range0, a:range1]
  else
     let [leftRange, rightRange] = [a:range1, a:range0]
  endif

	let leftItem = myvim#getRange(leftRange)
	let rightItem = myvim#getRange(rightRange)
  " replace right rangre 1st, otherwise left range will be corrupted
  call myvim#replaceRange(rightRange, leftItem)
  call myvim#replaceRange(leftRange, rightItem)
endfunction

function! myvim#getRange(range) abort
  let [startLine, startCol, bak]= [line('.'), col('.'), @t] | try
  call myvim#visualSelect(a:range)
  normal! "ty 
  let s = @t "this is needed, because @t is restored at finally clause
  return s 
  finally | let @t = bak | call cursor(startLine, startCol) | endtry
endfunction

" opts:{'ioe':'i'}
function! myvim#deleteRange(range,...) abort
  let [startLine, startCol]= [line('.'), col('.')] | try
  call myvim#visualSelect(a:range)
  normal! d 
  finally | call cursor(startLine, startCol) | endtry
endfunction

function! myvim#replaceRange(range, content) abort
  let [startLine, startCol, paste, rbak]= [line('.'), col('.'), &paste, @t] | try
    let [&paste, @t]= [1, a:content]
    call myvim#visualSelect(a:range) 
    silent normal! "tp 
  finally | call cursor(startLine, startCol)| let [&paste, @t] = [paste, rbak] | endtry
endfunction

"return new trimed range
function! myvim#trimRange(range) abort
  let [startLine, startCol]= [line('.'), col('.')] | try
    let newRange = deepcopy(a:range)

    call cursor(a:range[0])
    if match(" \t", myvim#getCC()) != -1|call search('\v\S')|endif
    let newRange[0] = [line('.'), col('.')]

    call cursor(a:range[1])
    if match(" \t", myvim#getCC()) != -1|call search('\v\S', 'bW')|endif
    let newRange[1] = [line('.'), col('.')]

    return newRange
  finally | call cursor(startLine, startCol) | endtry
endfunction

" lhs:[line, col],  etc
function! myvim#cmpPos(lhs, rhs) abort
  if len(a:lhs) == 2
    let [lnum, cnum] = [0, 1] 
  elseif len(a:lhs) == 4
    let [lnum, cnum] = [1, 2] 
  else
    call myvim#warn('unknow position') | return 0 " return 0 ?
  endif

  if a:lhs[lnum] < a:rhs[lnum]
    return -1
  elseif a:lhs[lnum] > a:rhs[lnum]
    return 1
  elseif a:lhs[cnum] < a:rhs[cnum]
    return -1
  elseif a:lhs[cnum] > a:rhs[cnum]
    return 1
  endif
  return 0
endfunction

function! myvim#translatePos(pos, step) abort
  let [startLine, startCol]= [line('.'), col('.')] | try
    call cursor(a:pos)
    if(a:step < 0)
      call myvim#charBackward(-a:step) 
    else 
      call myvim#charForward(a:step)
    endif
    return getpos('.')[1:2]
  finally | call cursor(startLine, startCol) | endtry
endfunction

"TODO handle illigal range and step
"stretch range, based on real content, set step to negative to shink it
function! myvim#stretchRange(range, step) abort
  return [myvim#translatePos(a:range[0], -a:step), myvim#translatePos(a:range[1], a:step)]
endfunction

function! myvim#charForward(...) abort
  let step = get(a:000, 0, 1)
  " are there any option the same as backspace ?
  exec 'normal! '.step.' '
endfunction

function! myvim#charBackward(...) abort
  let step = get(a:000, 0, 1)
  let backspace = &backspace|try
    let &backspace='indent,eol,start' 
    exec 'normal! '.step.''
  finally|let &backspace = backspace|endtry
endfunction

function! myvim#startTimer(desc) abort
  if s:timing | call myvim#endTimer() | endif
  let s:scriptTimer = reltime()
  let s:timeText = a:desc
  let s:timeing = 1
endfunction

function! myvim#endTimer() abort
  if !s:timing
    echom s:timeText.' Done in '.reltimestr(reltime(s:scriptTimer)).' seconds'
    let s:timeing = 0
  endif
endfunction

" push original settings into stack, apply options in opts
function! myvim#pushOptions(opts) abort
  "let opts =  {'more':0, 'eventignore':'all'}
  let backup = {}
  for [key,value] in items(a:opts)
    exec 'let backup[key] = &'.key
    exec 'let &'.key . ' = value'
  endfor
  let s:optionStack += [backup]
endfunction

function! myvim#popOptions() abort
  if empty(s:optionStack)
    throw 'nothing to pop, empty option stack'
  endif
  let opts = remove(s:optionStack, len(s:optionStack) - 1)
  for [key,value] in items(opts)
    exec 'let &'.key . ' = value'
  endfor
endfunction

function! myvim#getTail(str, delim) abort
  let idx = strridx(a:str, a:delim)
  return idx >= 0 ? a:str[(idx+len(a:delim)):] : a:str
endfunction

function! myvim#getBlock(block) abort
  let [lnum0,cnum0] = a:block[0]
  let [lnum1,cnum1] = a:block[1]
  let fragment = getline(lnum0, lnum1)
  if len(fragment) == 0
    return []
  endif
  "becareful here, last fragment must be picked first, it will break cnum1 if
  "if lnum0 = lnum1
  let fragment[-1] = fragment[-1][: cnum1 - 1]
  let fragment[0] = fragment[0][cnum0 - 1:]
  return fragment
endfunction

function! myvim#visualSelect(block) abort
  let [lnum0,cnum0] = a:block[0]
  let [lnum1,cnum1] = a:block[1]
  call cursor(lnum0, cnum0)
  "don't know why '< failed to be sett by cursor, have to do it again by setpos
  call setpos("'<",[0,lnum0,cnum0,0])
  normal! v
  call cursor(lnum1, cnum1)
  call setpos("'>",[0,lnum1,cnum1,0])
endfunction

function! myvim#trim(s, ...) abort
  let noLeft = get(a:000, 0, 0)
  let noRight = get(a:000, 1, 0)
  let res = a:s
  if !noLeft|let res = matchstr(res, '\v^\s*\zs.*')|endif
  if !noRight|let res = matchstr(res, '\v.{-}\ze\s*$')|endif
  return res
endfunction

"\w and \d only
function! myvim#selectSmallWord() abort
  let c = myvim#getCC()
  if match(c, '\v\w') == -1
    "do nothing if c is not a \w
    return -1 
  endif

  call myvim#charForward()
  call search('\v[a-zA-Z]*', 'bW')  " don't add flag e to ?
  normal! v
  call search('\v[a-zA-Z]*', 'e')  " \w+ will jump to next word if it's a single letter

  "check tail character
  let c = myvim#getCC()
  if match(c, '\v\w') == -1
    "TODO this doesn't work if whol match is a single character, don't know y
    call myvim#charBackward()
  endif

endfunction

" lnum, cnum
function! myvim#isSingleWord(...) abort
  let [startLine, startCol]= [line('.'), col('.')] | try
  let lnum = get(a:000, 0, line('.'))
  let cnum = get(a:000, 1, col('.'))
  call cursor(lnum, cnum)
  let w = expand('<cword>')
  return len(w) == 1
  finally |  call cursor(startLine, startCol) | endtry
endfunction

"move cursor up or down to search character 
"opt:{'direction':j or k, 'pat': regex pattern, 'ignoreChop' : bool,  'greedy' :
"bool }  
"return getpos() 
function! myvim#verticalSearch(...) abort
  let opt = get(a:000, 0, {})
  let opt = extend(opt, 
        \ {'direction':'j', 'pattern':'\v.', 'ignoreChop':0, 'greedy':0 }, 'keep')
  let lstep = opt.direction ==# 'j' ? 1 : -1
  let [lastValidLine, lnum, cnum] = [line('.'), line('.'), col('.')]
  while 1 
    let lnum = lnum + lstep
    let c = myvim#getC(lnum, cnum)
    if c ==# '' && !opt.ignoreChop   "shorter line
      break  
    elseif match(c, opt.pattern ) == 0 "match line
      let lastValidLine = lnum 
      if !opt.greedy | break | endif
    endif
  endwhile
  call cursor(lastValidLine, cnum)
  return getcurpos()
endfunction

"select visual end, and keep in visual mode
function! myvim#visualEnd(func, ...) abort
  let startpos = getpos("'<")
  let endpos = call(a:func, a:000)
  echo endpos
  call setpos("'>", endpos)
  normal! gv
endfunction

function! myvim#getPercentPos() abort
  keepjumps normal! %
  let pos = getcurpos()[1:2]
  keepjumps normal! %
  return pos
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

"return [[line,col],[line,col]] or []
function! myvim#getBraceBlock() abort
  try
    let oldpos = getpos('.')

    let block = [[],[]]
    normal! [{
    let block[0] = [line('.'), col('.')]
    normal! ]}
    let block[1] = [line('.'), col('.')]
    if block[0] == block[1]
      return [] 
    endif
    return block

  finally
    call setpos('.', oldpos)
  endtry
endfunction

function! myvim#getVisualString() abort
  let temp = @s | norm! gv"sy
  let [str,@s] = [@s,temp] | return str
endfunction

" type: 
"   0 : vim very no matic forward search pattern
"   1 : grep
"   2 : Fag
function! myvim#literalize(str, type)

  if a:type == 0
    " only works forward search, backward search will fail due to / ? issue
    return substitute(escape(a:str, '/\'), "\n", '\\n', 'g')
  endif

  " shellescale will escape ! and \n, but ! and \n doesn't need to be escaped in
  " a literal match. shellescape also doesn't escape |, which will cause problem
  " in ex command
  let s = substitute(a:str, "'", "'\\\\''", "g")
  if a:type == 1
    " i gusee :grep execute like !, so \n needs to be escaped
    let s = escape(s, "%#|\n")
  else
    " don't need to escape |, Fag has no -bar option 
    let s = escape(s, "%#")
  endif
  
  " wrap in ''
  return printf("'%s'", s)
endfunction

" ------------------------------------------------------------------------------
" chrono 
" ------------------------------------------------------------------------------
let myvim#chrono = { 'time':reltime()}

function! myvim#chrono.reset() abort dict 
  let self.time = reltime()
endfunction

function! myvim#chrono.get() abort dict
  return reltimestr(reltime(self.time))   
endfunction

function! myvim#newChrono() abort
  return deepcopy(g:myvim#chrono) 
endfunction
