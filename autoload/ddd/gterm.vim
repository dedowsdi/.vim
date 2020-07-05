" A global terminal always occupy the entire row or col, it remembers it's
" position and size.

" [normalized_row_height, nomalized_col_width] for new gterm
let g:ddd_gterm_size = get(g:, 'ddd_gterm_size', [0.3, 0.5])
let g:ddd_gterm_pos = get(g:, 'ddd_gterm_pos', 'k')
let g:ddd_gterm_repeat_cmd = get(g:, 'ddd_gterm_repeat_cmd', "\<esc>k\<tab>\<cr>")
let g:ddd_gterm_new_cmd = get(g:, 'ddd_gterm_new_cmd', 'term ++kill=kill')
let g:ddd_gterm_init_cmd = get(g:, 'ddd_gterm_init_cmd', [])

let s:gterm = { 'buf' : -1, 'pos' : g:ddd_gterm_pos  }

augroup ag_ddd_gterm | au! | augroup end

function ddd#gterm#toggle() abort
  if !s:exists()
    call s:new()
    return
  endif

  if ddd#gterm#winid() == -1
    call ddd#gterm#show()
  else
    call ddd#gterm#hide()
  endif
endfunction

function ddd#gterm#show() abort
  if !s:exists()
    return s:new()
  endif

  if s:visible()
    exe s:winnr() 'wincmd w'
  else
    call s:split(0)
    exe 'b' s:gterm.buf
  endif

endfunction

function ddd#gterm#hide() abort
  if !s:visible()
    return
  endif

  exe s:winnr() 'wincmd q'
endfunction

function ddd#gterm#repeat_cmd() abort
  if !s:exists()
    " return after new, don't repeat for new terminal.
    return s:new()
  endif

  call ddd#gterm#show()

  " mark m to buffer end. Don't use `mark m`, it will set m to last cursor line
  " when you leave terminal buffer normal mode.
  $mark m

  if mode() =~# '^n'
    norm! i
  endif

  " repeat last command
  call term_sendkeys('', g:ddd_gterm_repeat_cmd)
  wincmd p
endfunction

function ddd#gterm#winid() abort
  return bufwinid(s:gterm.buf)
endfunction

function s:exists() abort
  return bufexists(s:gterm.buf)
endfunction

function s:winnr() abort
  return win_id2win(ddd#gterm#winid())
endfunction

function s:visible() abort
  return ddd#gterm#winid() != -1
endfunction

function s:new() abort
  call s:split(1)
  exe g:ddd_gterm_new_cmd '++curwin'
  let s:gterm.buf = bufnr()
  autocmd ag_ddd_gterm BufLeave <buffer> call s:on_buf_leave()

  " cd to default working directory
  if !empty(g:ddd_gterm_init_cmd)
    call term_sendkeys('', join(g:ddd_gterm_init_cmd, "\<cr>") . "\<cr>")
  endif
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
