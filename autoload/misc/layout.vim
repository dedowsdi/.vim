let s:layouts={}
let s:resize_cmds={}

function misc#layout#save(name) abort
  let s:layouts[a:name] = winlayout()
  let s:resize_cmds[a:name] = winrestcmd()
  call s:add_buf_to_layout(s:layouts[a:name])
endfunction

" add bufnr to leaf
function s:add_buf_to_layout(layout) abort
  if a:layout[0] ==# 'leaf'
    call add(a:layout, winbufnr(a:layout[1]))
  else
    for child_layout in a:layout[1]
      call s:add_buf_to_layout(child_layout)
    endfor
  endif
endfunction

function misc#layout#restore(name) abort
  if !has_key(s:layouts, a:name)
    return
  endif

  " create clean window
  new
  wincmd o

  " recursively restore buffers
  call s:apply_layout(s:layouts[a:name])

  " resize
  exe s:resize_cmds[a:name]
endfunction

function s:apply_layout(layout) abort

  if a:layout[0] ==# 'leaf'

    " load buffer for leaf
    if bufexists(a:layout[2])
      exe printf('b %d', a:layout[2])
    endif
  else

    " split cols or rows, split n-1 times
    let split_method = a:layout[0] ==# 'col' ? 'rightbelow split' : 'rightbelow vsplit'
    let wins = [win_getid()]
    for child_layout in a:layout[1][1:]
      exe split_method
      let wins += [win_getid()]
    endfor

    " recursive into child windows
    for index in range(len(wins) )
      call win_gotoid(wins[index])
      call s:apply_layout(a:layout[1][index])
    endfor

  endif
endfunction
