if exists('b:loaded_help_cfg')
  finish
endif
let b:loaded_help_cfg = 1

function s:buffer_tags() abort
  let tag_source = printf('readtags -t "%s" -Q ''(eq? $input "%s")'' -l',
        \ expand('%:h') . '/tags', expand('%:t') )

  " You need all there args for this to work!
  call fzf#vim#buffer_tags('', tag_source, {})
endfunction
nnoremap <buffer> <c-j> :call <sid>buffer_tags()<cr>
