function! misc#warn(mes) abort
  echohl WarningMsg | echom a:mes | echohl None
endfunction

" a hack, maybe i should do it in another way
function! misc#hasjob(job) abort
  try
    call jobpid(a:job) | return 1
  catch /^Vim\%((\a\+)\)\=:E900/ " catch error E900
    return 0
  endtry
endfunction

" check if quickfix window is open
"function! misc#isQfListOpen() abort
  "for i in range(1, winnr('$'))
    "let bufnr = winbufnr(i)
    "if getbufvar(bufnr, '&buftype') ==# 'quickfix'
      "return 1
    "endif
  "endfor
  "return 0
"endfunction

" is this necessary?
function! misc#open(file) abort
  let nr = bufnr(a:file)
  if nr != -1
    exec printf('buffer %d', nr)
  else
    exec printf('edit %s', a:file)
  endif
endfunction

" return [0,1), it's time based, it's awful.
function! misc#rand_by_time() abort
  " there are 6 digits after . of reltimestr
  return str2nr(matchstr(reltimestr(reltime()), '\v\.\zs\d+')[1:]) / 100000.0
endfunction

let s:rndm_m1 = 32007779 + (localtime()%100 - 50)
let s:rndm_m2 = 23717810 + (localtime()/86400)%100
let s:rndm_m3 = 52636370 + (localtime()/3600)%100

" copied from https://github.com/posva/Rndm
function! misc#rand()
    let m4= s:rndm_m1 + s:rndm_m2 + s:rndm_m3
    if( s:rndm_m2 < 50000000 )
        let m4= m4 + 1357
    endif
    if( m4 >= 100000000 )
        let m4= m4 - 100000000
        if( m4 >= 100000000 )
            let m4= m4 - 100000000
        endif
    endif
    let s:rndm_m1 = s:rndm_m2
    let s:rndm_m2 = s:rndm_m3
    let s:rndm_m3 = m4
    "return s:rndm_m3
    return s:rndm_m3 / 100000000.0
endfun

function! misc#getC(lnum, cnum) abort
  return matchstr(getline(a:lnum), '\%' . a:cnum . 'c.')
endfunction
function! misc#getCC() abort
  return misc#getC(line('.'), col('.'))
endfunction

function! misc#getV(lnum, vnum) abort
  return matchstr(getline(a:lnum), '\%' . a:vnum . 'v.')
endfunction
function! misc#getVV() abort
  return misc#getV(line('.'), col('.'))
endfunction

