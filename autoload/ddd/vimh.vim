function ddd#vimh#link(type, tag) abort
  if a:type == 0
    let anchor = substitute(a:tag, '[^a-zA-Z_\-]',
          \ '\=printf("%%%2X", char2nr(submatch(0)))', 'g')
    return 'https://vimhelp.org/' . s:get_help_file(a:tag) . '.html#' . anchor
  else
    return 'https://neovim.io/doc/user/' .
          \ fnamemodify(s:get_help_file(a:tag), ':r') . '.html#' . a:tag
  endif
endfunction

" 0 vim
" 1 nvim
function ddd#vimh#update_link(type) abort
  " clear link, delete \ before [ or ] in link clause
  %s/\v\[\s*(\:h(elp)?\s*\S+)\]\s*\[\d+\]/\=substitute(submatch(1), '\v\\\ze[\[\]]','','g')/ge
  g/\v^\[\d+\]\s*\:\s*http.*$/d

  let link_dict = {}
  let [reg_text, reg_type] = [@", getregtype('"')]
  let paste_back = &paste
  " avoid auto wrap if line exceeds textwidth
  set paste
  try
    let idx = 1 | norm! gg
    let @/ = '\v\:h(elp)?\s+\S+'
    while search(@/, 'Wc')
      norm! ygn
      let tag = matchstr(@", '\v\S+$')
      " escape [ and ]
      let link_text = substitute(@", '\v[\[\]]', '\\\0', 'g')
      let link_idx = has_key(link_dict, tag) ? link_dict[tag] : idx
      exec printf('norm! cgn[%s][%d]', link_text, link_idx)
      if has_key(link_dict, tag) | continue | endif
      let link = ddd#vimh#link(a:type, tag)
      let link = printf('[%d]:%s', idx, link)
      call append(line('$'), link)
      let link_dict[tag] = idx
      let idx += 1
    endwhile
  finally
    call setreg('"', reg_text, reg_type)
    let &paste = paste_back
  endtry
endfunction

function s:get_help_file(tag) abort
  let throw_msg=''
  try
    let tags_bak = &tags
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
    let &tags = tags_bak
  endtry
endfunction
