" expand history or wildmenu
function! misc#hist#expand(expand_wild) abort

  let cs = s:parse_cmdline(getcmdline(), getcmdtype(), getcmdpos())
  call misc#log#debug(printf('parse cmdline into : %s', string(cs)))

  if cs.expansion_type ==# ''
    if a:expand_wild
      call s:expand_wildmenu()
    endif
    return cs.text
  endif

  return s:expand_history(cs)
endfunction

" return command structure:
" {
"   text:
"   pos:
"   type:
"   pre:
"   cur:
"   post:
"   expansion_type:
"
"   extra property if expansion_type is ^:
"   string1:
"   string2:
"   modifier:
"
"   extra property if expansion_type is !:
"   event:
"   word:
"   modifier:
" }
"
function! s:parse_cmdline(text, type, pos) abort
  let cs = s:split_command(a:text, a:type, a:pos)
  call s:parse_designator(cs)
  return cs
endfunction

" setup event, word, modifier for !
" setup string1, string2, modifier for ^
function! s:parse_designator(cs) abort

  let l = matchlist(a:cs.cur, printf('\v^\^(.*)\^(.*)\^(\:\w+)?$'))
  if len(l) >= 4
    " ^string1^string2^:modifier
    let a:cs.expansion_type = '^'
    let [ a:cs.string1, a:cs.string2, a:cs.modifier ] = l[1:3]
  elseif a:cs.cur =~# '\v^\!\S+$'
    " !
    let a:cs.expansion_type = '!'
    let [ a:cs.event, a:cs.word, a:cs.modifier ] = s:split_designator(a:cs.cur)
  else
    let a:cs.expansion_type = ''
  endif

endfunction

function! s:expand_wildmenu() abort
  " 'wildcharm' also works if it's not 0, 't' is not needed for 'wildcharm'
  call feedkeys(nr2char(&wildchar), 'nt')
endfunction

" return
" {
"   text:
"   pos:
"   type:
"   pre:
"   cur:
"   post:
" }
"
" text = pre....cur|post, cur has no blank
function! s:split_command(text, type, pos) abort

  let cs = {'text':a:text, 'type':a:type, 'pos':a:pos, 'pre':'', 'cur':'', 'post':''}

  let [cs.pre, cs.post] = [a:text[0:a:pos-2], a:text[a:pos-1:]]
  let l = matchlist(cs.pre, '\v^(.{-})(\S+)$')
  if len(l) > 0
    let [cs.pre, cs.cur] = l[1:2]
  endif
  return cs
endfunction

function! s:get_reverse_hist(cmdtype) abort
  " there has not built in method to get history list, don't like explicit loop
  let hist = reverse(split(execute('hist ' . a:cmdtype), "\n"))
  " remove leading > and index.
  return map(hist, {i,v->substitute(v, '\v^\>?\s*\d+\s*', '', '')})
endfunction

function! s:split_designator(designator) abort

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
function! s:update_string_search(s, cmdtype) abort
  let s:d = get(s:, 'd', {})
  let s:d[a:cmdtype] = a:s
endfunction

" get most recent !?
function! s:get_string_search(cmdtype) abort
  let s:d = get(s:, 'd', {})
  return get(s:d, a:cmdtype, '')
endfunction

function! s:expand_event(cs) abort
  if a:cs.event !~# '\v^\!.+'
    throw 'illegal event : ' . a:cs.event
  endif

  let n = a:cs.event[1:]
  if n =~# '\v^\d+$' " !n
    return histget(a:cs.type, n)
  elseif n =~# '\v^\-\d+$' " !-n
    return histget(a:cs.type, n)
  elseif n ==# '!' " !!
    return histget(a:cs.type, -1)
  elseif n ==# '#' " !#
    return a:cs.pre
  elseif n =~# '\v^[^?].*' "!string
    let hist = s:get_reverse_hist(a:cs.type)
    let index = match(hist, printf('\V\^%s', escape(n, '\')))
    return index == -1 ? a:cs.event : hist[index]
  elseif n =~# '\v^\?.+' "!?string[?]
    let s = matchstr(n, '\v\?\zs.{-}\ze\??$')
    let hist = s:get_reverse_hist(a:cs.type)
    let index = match(hist, printf('\V%s', escape(s, '\')))
    return index == -1 ? a:cs.event : hist[index]
  endif

  return ''
endfunction

function! s:get_words(words, start, ...) abort
  let end = get(a:000, 0, a:start)
  let num_words = len(a:words)
  return a:start > end || end >= num_words ? '' : join(a:words[a:start : end], ' ')
endfunction

function! s:expand_word(cs, s) abort
  if empty(a:s)
    throw 'empty string'
  endif

  let word = a:cs.word
  if empty(word)
    throw 'empty word'
  endif

  let cmd_words = split(a:s, '\v\s+')
  let num_words = len(cmd_words)

  if word =~# '\v^\d+$' " 0, n
    return s:get_words(cmd_words, word)
  elseif word ==# '^' " ^
    return s:get_words(cmd_words, 1)
  elseif word ==# '$' " $
    return s:get_words(cmd_words, num_words - 1)
  elseif word ==# '%' " %
    return s:get_string_search(a:cs.type)
  elseif word =~# '\v^\d+\-\d+$' " x-y
    let [start, end] = split(word, '\v\-')
    return s:get_words(cmd_words, start, end)
  elseif word ==# '*' " *
    return s:get_words(cmd_words, 1, num_words - 1)
  elseif word =~# '\v^\d+\*$' " x*
    return s:get_words(cmd_words, word, num_words - 1)
  elseif word =~# '\v^\d+\-$' " x-
    return s:get_words(cmd_words, word, num_words - 2)
  endif

  return ''

endfunction

function! s:expand_modifier(cs, s) abort
  return a:cs
endfunction

function! s:rebuild_command(cs, expansion)
  if a:cs.pos <= len(a:cs.text)
    call setcmdpos(len(a:cs.pre) + len(a:expansion) + 1)
  endif
  return a:cs.pre . a:expansion . a:cs.post
endfunction

function! s:expand_history(cs) abort
  return a:cs.expansion_type ==# '!' ? s:expand_exclamation(a:cs) : s:expand_hat(a:cs)
endfunction

function! s:expand_exclamation(cs) abort
  let s = s:expand_event(a:cs)
  call misc#log#debug(printf('expand event to %s', s))

  if !empty(s) && !empty(a:cs.word)
    let s = s:expand_word(a:cs, s)
    call misc#log#debug(printf('expand word to %s', s))
  endif

  if !empty(s) && !empty(a:cs.modifier)
    let s = s:expand_modifier(a:cs, s)
    call misc#log#debug(printf('expand modifier to %s', s))
  endif

  return s:rebuild_command(a:cs, s)
endfunction

function! s:expand_hat(cs) abort
  let estring = substitute(a:cs.text,
        \ printf('\V%s', escape(a:cs.string1, '\')), a:cs.string1, 'g')
  return s:rebuild_command(a:cs, estring)
endfunction
