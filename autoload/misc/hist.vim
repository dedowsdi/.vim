" expand history or wildmenu
function! misc#hist#expand(expand_wild) abort
  let cmdline = getcmdline()
  let cmdtype = getcmdtype()
  let parts = s:split_cmdline(cmdline, getcmdpos())
  call misc#log#debug(printf('split cmdline into : %s', join(parts, '|')))
  let type = parts[0]

  if type == ''
    if a:expand_wild
      call s:expand_wildmenu()
    endif
    return cmdline
  endif

  " deal with special case : ^string1^string2^
  if type ==# '^'
    let [pre, string1, string2, post] = parts[1:4]
    let estring = substitute(histget(cmdtype, -1),
          \ printf('\V%s', escape(string1, '\')), string2, 'g')
    if getcmdpos() <= len(cmdline)
      call setcmdpos(len(pre) + len(estring) + 1)
    endif
    return pre . estring . post
  endif

  " !* stuff
  let [pre, curr, post] = parts[1:3]
  let ecurr = s:expand(curr, cmdtype)
  if getcmdpos() <= len(cmdline)
    call setcmdpos(len(pre) + len(ecurr) + 1)
  endif
  return pre . ecurr . post
endfunction

function! s:expand_wildmenu() abort
  " 'wildcharm' also works if it's not 0, 't' is not needed for 'wildcharm'
  call feedkeys(nr2char(&wildchar), 'nt')
endfunction

" return one of:
"   ["!", pre, cur, post]
"   ["^", pre, string1, string2, post]
"   ["", pre, post]
function! s:split_cmdline(cmdline, cmdpos) abort
  let [pre, post] = [a:cmdline[0:a:cmdpos-2], a:cmdline[a:cmdpos-1:]]

  " !*
  let l = matchlist(pre, printf('\v^(.{-})(\!\S+)$'))
  if len(l) >= 3
    return ['!'] + l[1:2] + [post]
  endif

  "^string1^string2^
  let l = matchlist(pre, printf('\v^(.{-})\^(.*)\^(.*)\^$'))
  if len(l) >= 4
    return ['^'] + l[1:3] + [post]
  endif

  return [''] + [pre, post]
endfunction

function! s:get_reverse_hist(cmdtype) abort
  " there has not built in method to get history list, don't like explicit loop
  let hist = reverse(split(execute('hist ' . a:cmdtype), "\n"))
  " remove leading > and index.
  return map(hist, {i,v->substitute(v, '\v^\>?\s*\d+\s*', '', '')})
endfunction

function! s:expand(designator, cmdtype) abort
  let n = a:designator[1:]
  if n =~# '\v^\d+$' " !n
    return histget(':', n)
  elseif n =~# '\v^\-\d+$' " !-n
    return histget(':', n)
  elseif n ==# '!' " !!
    return histget(':', -1)
  elseif n ==# '#' " !#
    return substitute(getcmdline(), '\V!#', '', 'g')
  elseif n =~# '\v^[^?].*' "!string
    let hist = s:get_reverse_hist(a:cmdtype)
    let index = match(hist, printf('\V\^%s', escape(n, '\')))
    return index == -1 ? a:designator : hist[index]
  elseif n =~# '\v^\?.+' "!?string[?]
    let s = matchstr(n, '\v\?\zs.{-}\ze\??$')
    let hist = s:get_reverse_hist()
    let index = match(hist, printf('\V%s', escape(s, '\')))
    return index == -1 ? a:designator : hist[index]
  endif

  return a:cmd
endfunction
