
" [ {expression:, enabled:},...  ]
let s:display_objects = []
let s:flag = 1

function misc#debugvim#enable()
  let s:display_objects = []
  let s:flag = 1
  augroup debugvim_group
    au!
    autocmd CmdlineEnter > call s:print_frame()
  augroup end
endfunction

function misc#debugvim#disable()
  augroup debugvim_group
    au!
  augroup end
endfunction

function misc#debugvim#display(exp)
  call filter( s:display_objects, {i,v -> v.expression !=# a:exp} )
  let s:display_objects += [ {'expression':a:exp, 'enabled':1} ]
endfunction

function misc#debugvim#disable_display(...)
  let idx = get(a:000, 0, -1)
  call map( copy(s:display_objects),
        \ {i,v -> idx == -1 || ( idx == i && execute('let v.enabled = 0') )} )
endfunction

function misc#debugvim#delete_display(...)
  let idx = get(a:000, 0, -1)
  call filter( s:display_objects, {i,v -> idx == -1 || idx == i } )
endfunction

function misc#debugvim#info_display()
  call map( copy(s:display_objects), {i,v -> execute( printf("echo %d : %s", i, v) )} )
endfunction

function s:print_frame() abort

  " skip event triggered by this print, avoid dead loop. It's not allowed to
  " call execute('where'), otherwise it's a perfect way to avoid redundant
  " print.
  let s:flag = xor(s:flag, 1)
  if s:flag == 1
    return
  endif

  let cmd = 'echo a: | echo l: '
  for dobj in s:display_objects
    if dobj.enabled
      let cmd .= printf("| echo '%s : ' . %s", dobj.expression, dobj.expression)
    endif
  endfor

  " add 32 spaces to make it easy to look
  call feedkeys( printf("                                if exists('a:') | %s | endif \<cr>", cmd) )
endfunction
