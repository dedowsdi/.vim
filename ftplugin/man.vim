" filetype check is needed as i call runtime ftplugin/man.vim in my vimrc
if exists('b:loaded_man_cfg') || &filetype != "man"
  finish
endif
let b:loaded_man_cfg = 1

setlocal nolist
nnoremap <buffer> o /\v^\C\s{7}
nnoremap <buffer> s /\v^
nnoremap <buffer> c /\v^\s{3}
nnoremap <buffer> i /\v^\s*
nnoremap <buffer> q :q

for i in range(6)
  exe printf('nnoremap <buffer> ]%d /\v^ {%d}\zs\S.*<cr>zz', i+1, max([0, i*4-1]))
  exe printf('nnoremap <buffer> [%d ?\v^ {%d}\zs\S.*<cr>zz', i+1, max([0, i*4-1]))
endfor

nnoremap <buffer> \1 :Section<cr>
nnoremap <buffer> \2 :SubSection<cr>

com -bar -buffer NextSection /\v\C^[A-Z][^a-z]+$
com -bar -buffer PrevSection ?\v\C^[A-Z][^a-z]+$
com -bar -buffer NextSubSection /\v\C^   [A-Z].*$
com -bar -buffer PrevSubSection ?\v\C^   [A-Z].*$
" command! -buffer Section vim /\v\C^[A-Z][^a-z]+$/ % | cwindow
" command! -buffer SubSection vim /\v\C^   [A-Z].*$/ % | cwindow

" although you can not search ilist result, it's aligned
com -buffer Section call s:select_ilist(execute('silent! ilist /\v\C^[A-Z][^a-z]+$/'))
com -buffer Optionx call s:select_ilist(execute('silent! ilist /\v\C^       \-\-?\w/'))
com -buffer SubSection call s:select_sub_section()

function s:select_ilist(ilist_result)
  if empty(a:ilist_result) || a:ilist_result =~# '^\_s*Error'
    return
  endif

  let select = input(a:ilist_result . "\ngoto : ")
  if empty(select) | return | endif

  " ilist result starts with '\nfilename\n', filename can be empty
  let lines = split(a:ilist_result[stridx(a:ilist_result, "\n", 1) : ], "\n")
  if select <= 0 || select > len(lines) | return | endif

  exec matchstr(lines[select-1], '^\v\s*\d+\:\s+\zs\d+')
endfunction

function s:select_sub_section()
  let cpos = getcurpos()
  let oldwrap = &wrap

  " won't work for last section, but it's always trivial
  NextSection | let endline = line('.')
  PrevSection | let startline = line('.')
  call setpos('.', cpos)
  let &wrap = oldwrap

  " note that silent only stop error from throwing, error message is still
  " returned from execute
  call s:select_ilist(execute(printf('silent! %d,%dilist /\v\C^   [A-Z].*$/', startline, endline)))
endfunction
