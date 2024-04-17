" replace empty string with value in source
function s:extend_blank(target, source) abort
  for [key, value] in items(a:source)
    if !has_key(a:target, key) || empty(a:target[key])
      let a:target[key] = value
    endif
  endfor
endfunction

" opts : {"jump":bool}
function ddd#cpp#goto_last_include(...) abort
  "keepjumps normal! G
  let opts = get(a:000, 0, {'jump':0})
  let jump_flag = opts.jump ? 's' : ''
  if !search('\v^\s*#include', 'bW'.jump_flag)
    "if not found, goto 1st blank line
    keepjumps normal! gg
    if !search('\v^\s*$')
      call dddu#warn("don't know where last include is") | return 0
    endif
  endif
  normal! zz
  return 1
endfunction

function ddd#cpp#debug_toggle_break()
  if empty(sign_getplaced('', {'lnum':9, 'group':''})[0].signs)
    Break
  else
    Clear
  endif
endfunction

function ddd#cpp#include_osg() abort
  let class_name = matchstr(getline('.'),
        \ printf('\v%%<%dc<osg\w*::\w+>%%>%dc', col('.') + 1, col('.')) )

  if empty(class_name)
    return
  endif

  let head = printf('#include <%s>', substitute(class_name, '::', '/', 'g'))
  if searchpos('\V\C\^\s\*' . head, 'bnW')[0] != 0
    call ddd#log#notice(head . ' already exists, skipped')
    return
  endif

  " try osg block
  let lnum = searchpos('\v\C^\#include\s*\<osg', 'bnW')[0]

  " try other include block
  if lnum == 0
    let lnum = searchpos('\v^\#include\s*["<]', 'bnW')[0]
  endif

  if lnum != 0
    call append(lnum, head)
  else

    " no include, this must be a new file, try the first #define
    try
      let cview = winsaveview()
      keepjump norm! gg
      let lnum = searchpos('\v^\#define\s+\S+', 'Wn')[0]
    finally
      call winrestview( cview )
    endtry
    call append(lnum, head)
    call append(lnum, '')
  endif

  " avoid :h :echo-redraw
  redraw
  call ddd#log#notice(head)
endfunction
