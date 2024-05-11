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

let s:opt_stack = {}

" [val]
" push current option value, set option value to [val] or default value.
function ddd#option#push(global, name, ...) abort
  let oname = printf('%s:%s', a:global ? 'g' : 'l', a:name)
  exe printf('let bak = &%s', oname)
  call extend(s:opt_stack, {oname : []}, 'keep')
  let s:opt_stack[oname] += [bak]

  if a:0 > 0
    exe printf('let &%s = %s', oname, string(a:1))
  else
    exe printf('setglobal %s&', a:name)
  endif
endfunction

function ddd#option#pop(global, name) abort
  let oname = printf('%s:%s', a:global ? 'g' : 'l', a:name)
  if !has_key(s:opt_stack, oname)
    echohl WarningMsg
    echo 'Empty stack, nothing to pop'
    echohl None
    return
  endif

  exe printf('let &%s = %s', oname, string(s:opt_stack[oname][-1]))
  call remove(s:opt_stack[oname], -1)
endfunction
