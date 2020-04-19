if exists('b:loaded_help_cfg')
  finish
endif
let b:loaded_help_cfg = 1

nnoremap <buffer> <c-j> :exe printf('Hare btag
      \ !readtags -t "%s" -Q ''(eq? $input "%s")'' -l \| cut -f1,3-',
      \ expand('%:h') . '/tags', expand('%:t') )<cr>
