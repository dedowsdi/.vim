if exists("g:loaded_misc_re")
  finish
endif

function! re#glue(...)
  return join(a:000, '|')
endfunction

let g:loaded_misc_re = 1

let re#trailing_space='\v\s+$'
let re#consecutive_blank_lines='\v%(^\s*\n){2,}'
let re#blank_lines='\v^\s*$'

let re#code_garbage=re#glue(re#trailing_space, re#consecutive_blank_lines)
