" tmux global terminal

" [normalized_row_height, nomalized_col_width] for new gterm
let g:ddd_gterm_size = get(g:, 'ddd_gterm_size', [0.3, 0.5])
let g:ddd_tgterm_pos = get(g:, 'ddd_gterm_pos', 'l')
let g:ddd_gterm_repeat_cmd = get(g:, 'ddd_gterm_repeat_cmd', "\<esc>k\<tab>\<cr>")
let g:ddd_gterm_new_cmd = get(g:, 'ddd_gterm_new_cmd', 'term ++kill=kill')
let g:ddd_gterm_init_cmd = get(g:, 'ddd_gterm_init_cmd', [])

let s:gterm = {}

function ddd#tgterm#toggle() abort
  if !s:exists()
    call s:new()
    return
  endif

  if s:visible()
    call ddd#tgterm#hide()
  else
    call ddd#tgterm#show()
  endif
endfunction

function ddd#tgterm#show() abort
  if !s:exists()
    return s:new()
  endif

  if !s:visible()
    call s:split(0)
  endif
  call s:gterm.select()
endfunction

function ddd#tgterm#hide() abort
  if !s:visible()
    return
  endif

  let s:gterm.last_size = s:gterm.size()
  call s:gterm.hide('-n gterm')
endfunction

function ddd#tgterm#repeat_cmd() abort
  if !s:exists()
    return s:new()
  endif

  call ddd#tgterm#show()
  call s:gterm.send( [g:ddd_gterm_repeat_cmd] )
endfunction

function s:exists() abort
  return s:gterm != {} && s:gterm.exists()
endfunction

function s:visible() abort
  return s:gterm != {} && s:gterm.visible()
endfunction

function s:new() abort
  call s:split(1)
  if !empty(g:ddd_gterm_init_cmd)
    let cmd = []
    call map( g:ddd_gterm_init_cmd, { i,v -> extend(cmd, [v, 'Enter']) } )
    call s:gterm.send(cmd)
  endif
endfunction

" split window, use default size, pos for new gterm split, otherwise use
" recorded one.
function s:split(new) abort
  if a:new
    let s:gterm = ddd#tmux#split('-p 25')
  else
    call s:gterm.show('-l ' . s:gterm.last_size[1])
  endif
endfunction
