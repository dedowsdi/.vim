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

" remap close window to abort
nmap <buffer> <c-w>q <plug>ddd_hare_abort
nmap <buffer> <c-w><c-q> <plug>ddd_hare_abort
nmap <buffer> ZZ <plug>ddd_hare_abort
nmap <buffer> ZQ <plug>ddd_hare_abort
cmap <buffer> <c-c> <plug>ddd_hare_abort
cnoremap <silent> <buffer> <expr> <cr> getcmdtype() ==# ':' &&
      \ getcmdline() =~# '\v^\s*\:?%(q%[uit]\|x%[it]\|exi%[t])\s*$'
      \ ? '<c-u>exe "norm \<plug>ddd_hare_abort"<cr>' : '<cr>'

cmap <buffer> <c-o> <plug>ddd_hare_sink
nmap <buffer> <cr> <plug>ddd_hare_sink
nnoremap <leader>f :<c-u>let g:ddd_hare_filter = !g:ddd_hare_filter<cr>

cmap <buffer> <c-s> <cr>:let b:hare.mods='leftabove'<cr><plug>ddd_hare_sink
nmap <buffer> <c-s> <esc>:let b:hare.mods='leftabove'<cr><plug>ddd_hare_sink
cmap <buffer> <c-v> <cr>:let b:hare.mods='vertical leftabove'<cr><plug>ddd_hare_sink
nmap <buffer> <c-v> <esc>:let b:hare.mods='vertical leftabove'<cr><plug>ddd_hare_sink
