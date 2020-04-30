function ddd#proj#load_map(type)
  if a:type ==# 'c' || a:type ==# 'cpp'
    nnoremap <c-f2> :Evaluate<cr>
    vnoremap <c-f2> :<c-u>Evaluate<cr>
    nnoremap <f9> :CppDebugToggleBreak<cr>

    if exists('$CPP_BUILD_DIR') && filereadable(printf('%s/Makefile', $CPP_BUILD_DIR))
      let g:ddd_gterm_wd = $CPP_BUILD_DIR
    endif

    if filereadable('./CMakeLists.txt')
      let &makeprg = printf('make -j 3 -sC "%s"', $CPP_BUILD_DIR)
    endif
  endif
endfunction
