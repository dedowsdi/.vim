function ddd#option#which_cinoptions() abort

  " test if cindent take effect
  if !empty(&indentexpr)
    echo "'indentexpr' exists, it overrides 'cindent'."
    return
  endif

  if !&cindent
    echo "'cindent' is currently disabled."
    return
  endif

  " test cinoption one by one

  " copied from :h cino- <ctrl-a> in vim8.2 1-677
  let opts = ['#','(',')','+','/',':','=','>','^','{','}','C','E','J','L','M',
        \ 'N','U','W','b','c','e','f','g','h','i','j','k','l','m','n','p','t',
        \ 'u','w','*']

  let indent = cindent(line('.'))
  let results = []
  let cinopt = &l:cinoptions

  for opt in opts
    try

      " test it with 8s, it should be big enough to make difference
      exe printf('setlocal cinoptions+=%s8s', opt)
      if indent != cindent(line('.'))
        let results += [opt]
      endif

    catch /.*/
      echom 'failed to test ' . opt
      echom 'internal error : ' . v:exception
    finally
      let &l:cinoptions = cinopt
    endtry
  endfor

  echohl Macro
  echom join(results)
  echohl None
endfunction
