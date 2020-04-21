function misc#wnd#save_scroll() abort
  let wscroll = {'top':0, 'bottom':0, 'cpos':getcurpos()}
  try
    let cview = winsaveview()
    keepjump norm! H
    let wscroll.top = line('.')
    keepjump norm! L
    let wscroll.bottom = line('.')
  finally
    call winrestview(cview)
    return wscroll
  endtry
endfunction

" Restore saved scroll, align top or bottom. It's possible that after restore,
" the current cursor become invisible, set keep_cursor to true will force a
" cursor restore.
function misc#wnd#restore_scroll(wscroll, top, keep_cursor) abort
  try
    if a:top
      call cursor(a:wscroll.top, 0)
      keepjump norm! H
      norm! zt
    else
      call cursor(a:wscroll.bottom, 0)
      keepjump norm! L
      norm! zb
    endif
  finally
    if a:keep_cursor
      call setpos('.', a:wscroll.cpos)
    endif
  endtry
endfunction
