function! s:split_cmd()

  " split cmdline into 3 parts
  let matches = matchlist(getcmdline(),
        \ printf('\v^(.*)(%%%dc\s*\S+)(.*)', getcmdpos()))
  return len(matches) < 4 ? ['','','', 0] : matches[1:3] + [1]
endfunction

function! s:word_case(up)
  let [pre, word, post, valid] = s:split_cmd()
  if !valid | return | endif
  call setcmdpos(len(pre) + len(word) + 1)
  return pre . (a:up ? toupper(word) : tolower(word)) . post
endfunction

function! s:forward_delete()
  let [pre, word, post, valid] = s:split_cmd()
  if !valid | return | endif
  call setcmdpos(len(pre) + 1)
  return pre . post
endfunction

cnoremap <c-a> <c-b>
cnoremap <a-a> <c-a>
cnoremap <a-k> <c-\>e(getcmdpos() == 1 ? '' : getcmdline()[0:getcmdpos()-2])<cr>
cnoremap <a-u> <c-\>e<sid>word_case(1)<cr>
cnoremap <a-l> <c-\>e<sid>word_case(0)<cr>
cnoremap <a-d> <c-\>e<sid>forward_delete()<cr>
cnoremap <a-b> <c-left>
cnoremap <a-f> <c-right>
