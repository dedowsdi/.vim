let g:eython_maxitem_per_direction = 8
function misc#eython#complete(backward) abort

  let l = matchlist(getline('.'), printf('\v(.*)(<\w+)\zs%%%dc', col('.')))
  if empty(l) || l[2] ==# ''
    return ''
  endif
  let start_col = len(l[1])+1
  let base = l[2]

  try
    let view = winsaveview()
    let reg_text = @@
    let reg_type = getregtype('"')

    " collect completions, if there are duplicates, prefer before cursor
    " completions for backward, after cursor completions for forward.

    " place cursor at start of current word
    norm! b
    let cpos = getcurpos()
    let pattern = '\v<'.base

    let comp_set = {}
    let flag0 = a:backward ? 'bW' : 'W'
    let flag1 = a:backward ? 'W' : 'bW'
    let before_cursor_comps = []
    let after_cursor_comps = []

    for flag in [flag0, flag1]
      call setpos('.', cpos)
      let comps = flag ==# 'W' ? after_cursor_comps : before_cursor_comps
      let idx = 0
      while search(pattern, flag) && idx < g:eython_maxitem_per_direction
        exe "norm y\<plug>dedowsdi_to_ie"
        if !has_key(comp_set, @@)
          let comp_set[ @@ ] = 1
          let idx += 1
          let comps += [ s:create_complete_item(@@) ]
        endif
      endwhile
    endfor

  finally
    call winrestview(view)
    call setreg('"', reg_text, reg_type)
  endtry

  " join completions, follow the same convention as ctrl-p and ctrl-n,
  " completions after cursor on top of the list.
  call complete( start_col, after_cursor_comps + reverse(before_cursor_comps) )

  augroup eython_complete_group | au!
    autocmd CompleteDone <buffer> ++once call s:done_callback()
  augroup end

  return a:backward ? "\<c-p>\<c-p>" : ''
endfunction

function s:create_complete_item(text)
  let idx = stridx(a:text, "\n")
  if idx == -1
    return a:text
  endif

  " chop abbr at new line
  let abbr = printf( '%s...', strpart(a:text, 0, idx) )
  let item = { 'word' : a:text, 'abbr' : abbr }
  return item
endfunction

function s:done_callback() abort
  " return if abandoned
  if v:completed_item == {}
    return
  endif

  " return if no new line found
  let idx = strridx( v:completed_item.word, "\n" )
  if idx == -1
    return
  endif

  " vim insert newline as ^@, must replace it
  let len_last_line = len(v:completed_item.word) - idx - 1
  s/\%x00/\r/g
  call cursor( line('.'), len_last_line+1 )
endfunction
