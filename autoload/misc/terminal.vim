function! misc#terminal#setup()

  if has('gui_running') || &termguicolors
    " 16 ansi colors (gruvbox) for gvim or if 'termguicolors' is on
    let g:terminal_ansi_colors = [
                \ '#282828',
                \ '#cc241d',
                \ '#98971a',
                \ '#d79921',
                \ '#458588',
                \ '#b16286',
                \ '#689d6a',
                \ '#a89984',
                \ '#928374',
                \ '#fb4934',
                \ '#b8bb26',
                \ '#fabd2f',
                \ '#83a598',
                \ '#d3869b',
                \ '#8ec07c',
                \ '#ebdbb2',
                \ ]
  endif

  if has('gui_running')
    if !has('nvim')
      set lines=100 columns=999
      set guioptions=aegim " remove menu, scroll bars
    endif

    return
  endif

  " undercurl doesn't work on terminal
  hi clear SpellBad
  hi SpellBad cterm=underline

  if &term =~? 'xterm'
    call s:setup_xterm()
  elseif &term =~? 'rxvt'
    call s:setup_rxvt()
  elseif &term =~? 'screen'
    call s:setup_screen()
  endif

  if !has('nvim')
    for letter in map(range(26), {i,v->nr2char(char2nr('a')+v)})
      exec printf('set <a-%s>=%s', letter, letter)
    endfor
  endif

endfunction

function! s:setup_rxvt()
  call s:create_keymap('<c-f1>',  '<f25>', '[11^')
  call s:create_keymap('<c-f2>',  '<f26>', '[12^')
  call s:create_keymap('<c-f3>',  '<f27>', '[13^')
  call s:create_keymap('<c-f4>',  '<f28>', '[14^')
  call s:create_keymap('<c-f5>',  '<f29>', '[15^')
  call s:create_keymap('<c-f6>',  '<f30>', '[17^')
  call s:create_keymap('<c-f7>',  '<f31>', '[18^')
  call s:create_keymap('<c-f8>',  '<f32>', '[19^')
  call s:create_keymap('<c-f9>',  '<f33>', '[20^')
  call s:create_keymap('<c-f10>', '<f34>', '[21^')
  call s:create_keymap('<c-f11>', '<f35>', '[23^')
  call s:create_keymap('<c-f12>', '<f36>', '[24^')

  set <s-f1>=[1;2P
  set <s-f2>=[1;2Q
  set <s-f3>=[1;2R
  set <s-f4>=[1;2S
  set <s-f5>=[15;2~
  set <s-f6>=[17;2~
  set <s-f7>=[18;2~
  set <s-f8>=[19;2~
  set <s-f9>=[20;2~
  set <s-f10>=[21;2~
  set <s-f11>=[23;2~
  set <s-f12>=[24;2~

  set <c-left>=[1;5D
  set <c-right>=[1;5C

endfunction

function! s:setup_screen()

  call s:create_keymap('<c-f1>',  '<f25>', '[1;5P')
  call s:create_keymap('<c-f2>',  '<f26>', '[1;5Q')
  call s:create_keymap('<c-f3>',  '<f27>', '[1;5R')
  call s:create_keymap('<c-f4>',  '<f28>', '[1;5S')
  call s:create_keymap('<c-f5>',  '<f29>', '[15;5~')
  call s:create_keymap('<c-f6>',  '<f30>', '[17;5~')
  call s:create_keymap('<c-f7>',  '<f31>', '[18;5~')
  call s:create_keymap('<c-f8>',  '<f32>', '[19;5~')
  call s:create_keymap('<c-f9>',  '<f33>', '[20;5~')
  call s:create_keymap('<c-f10>', '<f34>', '[21;5~')
  call s:create_keymap('<c-f11>', '<f35>', '[23;5~')
  call s:create_keymap('<c-f12>', '<f36>', '[24;5~')

  set <s-f1>=[1;2P
  set <s-f2>=[1;2Q
  set <s-f3>=[1;2R
  set <s-f4>=[1;2S
  set <s-f5>=[15;2~
  set <s-f6>=[17;2~
  set <s-f7>=[18;2~
  set <s-f8>=[19;2~
  set <s-f9>=[20;2~
  set <s-f10>=[21;2~
  set <s-f11>=[23;2~
  set <s-f12>=[24;2~

  set <c-left>=[1;5D
  set <c-right>=[1;5C

endfunction

function! s:setup_xterm()

  call s:create_keymap('<c-f1>',  '<f25>', '[1;5P')
  call s:create_keymap('<c-f2>',  '<f26>', '[1;5Q')
  call s:create_keymap('<c-f3>',  '<f27>', '[1;5R')
  call s:create_keymap('<c-f4>',  '<f28>', '[1;5S')

  set <s-f1>=[1;2P
  set <s-f2>=[1;2Q
  set <s-f3>=[1;2R
  set <s-f4>=[1;2S

endfunction

function! s:create_keymap(keycode, vehicle, seq)
  exec printf('set %s=%s', a:vehicle, a:seq)
  exec printf('map %s %s', a:vehicle, a:keycode)
endfunction
