" {'open_pair':"(", "close_pair":")", "pos0":[l,c], "pos1":[l,c]}
function ddd#pair#get() abort
  try
    let cpos = getcurpos()
    let cview = winsaveview()

    let pairs = split(substitute(&matchpairs, ':', '', 'g'), ',')
    let pos0 = []
    let pos1 = []
    let open_pair = ''
    let close_pair = ''
    let cchar = dddu#get_cc()

    for pair in pairs

      call setpos('.', cpos)

      " get close pair position
      let p1 = cchar == pair[1] ?
            \ [ line('.'), col('.') ] :
            \ searchpairpos( '\V'.pair[0], '', '\V'.pair[1], 'W' )
      if p1 == [0, 0]
        continue
      endif

      let c1 = dddu#get_cc()

      " get open pair position
      norm! %
      let p0 = [ line('.'), col('.') ]
      if p0 == p1
        continue
      endif

      let c0 = dddu#get_cc()

      " test if cpos is between p0 and p1
      if dddu#pos#cmp( p0, cpos[1:2] ) == 1 || dddu#pos#cmp( p1, cpos[1:2] ) == -1
        continue
      endif

      " compare with last valid pair
      if pos0 == [] || dddu#pos#cmp(pos0, p0) == -1 && dddu#pos#cmp(pos1, p1) == 1
        let pos0 = p0
        let pos1 = p1
        let close_pair = c1
        let open_pair = c0
      endif

    endfor

    return pos0 == [] ? {} : { 'open_pair':open_pair, 'close_pair':close_pair, 'pos0':pos0, 'pos1':pos1 }

  finally
    call winrestview(cview)
  endtry

endfunction

function ddd#pair#expand(add) abort
  let pair = ddd#pair#get()
  if pair == {}
    return
  endif

  try
    if a:add
      call cursor(pair.pos1)
      exe "norm! i \<esc>"
      call cursor(pair.pos0)
      exe "norm! a \<esc>"
    else
      call cursor(pair.pos1)
      norm! h
      if dddu#get_cc() ==# ' '
        norm! x
      endif
      call cursor(pair.pos0)
      norm! l
      if dddu#get_cc() ==# ' '
        norm! x
      endif
    endif

  finally

    " always stop at open pair?
    call cursor(pair.pos0)
  endtry
endfunction
