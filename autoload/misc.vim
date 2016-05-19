function! misc#warn(mes)
  echohl WarningMsg | echom a:mes | echohl None
endfunction

" a hack, maybe i should do it in another way
function! misc#hasjob(job)
  try | call jobpid(a:job)
    return 1
  catch /^Vim\%((\a\+)\)\=:E900/	" catch error E900
    return 0
  endtry
endfunction

" check if quickfix window is open
function! misc#qfixexists()
  for i in range(1, winnr('$'))
    let bufnr = winbufnr(i)
    if getbufvar(bufnr, '&buftype') == 'quickfix'
      return 1
    endif
  endfor
  return 0
endfunction

" jump to buffer win if bufwinnr is not -1
" return 1 if success
function! misc#jumpToBufWin(buf)
  if bufwinnr(a:buf)  != -1
    exec bufwinnr(a:buf).'wincmd w'
    return 1
  endif
  return 0
endfunction

" make sure 1 and only 1 trailing /
function! misc#normDir(splitdir)
  if a:splitdir == ""|return a:splitdir|endif
  return substitute(a:splitdir, '\v//*$', '', '').'/'
endfunction

" _| normalized_size
function! misc#hvSize(hv, size)
  if !has_key(s:hvOptions, a:hv)
    throw "unknown hv: " . a:hv
  endif
  return float2nr(s:hvOptions[a:hv].total * a:size)
endfunction

let s:hvOptions = {
      \ "_" : {"winfix":"winfixwidth",  "dir":"",  "total":&lines,  },
      \ "|" : {"winfix":"winfixheight", "dir":"vertical ", "total":&columns,},
      \ }

let s:layouts = {
      \ "J": ["botright ", "_"],
      \ "K": ["topleft ",  "_"],
      \ "L": ["botright ", "|"],
      \ "H": ["topleft ",  "|"],
      \ }

" opts{layout:,size:,fix:}, cmd
" return bufnr
function! misc#layoutCmd(opts, cmd)
  let layout = get(a:opts, "layout", 'J')
  let size = get(a:opts, "size", 0.5)
  let fix = get(a:opts, "fix", 0)
  let hv = s:layouts[layout][1]
  let hvOption = s:hvOptions[hv]

  exec s:layouts[layout][0] . hvOption.dir . a:cmd

  if fix
    exec 'setlocal ' . hvOption.winfix
  endif
  return bufnr('%')
endfunction
