if exists('b:loaded_hare_cfg')
  finish
endif
let b:loaded_hare_cfg = 1

setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted modifiable
      \ nofoldenable
      \ nonumber norelativenumber nolist
      \ undolevels=-1
      \ statusline=hare


" clear hare map by dummy
nnoremap <buffer> <c-p> <c-p>
nnoremap <buffer> <a-p> <a-p>
nnoremap <buffer> <c-h> <c-h>
nnoremap <buffer> <c-b> <c-b>
nnoremap <buffer> <c-k> <c-k>
