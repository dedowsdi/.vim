function ddd#terminal#setup()

  if has('gui_running')
    return
  endif

  imap <Nul> <c-space>

  if &term =~? 'xterm'
    call s:setup_xterm()
  elseif &term =~? 'rxvt'
    call s:setup_rxvt()
  elseif &term =~? '^screen' || &term =~? '^tmux' || &term =~? '^st'
    call s:setup_xterm_variants()
  endif

  if exists('$VTE_VERSION')
    let &t_Ce = "\e[4:0m"
    let &t_Cs = "\e[4:3m"
  endif

  if has('nvim')
    set rtp^=$HOME/.vim,$HOME/.vim/after
    let g:python3_host_prog = '/usr/bin/python3'
    let &shada="'200,<50,s10,h"
    tnoremap <expr> <m-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
    " map to <c-f#> and <s-f#>
    for i in range(1,12)
      exec printf('map <f%d> <s-f%d>', i+12, i)
      exec printf('map <f%d> <c-f%d>', i+24, i)
    endfor
  else
    for letter in map(range(26), {i,v->nr2char(char2nr('a')+v)})
      exec printf('set <a-%s>=%s', letter, letter)
    endfor
  endif

endfunction

function s:setup_rxvt()

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

  " rxvt s-f1=f11, s-f2=f12, s-f4 and s-f5 don't work for unknown reason,
  " replace them with xterm code
  set <s-f1>=[1;2P
  set <s-f2>=[1;2Q
  set <s-f3>=[25~
  set <s-f4>=[1;2S
  set <s-f5>=[15;2~
  set <s-f6>=[29~
  set <s-f7>=[31~
  set <s-f8>=[32~
  set <s-f9>=[33~
  set <s-f10>=[34~
  set <s-f11>=[23$
  set <s-f12>=[24$

  set <c-left>=Od
  set <c-right>=Oc
  " set <c-up>=Oa
  " set <c-down>=Ob
  set <s-left>=[d
  set <s-right>=[c
  set <s-up>=[a
  set <s-down>=[b

  call s:create_keymap('<c-pageup>', '<f13>', '[5^')
  call s:create_keymap('<c-pagedown>', '<f14>', '[6^')

endfunction

function s:setup_xterm_variants()

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
  " set <c-up>=[1;5A
  " set <c-down>=[1;5B
  set <s-left>=[1;2D
  set <s-right>=[1;2C
  set <s-up>=[1;2A
  set <s-down>=[1;2B

  call s:create_keymap('<c-pageup>', '<f13>', '[5;5~')
  call s:create_keymap('<c-pagedown>', '<f14>', '[6;5~')

endfunction

function s:setup_xterm()

  call s:create_keymap('<c-f1>',  '<f25>', '[1;5P')
  call s:create_keymap('<c-f2>',  '<f26>', '[1;5Q')
  call s:create_keymap('<c-f3>',  '<f27>', '[1;5R')
  call s:create_keymap('<c-f4>',  '<f28>', '[1;5S')

  set <s-f1>=[1;2P
  set <s-f2>=[1;2Q
  set <s-f3>=[1;2R
  set <s-f4>=[1;2S

endfunction

function s:create_keymap(keycode, vehicle, seq)
  exec printf('set %s=%s', a:vehicle, a:seq)
  exec printf('map %s %s', a:vehicle, a:keycode)
endfunction

function ddd#terminal#test()

  echom repeat('*', 60)
  echom 'create test terminal keys'
  echom 'you must press the test key, feedkeys("\<c-left>") always work,
        \ as "\<...>" is vim internal keycode'

  for i in range(1, 12)
    exec printf('map <buffer> <f%d> :echom "f%d"<cr>', i, i)
    exec printf('map <buffer> <c-f%d> :echom "c-f%d"<cr>', i, i)
    exec printf('map <buffer> <s-f%d> :echom "s-f%d"<cr>', i, i)
  endfor
  nnoremap <buffer> <c-left> :echom 'c-left'<cr>
  nnoremap <buffer> <c-right> :echom 'c-right'<cr>
  " nnoremap <buffer> <c-up> :echom 'c-up'<cr>
  " nnoremap <buffer> <c-down> :echom 'c-down'<cr>
  nnoremap <buffer> <s-left> :echom 's-left'<cr>
  nnoremap <buffer> <s-right> :echom 's-right'<cr>
  nnoremap <buffer> <s-up> :echom 's-up'<cr>
  nnoremap <buffer> <s-down> :echom 's-down'<cr>
  nnoremap <buffer> <c-pageup> :echom 'c-pageup'<cr>
  nnoremap <buffer> <c-pagedown> :echom 'c-pagedown'<cr>

endfunction

" [cwd, arg1, arg2, ...]
function Tapi_gdb(bufnum, arglist) abort
  " goto source file, split new tab
  if &buftype ==# 'terminal'
    wincmd p
  endif
  tab split

  " escape white space, <f-args> are separated by normal white space
  let eargs = map(a:arglist, {_,v -> substitute(v, '\s', '\\&', 'g')})
  exe 'TermdebugCommand' join(eargs[1:])
  call term_sendkeys('', printf("set cwd %s\<cr>", eargs[0] ) )

  " make sure source file occupy entire column
  3wincmd w
  wincmd H
  wincmd w
endfunction

" [cwd]
function Tapi_lcd(bufnum, arglist) abort
  let winid = bufwinid(a:bufnum)
  let cwd = get(a:arglist, 0, '')
  if winid == -1 || empty(cwd)
    return
  endif
  call win_execute(winid, 'lcd ' . cwd)
endfunction
