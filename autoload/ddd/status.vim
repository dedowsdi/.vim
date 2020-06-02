let g:ddd_status_exprs = get(g:, 'ddd_status_exprs', [])

function ddd#status#eval_exprs() abort
  let res = map( copy(g:ddd_status_exprs), { i,v -> call(v, []) } )
  let str = join( filter(res, {i,v -> !empty(v)}), ' | ' )
  return empty(str) ? '' : '| ' . str
endfunction

" cache git branch
function ddd#status#git_head() abort
  if !exists('b:fugitive_githead')
    let b:fugitive_githead = fugitive#head()
  endif

  return b:fugitive_githead
endfunction
