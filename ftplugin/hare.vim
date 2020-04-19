if exists('b:loaded_hare_cfg')
  finish
endif
let b:loaded_hare_cfg = 1

setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted modifiable
      \ nofoldenable
      \ nonumber norelativenumber nolist
      \ undolevels=-1
      \ statusline=hare


" clear map to misc#hare..
function s:get_maps() abort
  if exists('s:maps')
    return s:maps
  endif

  let s:maps = split(execute('filter /\v<Hare>|misc#hare#/ nmap'), "\n")
  let s:maps = map(s:maps, {i,v -> matchstr(v, '\v^\w+\s+\zs\S+')})
  return s:maps
endfunction

" overwrite hare related map to original meaning
for key in s:get_maps()
  exe 'nnoremap <buffer>' key key
endfor
