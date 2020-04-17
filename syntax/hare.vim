if exists("b:current_syntax")
  finish
endif

syn match hare_all /\v^.+$/

highlight link hare_all Comment
