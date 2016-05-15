"udpate ctags async
"if exists("g:loadedcags")
"finish
"endif
"let g:loadedctags = 1
"

command! -nargs=* TA :call AppendProjCtags(<args>)
command! -nargs=* TR :call RecreateAllCtags(<args>)

function! s:JobHandler(job_id, data, event)
  if a:event == 'stdout'
    let str = self.shell.' stdout: '.join(a:data)
    call mycpp#util#warn(a:data)
  elseif a:event == 'stderr'
    call mycpp#util#warn(a:data)
  else
    if a:data
      call mycpp#util#warn("non 0 exit")
    endif
  endif

endfunction

let s:callbacks = {
      \ 'on_stdout': function('s:JobHandler'),
      \ 'on_stderr': function('s:JobHandler'),
      \ 'on_exit': function('s:JobHandler')
      \ }

function! s:execute(cmd)
  let job1 = jobstart(['bash', '-c', a:cmd ], extend({}, s:callbacks))
endfunction


""
" append project ctags, don't follow symbolic links
""
function! AppendProjCtags(...)
  let cmd = get(a:000, 0,
        \ 'ctags -R -a --sort=foldcase --links=no --c++-kinds=+p --c-kinds=+p
        \ --exclude=build --exclude=cmake --exclude=CMake')
  call s:execute(cmd)
endfunction

""
"recreate all ctags, follow symbolic links
""
function! RecreateAllCtags(...)
  let cmd = get(a:000, 0,
        \ 'ctags -R --sort=foldcase --links=yes --c++-kinds=+p --c-kinds=+p
        \ --exclude=build --exclude=cmake --exclude=CMake')
  call s:execute(cmd)
endfunction
