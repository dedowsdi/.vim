" { bufnr : { name : seq, ...  }, ...  }
let s:tags = {}

function misc#undotag#add(force, name, ...) abort
  let seq = get(a:000, 0, changenr())
  if seq =~# '\v\D'
    echom seq . ' is not a valid number'
    return
  endif

  let utree = undotree()
  if seq > utree.seq_last
    echom seq . ' is greater than highest undo sequence number ' . utree.seq_last
    return
  endif

  let buf_tags = s:get_buf_tags()
  if !a:force && has_key(buf_tags, a:name)
    echom printf('%s is already bound to %d, add ! if you want to overwrite it',
          \ a:name, buf_tags[a:name])
    return
  endif

  let buf_tags[a:name] = seq
  echom printf('bind %s to seq %d', a:name, seq)
endfunction

function misc#undotag#checkout(name) abort
  let buf_tags = s:get_buf_tags()
  if !has_key(buf_tags, a:name)
    echom a:name . ' is not a valid tag name'
    return
  endif

  exe 'undo' . buf_tags[a:name]
  echom 'checkout undotag ' . a:name
endfunction

function misc#undotag#complete(arglead, cmdline, pos) abort
  let buf_tags = s:get_buf_tags()
  return filter(keys(buf_tags), {i,v -> v =~# '\V\^' . a:arglead })
endfunction

function s:get_buf_tags(...) abort
  let buf = get(a:000, 0, bufnr(''))
  if !has_key(s:tags, buf)
    let s:tags[buf] = {}
  endif
  return s:tags[buf]
endfunction
