function ddd#proj#load_map(type)
  if a:type ==# 'c' || a:type ==# 'cpp'

    if exists('$CPP_BUILD_DIR') && filereadable(printf('%s/Makefile', $CPP_BUILD_DIR))
      let g:ddd_gterm_init_cmd = get(g:, 'ddd_gterm_init_cmd', []) +
            \ [ printf('cd %s', $CPP_BUILD_DIR) ]
    endif

    if filereadable('./CMakeLists.txt')
      let &makeprg = printf('make -j 3 -sC "%s"', $CPP_BUILD_DIR)
    endif
  endif
endfunction
