" A global terminal always occupy the entire row or col, it remembers it's
" position and size.

" [normalized_row_height, nomalized_col_width] for new gterm
let g:ddd_gterm_size = get(g:, 'ddd_gterm_size', [0.3, 0.5])
let g:ddd_gterm_pos = get(g:, 'ddd_gterm_pos', 'j')

let s:gterm = { 'buf' : -1, 'pos' : g:ddd_gterm_pos  }

function ddd#gterm#toggle() abort
  if !bufexists(s:gterm.buf)
    call s:new()
    return
  endif

  if ddd#gterm#winid() == -1
    call s:show_gterm()
  else
    call s:hide_gterm()
  endif
endfunction

function ddd#gterm#winid() abort
  return bufwinid(s:gterm.buf)
endfunction

function s:new() abort
  call s:split(1)
  term ++curwin
  let s:gterm.buf = bufnr()
  augroup ag_ddd_gterm | au!
    autocmd BufLeave <buffer> call s:on_buf_leave()
  augroup end
endfunction

function s:show_gterm() abort
  call s:split(0)
  exe 'b ' s:gterm.buf
endfunction

function s:hide_gterm() abort
  exe win_id2win(ddd#gterm#winid()) 'wincmd q'
endfunction

function s:on_buf_leave() abort
  let wi = getwininfo(ddd#gterm#winid())[0]

  " record pos, width, height
  if wi.winrow == 1
    if wi.wincol > 1
      let s:gterm.pos = 'l'
    else
      let s:gterm.pos = wi.width == &columns ? 'k' : 'h'
    endif
  else
    let s:gterm.pos = 'j'
  endif

  let s:gterm.width = wi.width
  let s:gterm.height = wi.height
endfunction

let s:split_cmd = {
      \ 'j' : 'botright',
      \ 'k' : 'topleft',
      \ 'l' : 'vertical botright',
      \ 'h' : 'vertical topleft',
      \ }

" split window, use default size, pos for new gterm split, otherwise use
" recorded one.
function s:split(new) abort
  let pos = a:new ? g:ddd_gterm_pos : s:gterm.pos
  exe s:split_cmd[pos] 'split'
  setlocal winfixwidth winfixheight

  if stridx('jk', pos) != -1
    let size = a:new ? g:ddd_gterm_size[0] * &lines : s:gterm.height
    exe float2nr(size) 'wincmd _'
  else
    let size = a:new ? g:ddd_gterm_size[1] * &columns : s:gterm.width
    exe float2nr(size) 'wincmd |'
  endif
endfunction
