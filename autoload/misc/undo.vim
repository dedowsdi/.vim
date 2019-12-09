" { bufnr : { name : seq, ...  }, ...  }
let s:tags = {}

" [, seq]
function misc#undo#tag(force, name, ...) abort
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

function misc#undo#tag_start() abort
  call extend( s:get_buf_tags(), { 'start_tag' : changenr() }, 'keep' )
endfunction

function misc#undo#undostart() abort
  call misc#undo#checkout('start_tag')
endfunction

" warning when you try to undo into older sessions
function misc#undo#safeundo() abort

  " restrict to normal buffer
  if &buftype !=# ''
    return
  endif

  if changenr() == misc#undo#get_tag('start_tag')
    echohl ErrorMsg
    echom 'Reaching start point! use norm! u instead'
    echohl None
    return
  endif
  norm! u
endfunction

function misc#undo#list_tags() abort
  let buf_tags = s:get_buf_tags()
  for tag in keys(buf_tags)
    echo printf('%s : %d', tag, buf_tags[tag])
  endfor
endfunction

function misc#undo#checkout(name) abort
  let buf_tags = s:get_buf_tags()
  if !has_key(buf_tags, a:name)
    echom a:name . ' is not a valid tag name'
    return
  endif

  exe 'undo' . buf_tags[a:name]
  echom 'checkout undo ' . a:name
endfunction

function misc#undo#complete_tag(arglead, cmdline, pos) abort
  let buf_tags = s:get_buf_tags()
  return filter(keys(buf_tags), {i,v -> v =~# '\V\^' . a:arglead })
endfunction

function misc#undo#get_tag(name, ...)
  let buf = get(a:000, 0, bufnr(''))
  let tags = s:get_buf_tags(buf)
  return get(tags, a:name, -1)
endfunction

function s:get_buf_tags(...) abort
  let buf = get(a:000, 0, bufnr(''))
  if !has_key(s:tags, buf)
    let s:tags[buf] = {}
  endif
  return s:tags[buf]
endfunction

"
"    4
"    3 6
"    2 5
"    1
"    0
"
" undotree().entries is a list of node from beginning(not 0) to current branch
" head.
"
" if we are at 4, entries will be [1, 2, 3, 4], 2(not 1, be careful) has alt
" entries [5,6], 1 is branch point
"
" if we are at 6, entries will be [1, 5, 6], 5(not 1, be careful) has alt
" entries [2,3,4], 1 is branch point
"
function misc#undo#undo_branch_point() abort
  let nodes = copy(undotree().entries)

  " find current node index, it's next node is redo node, which has curhead
  let node_index = len(nodes) - 1
  let i = node_index
  while i >= 0
    let node = nodes[i]
    if has_key(node, 'curhead')
      let node_index = i - 1
      break
    endif
    let i -= 1
  endwhile

  " find alt node
  let alt_index = 0
  let i = node_index
  while i >= 0
    let node = nodes[i]
    if has_key(node, 'alt')
      let alt_index = i
      break
    endif
    let i -= 1
  endwhile

  " branching node is previous node of alt node
  let seq = alt_index == 0 ? 0 : nodes[alt_index - 1].seq
  exec 'undo' seq
endfunction