" search until one of expr found, ignore everything in pairs, doesn't include
" current character
" jumpPairs and expr should be completely different
" expr : desired pattern
" jumpPairs : such as (<{[ or )>}], when meet, execute %
function! misc#searchOverPairs(expr, jumpPairs, flags) abort

  let searchExpr = '\v[' . a:expr . escape(a:jumpPairs, ']') . ']'
  " c in flags will be used only for the 1st time search.
  let [firstTime, flags] = [1, a:flags]
  while search(searchExpr, flags)
    if firstTime
      let firstTime = 0
      let flags = substitute(flags, 'c', '', 'g')
    endif
    if stridx(a:expr, misc#getCC()) != -1
      return 1
    else
      keepjumps normal! %
    endif
  endwhile
  return 0

endfunction

function! misc#visualSelect(range, mode) abort
  call setpos('.', a:range[0]) | exec 'normal! ' . a:mode | call setpos('.', a:range[1])
endfunction

function! misc#swapRange(range0, range1, mode) abort
  if misc#cmpPos(a:range0[0], a:range1[0]) < 0
     let [leftRange, rightRange] = [a:range0, a:range1]
  else
     let [leftRange, rightRange] = [a:range1, a:range0]
  endif

  " replace right rangre 1st, otherwise left range will be corrupted
  let tmp = misc#getRange(rightRange, a:mode)
  call misc#replaceRange(rightRange, misc#getRange(leftRange, a:mode), a:mode)
  call misc#replaceRange(leftRange, tmp, a:mode)
endfunction

function! misc#getRange(range, mode) abort
  return misc#getPosStrng(a:range[0], a:range[1], a:mode)
endfunction

function! misc#replaceRange(range, content, mode) abort
  let [cursorPos, paste, regText, regType]= [getcurpos(), &paste, @a, getregtype('a')]
  try
    let [&paste, @a]= [1, a:content]
    call misc#visualSelect(a:range, a:mode)
    silent normal! "ap
  finally
    call setpos('.', cursorPos) | let &paste = paste | call setreg('a', regText, regType)
  endtry
endfunction

"return new trimed characterwise range
function! misc#trimRange(range) abort
  let pos = getcurpos() | try
    let newRange = deepcopy(a:range)

    call setpos('.', a:range[0]) | call search('\v\S', 'cW') | let newRange[0] = getpos('.')
    call setpos('.', a:range[1]) | call search('\v\S', 'bcW') | let newRange[1] = getpos('.')

    return newRange
  finally | call setpos('.', pos) | endtry
endfunction

function! misc#cmpPos(lhs, rhs) abort
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

function! misc#translatePos(pos, step) abort
  let [startLine, startCol]= [line('.'), col('.')] | try
    call cursor(a:pos)
    if(a:step < 0)
      call misc#charLeft(-a:step)
    else
      call misc#charRight(a:step)
    endif
    return getpos('.')[1:2]
  finally | call cursor(startLine, startCol) | endtry
endfunction

function! misc#charRight(...) abort
  let step = get(a:000, 0, 1)
  " are there any option the same as backspace ?
  exec 'normal! '.step.' '
endfunction

function! misc#charLeft(...) abort
  let step = get(a:000, 0, 1)
  let backspace = &backspace|try
    let &backspace='indent,eol,start' 
    exec 'normal! '.step.''
  finally|let &backspace = backspace|endtry
endfunction

function! misc#trim(s, ...) abort
  let noLeft = get(a:000, 0, 0)
  let noRight = get(a:000, 1, 0)
  let res = a:s
  if !noLeft|let res = matchstr(res, '\v^\s*\zs.*')|endif
  if !noRight|let res = matchstr(res, '\v.{-}\ze\s*$')|endif
  return res
endfunction

"add lnum, cnum to jump list
function! misc#createJumps(lnum,cnum) abort
  let [startLine, startCol]= [line('.'), col('.')] | try
    let oldpos = getpos('.')

    call cursor(a:lnum, a:cnum)
    normal! m'

  finally
    call setpos('.', oldpos)
  endtry
endfunction

function! misc#synstack()
  if !exists('*synstack') | return | endif
  return map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" copy last visual without side effect. Won't work for <c-v>$
function! misc#getVisualString() abort
  return misc#getMarkString("'<", "'>", visualmode())
endfunction

function! misc#getMarkString(m0, m1, vmode)
  return misc#getPosString(getpos(a:m0), getpos(a:m1), a:vmode)
endfunction

function! misc#getPosString(p0, p1, vmode)
  let [lnum1, col1] = a:p0[1:2]
  let [lnum2, col2] = a:p1[1:2]
  let lines = getline(lnum1, lnum2)
  if a:vmode =~# "\<c-v>"
    let lines = map(lines, 'v:val[col1-1 : col2-1]')
  elseif a:vmode ==# 'V'
    let lines[-1] .= "\n"
  else
    let lines[-1] = lines[-1][:col2 - 1]
    let lines[0] = lines[0][col1 - 1:]
  endif
  return join(lines, "\n")
endfunction

function! misc#literalizeVim(str)
    return '\V' . substitute(escape(a:str, '\'), '\n', '\\n', 'g')
endfunction

function! misc#literalizeGrep(str)
  let s = substitute(a:str, "'", "'\\\\''", 'g')
  return printf("'%s'", escape(s, '%#|'))
endfunction

function! misc#switchRtp(path) abort
  if !has_key(s:, 'originalRtp') | let s:originalRtp = &rtp | endif
  let &rtp = printf('%s,%s,%s', s:originalRtp, a:path, a:path.'/after')
endfunction

function! s:getHelpFile(tag) abort
  let throwMsg=''
  try
    let tagsBak = &tags
    let &tags = $VIMRUNTIME . '/doc/tags'
    let l = taglist('\V\C\^' . escape(a:tag, '\') . '\$')

    " very weird, if i combime throw and if to one line, it doesn't throw ...
    if empty(l)
      throw a:tag . ' not found'
    endif
    if len(l) > 1
      throw 'multiple tags found : ' . string(l)
    endif
    return fnamemodify(l[0].filename, ':t')
  finally
    let &tags = tagsBak
  endtry
endfunction

function! misc#createVimhelpLink(tag) abort
  let anchor = substitute(a:tag, '[^a-zA-Z_\-]',
        \ '\=printf("%%%2X", char2nr(submatch(0)))', 'g')
  return 'https://vimhelp.org/' . s:getHelpFile(a:tag) . '.html#' . anchor
endfunction

function! misc#createNvimhelpLink(tag) abort
  return 'https://neovim.io/doc/user/' .
        \ fnamemodify(s:getHelpFile(a:tag), ':r') . '.html#' . a:tag
endfunction

" 0 vim
" 1 nvim
function! misc#updateLink(type) abort
  " clear link, delete \ before [ or ] in link clause
  %s/\v\[\s*(\:h(elp)?\s*\S+)\]\s*\[\d+\]/\=substitute(submatch(1), '\v\\\ze[\[\]]','','g')/ge
  g/\v^\[\d+\]\s*\:\s*http.*$/d

  let linkDict = {}
  let [regText, regType] = [@", getregtype('"')]
  let pasteBack = &paste
  " avoid auto wrap if line exceeds textwidth
  set paste
  try
    let idx = 1 | norm! gg
    let @/ = '\v\:h(elp)?\s+\S+'
    while search(@/, 'Wc')
      norm! ygn
      let tag = matchstr(@", '\v\S+$')
      " escape [ and ]
      let linkText = substitute(@", '\v[\[\]]', '\\\0', 'g')
      let linkIdx = has_key(linkDict, tag) ? linkDict[tag] : idx
      exec printf('norm! cgn[%s][%d]', linkText, linkIdx)
      if has_key(linkDict, tag) | continue | endif
      let link = a:type == 0 ?
            \ misc#createVimhelpLink(tag) : misc#createNvimhelpLink(tag)
      let link = printf('[%d]:%s', idx, link)
      call append(line('$'), link)
      let linkDict[tag] = idx
      let idx += 1
    endwhile
  finally
    call setreg('"', regText, regType)
    let &paste = pasteBack
  endtry
endfunction
