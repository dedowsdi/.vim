" expand history or wildmenu
function! misc#hist#expand(expand_wild) abort
  let cmdline = getcmdline()
  let cmdtype = getcmdtype()
  let parts = s:split_cmdline(cmdline, getcmdpos())
  call misc#log#debug(printf('split cmdline into : %s', join(parts, '|')))
  let type = parts[0]

  if type ==# ''
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

function! s:split_designator(designator)

  let l = split(a:designator, ':')

  if len(l) > 3 || l[0] !~# '\v!.*'
    return ['', '', '']
  endif

  " special case where : can be omitted for word
  if l[0] =~# '\v\![^:]*[\^$*\-%]$'
    if len(l) > 2
      return ['', '', '']
    endif

    let event = l[0][0:-2]
    let word = l[0][-1:-1]
    let modifier = len(l) == 2 ? l[1] : ''
  elseif len(l) == 2
    let event = l[0]
    if l[1] =~# '\v[0-9^$*%\-]+$'
      let word = l[1]
      let modifier = ''
    else
      let word = ''
      let modifier = l[1]
    endif
  else
    let l += ['', '']
    let [event, word, modifier] = l[0:2]
  endif

  " normalize event, no single !
  if event ==# '!'
    let event = '!!'
  endif

  return [event, word, modifier]

endfunction

" record most recent !?
function! s:update_string_search(s, cmdtype)
  let s:d = get(s:, 'd', {})
  let s:d[a:cmdtype] = a:s
endfunction

" get most recent !?
function! s:get_string_search(cmdtype)
  let s:d = get(s:, 'd', {})
  return get(s:d, a:cmdtype, '')
endfunction

function! s:expand_event(event, cmdtype)
  if a:event !~# '\v^\!.+'
    throw 'illegal event : ' . a:event
  endif

  let n = a:event[1:]
  if n =~# '\v^\d+$' " !n
    return histget(a:cmdtype, n)
  elseif n =~# '\v^\-\d+$' " !-n
    return histget(a:cmdtype, n)
  elseif n ==# '!' " !!
    return histget(a:cmdtype, -1)
  elseif n ==# '#' " !#
    return substitute(getcmdline(), '\V!#', '', 'g')
  elseif n =~# '\v^[^?].*' "!string
    let hist = s:get_reverse_hist(a:cmdtype)
    let index = match(hist, printf('\V\^%s', escape(n, '\')))
    return index == -1 ? a:event : hist[index]
  elseif n =~# '\v^\?.+' "!?string[?]
    let s = matchstr(n, '\v\?\zs.{-}\ze\??$')
    let hist = s:get_reverse_hist(a:cmdtype)
    let index = match(hist, printf('\V%s', escape(s, '\')))
    return index == -1 ? a:event : hist[index]
  endif

  return ''
endfunction

function! s:get_words(words, start, ...)
  let end = get(a:000, 0, a:start)
  let num_words = len(a:words)
  return a:start > end || end >= num_words ? '' : join(a:words[a:start : end], ' ')
endfunction

function! s:expand_word(word, cmd, cmdtype) abort
  if empty(a:cmd)
    throw 'empty command'
  endif

  if empty(a:word)
    throw 'empty word'
  endif

  let cmd_words = split(a:cmd, '\v\s+')
  let num_words = len(cmd_words)

  if a:word =~# '\v^\d+$' " 0, n
    return s:get_words(cmd_words, a:word)
  elseif a:word ==# '^' " ^
    return s:get_words(cmd_words, 1)
  elseif a:word ==# '$' " $
    return s:get_words(cmd_words, num_words - 1)
  elseif a:word ==# '%' " %
    return s:get_string_search(a:cmdtype)
  elseif a:word =~# '\v^\d+\-\d+$' " x-y
    let [start, end] = split(a:word, '\v\-')
    return s:get_words(cmd_words, start, end)
  elseif a:word ==# '*' " *
    return s:get_words(cmd_words, 1, num_words - 1)
  elseif a:word =~# '\v^\d+\*$' " x*
    return s:get_words(cmd_words, a:word, num_words - 1)
  elseif a:word =~# '\v^\d+\-$' " x-
    return s:get_words(cmd_words, a:word, num_words - 2)
  endif

  return ''

endfunction

function! s:expand_modifier(modifier, cmd) abort
  return a:cmd
endfunction

" return designator if designator is invalid
function! s:expand(designator, cmdtype) abort

  let [event, word, modifier] = s:split_designator(a:designator)
  call misc#log#debug(printf(
        \ 'split designator "%s" into event : %s, word : %s, modifier : %s',
        \ a:designator, event, word, modifier) )

  if empty(event)
    return a:designator
  endif

  let s = s:expand_event(event, a:cmdtype)
  call misc#log#debug(printf('expand event to %s', s))

  if !empty(s) && !empty(word)
    let s = s:expand_word(word, s, a:cmdtype)
    call misc#log#debug(printf('expand word to %s', s))
  endif

  if !empty(s) && !empty(modifier)
    let s = s:expand_modifier(modifier, s)
    call misc#log#debug(printf('expand modifier to %s', s))
  endif

  return s
endfunction
