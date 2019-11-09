let s:cmdrange = []
let s:cmdrange_hid = -1
let s:enabled = 0

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
    autocmd CmdlineEnter : call s:update_cmdrange_highlight()
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

function s:build_cmdrange_pattern()
  " a range is various pattern (optional) followed by multiple optional [+-][number]
  let range_atoms = [
        \ '\d+',
        \ '[.$%]',
        \ "'[0-9A-Z]",
        \ '\/.{-}\/',
        \ '\?.{-}\?',
        \ '\\\?',
        \ '\\\&',
        \ '\\\&',
        \ ]
  let range_basic = printf('%%(%s)', join(range_atoms, '|'))
  let range_optional = '%(\s*%([+-]\d*)*)'
  let range_pat = printf('\v%%(%s?\s*%s*)', range_basic, range_optional)

  " a cmdrange is one range or two ranges joined by, or ;
  let cmdrange_pat = printf('\v\C^%s([,;]%s)?', range_pat, range_pat)
  return cmdrange_pat
endfunction
let s:cmdrange_pat = s:build_cmdrange_pattern()

function s:update_cmdrange_highlight() abort

  let cmdline = getcmdline()

  " skip :h v_:
  if cmdline =~# '\V\^''<,''>'
    return
  endif

  " skip if range not changed
  let cmdrange = s:get_cmdrange(cmdline)
  if s:cmdrange == cmdrange
    return
  endif

  " update highlight area
  call s:clear_cmdrange_highlight()

  " I start with '%1l^\_.*%100l', but it failed to highlight '%' if 1st line is not visible.
  let s:cmdrange_hid = matchadd('VISUAL',
        \ printf('\v%%>%dl.*%%<%dl', cmdrange[0]-1, cmdrange[1]+1))
  let s:cmdrange = cmdrange
  redraw

endfunction

function s:clear_cmdrange_highlight() abort
  if s:cmdrange_hid != -1
    call matchdelete(s:cmdrange_hid)
  endif
  let s:cmdrange = []
  let s:cmdrange_hid = -1
endfunction

function s:get_cmdrange(cmdline) abort

  let range_text = matchstr(a:cmdline, s:cmdrange_pat)
  if range_text !~# '\S'
    return []
  endif

  try
    let cpos = getcurpos()

    " silent is used to reverse reversed command range
    exec printf('silent %s call Tech_get_cmdrange()', range_text)
    return [s:tech_cmdrange_line1, s:tech_cmdrange_line2]
  finally
    call setpos('.', cpos)
  endtry
endfunction

function Tech_get_cmdrange() range
  let s:tech_cmdrange_line1 = a:firstline
  let s:tech_cmdrange_line2 = a:lastline
endfunction
