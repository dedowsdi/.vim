let g:lastJterm = get(g:, 'lastJterm', {})
let g:termIndex = get(g:, 'termIndex', 0)
let g:termIndex += 1

if type(g:lastJterm) != v:t_dict
  let g:lastJterm = {}
endif

if g:lastJterm != {}
  echom "last job finished : " g:lastJterm.jobFinished
  call g:lastJterm.close()
endif

let g:lastJterm = misc#term#jtermopen({'cmd' : 'sh -c "echo ' . g:termIndex .'"'})
finish

" reload macro
'Q€k5'W€k5'E€k5'T
