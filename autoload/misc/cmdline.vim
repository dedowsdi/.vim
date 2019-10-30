function! s:split_cmd()

  " split cmdline into 3 parts (| is cursor):
  " pre---->|   word<-----post or:
  " pre----w>|ord<-----post
  let matches = matchlist(getcmdline(),
        \ printf('\v^(.*)(%%%dc\s*\S+)(.*)', getcmdpos()))
  return len(matches) < 4 ? ['','','', 0] : matches[1:3] + [1]
endfunction

function! misc#cmdline#word_case(up)
  let [pre, word, post, valid] = s:split_cmd()
  if !valid | return getcmdline() | endif
  call setcmdpos(len(pre) + len(word) + 1)
  return pre . (a:up ? toupper(word) : tolower(word)) . post
endfunction

function! misc#cmdline#forward_delete()
  let [pre, word, post, valid] = s:split_cmd()
  if !valid | return | endif
  call setcmdpos(len(pre) + 1)
  return pre . post
endfunction
