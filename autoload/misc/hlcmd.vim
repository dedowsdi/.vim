let s:cmdrange = []
let s:cmdrange_hid = -1
let s:enabled = 0

" delay make sure cmap or feedkeys go through without triggering highlight, it's
" in miliseconds
let s:delay = 5
let s:start_time = reltime()

function misc#hlcmd#toggle() abort
  if s:enabled
    call s:disable()
  else
    call s:enable()
  endif
  echom s:enabled ? 'command highlight enabled' : 'command hight disabled'
endfunction

function s:enable() abort
  augroup hlcmd_group
    au!
    autocmd CmdlineChanged : call s:update_cmdrange_highlight()
    autocmd CmdlineEnter : call s:enter_cmdline()
    autocmd CmdlineLeave : call s:clear_cmdrange_highlight()
  augroup end
  let s:enabled = 1
endfunction

function s:disable() abort
  augroup hlcmd_group
    au!
  augroup end
  let s:enabled = 0
endfunction

function s:skip(range_text)
  " skip common non-range pattern(start with [a-z]), v_: , % , total blank
  return a:range_text =~# '\v\C^%(\s*[a-zA-Z]|''\<\,\s*''\>|\s*\%|\s*$)'
endfunction

function s:enter_cmdline() abort
  let s:start_time = reltime()
endfunction

function s:delay_finished() abort
  return 1000 * reltimefloat(reltime(s:start_time, reltime())) > s:delay
endfunction

function s:update_cmdrange_highlight() abort

  if !s:delay_finished()
    return
  endif

  let cmdline = getcmdline()

  " skip certain range patterns and common non-range patterns
  if s:skip(cmdline)
    if s:clear_cmdrange_highlight()
      redraw
    endif
    return
  endif

  let range_text = misc#cmdline#get_range_text(cmdline)
  " do nothing if cmd range doesn't change
  let cmdrange = misc#cmdline#range2lnum(range_text)
  if cmdrange == s:cmdrange
    return
  endif

  " update highlight area
  call s:clear_cmdrange_highlight()
  let s:cmdrange = cmdrange

  " I start with '%1l^\_.*%100l', but it failed to highlight '%' if 1st line is not visible.
  let s:cmdrange_hid = matchadd('VISUAL',
        \ printf('\v%%>%dl.*%%<%dl', s:cmdrange[0]-1, s:cmdrange[1]+1))
  redraw
  let s:start_time = reltime()

endfunction

function s:clear_cmdrange_highlight() abort
  let cleared = 0
  if s:cmdrange_hid != -1
    call matchdelete(s:cmdrange_hid)
    let cleared = 1
  endif
  let s:cmdrange = []
  let s:cmdrange_hid = -1
  return cleared
endfunction
