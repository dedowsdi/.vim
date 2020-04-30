if exists('b:loaded_hare_cfg')
  finish
endif
let b:loaded_hare_cfg = 1

setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted modifiable
      \ nofoldenable
      \ nonumber norelativenumber nolist
      \ undolevels=-1
      \ statusline=hare

" custom hare map
cmap <buffer> <c-c> <plug>ddd_hare_abort
cmap <buffer> <c-o> <plug>ddd_hare_sink
nmap <buffer> <cr> <plug>ddd_hare_sink

cmap <buffer> <c-s> <cr>:let b:hare.mods='leftabove'<cr><plug>ddd_hare_sink
nmap <buffer> <c-s> <esc>:let b:hare.mods='leftabove'<cr><plug>ddd_hare_sink
cmap <buffer> <c-v> <cr>:let b:hare.mods='vertical leftabove'<cr><plug>ddd_hare_sink
nmap <buffer> <c-v> <esc>:let b:hare.mods='vertical leftabove'<cr><plug>ddd_hare_sink
