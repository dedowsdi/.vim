"""""""""""""""""""""""""""""""""""""
"  Language:ogre2 hlms glsl         "
"""""""""""""""""""""""""""""""""""""

if exists("b:current_syntax")
  finish
endif

runtime! syntax/glsl.vim
unlet b:current_syntax
runtime! syntax/hlms_template.vim
