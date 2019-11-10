function s:split_cmd()

  " split cmdline into 3 parts (| is cursor):
  " pre---->|   word<-----post or:
  " pre----w>|ord<-----post
  let matches = matchlist(getcmdline(),
        \ printf('\v^(.*)(%%%dc\s*\S+)(.*)', getcmdpos()))
  return len(matches) < 4 ? ['','','', 0] : matches[1:3] + [1]
endfunction

function misc#cmdline#word_case(up)
  let [pre, word, post, valid] = s:split_cmd()
  if !valid | return getcmdline() | endif
  call setcmdpos(len(pre) + len(word) + 1)
  return pre . (a:up ? toupper(word) : tolower(word)) . post
endfunction

function misc#cmdline#forward_delete()
  let [pre, word, post, valid] = s:split_cmd()
  if !valid | return | endif
  call setcmdpos(len(pre) + 1)
  return pre . post
endfunction

" an address is various pattern (optional) followed by multiple optional [+-][number]
" a blank is also a valid range
"
" a range is one address or two addresses joined by, or ;
"
" because an address might be blank, a range might also be blank, so it's
" possible that this pattern matches pure blank, be careful about this.
"
" white spaces around ranges are also included
function misc#cmdline#build_range_pattern()
  let address_atoms = [
        \ '\d+',
        \ '[.$%]',
        \ "'[a-zA-Z0-9]",
        \ '\/.{-}\/',
        \ '\?.{-}\?',
        \ '\\\?',
        \ '\\\&',
        \ '\\\&',
        \ ]
  let address_basic = printf('%%(%s)', join(address_atoms, '|'))
  let address_optional = '%(\s*%([+-]\d*)*)'
  let address_pat = printf('\v%%(\s*%s?\s*%s*)', address_basic, address_optional)

  let cmdrange_pat = printf('\v\C^%s([,;]%s)?', address_pat, address_pat)
  return cmdrange_pat
endfunction
let s:cmdrange_pat = misc#cmdline#build_range_pattern()

function misc#cmdline#get_range_text(cmdline) abort
  return matchstr(a:cmdline, s:cmdrange_pat)
endfunction

" return [line1, line2] or []
function misc#cmdline#range2lnum(range_text) abort
  try
    let cpos = getcurpos()

    " silent is used to reverse reversed command range
    exec printf('silent %s call Tech_get_range()', a:range_text)
    return [s:tech_cmdrange_line1, s:tech_cmdrange_line2]
  catch /^Vim\%((\a\+)\)\=:E20:/ " mark not set
    " "A,"B is a common source of this kind of error.
    return []
  finally
    call setpos('.', cpos)
  endtry
endfunction

function misc#cmdline#get_range(cmdline) abort
  return misc#cmdline#range2lnum( misc#cmdline#get_range_text(a:cmdline) )
endfunction

function Tech_get_range() range
  let s:tech_cmdrange_line1 = a:firstline
  let s:tech_cmdrange_line2 = a:lastline
endfunction

function misc#cmdline#is_pure_address(pattern)
  if empty(a:pattern)
    return 0
  endif

  return misc#cmdline#get_range_text(a:pattern) ==# a:pattern
endfunction

function misc#cmdline#address2lnum(address) abort

  if !misc#cmdline#is_pure_address(a:address)
    throw 'non pure address found : ' . a:address
  endif

  if a:address =~# '\v^\d+$'
    if a:address < 0 || a:address > line('$')
      throw 'invalid address : ' . a:address
    endif
    return a:address
  endif

  try
    let cpos = getcurpos()
    let old_modifiable = &modifiable
    set nomodifiable
    exec a:address
    return line('.')
  finally
    call setpos('.', cpos)
    let &l:modifiable = old_modifiable
  endtry
endfunction
