" Put simple plugin functions in this file

function ddd#browse(...)
  let path = expand(get(a:000, 0, '%:p'))
  call system(printf('google-chrome %s&', path))
endfunction

" type cmd character one by one with interval
function ddd#type(cmd) abort

  " spawn a timer_star for every char, the inner lambda call feedkeys with
  " captured current char. It doesn't care about mapping delay and keycode
  " delay, it just type one by one.
  call map(split(a:cmd, '\zs'),
        \ { i,v -> timer_start( g:type_interval * i, { t -> feedkeys(v) } ) })
endfunction

function ddd#close_finished_terminal() abort
  let bufs = map(split( execute('ls F'), "\n" ), {i,v -> matchstr(v, '\v^\s*\zs\d+')})
  for buf in bufs
    call win_execute(bufwinid(str2nr( buf )), 'close')
  endfor
endfunction

function ddd#win_fit_buf(extra_lines) abort
  let cview = winsaveview()
  try

    " I must find screen line count for current buffer, I don't know how to do
    " it directly, so I decide to maximize current window first, then shrink to
    " fit, I only need last screen line of current buffer this way.
    wincmd _

    " Clear scroll, goto last byte. I start this with ex 0 and $, but they don't
    " clear scroll until script finished.
    keepjump norm! ggG$

    exe printf('%dwincmd _',  winline() + a:extra_lines)
  finally
    cal winrestview(cview)
  endtry
endfunction

function ddd#format_table() abort
  try
    let cview = winsaveview()

    " match only last line of table. It's
    " | ..........| + (endof file | blank line | line that doesn't starts with |)
    g /\v^\s*\|.*\|\s*$%(%$|\n\s*%($|[^|]))/ exe "norm \<Plug>(EasyAlign)ip*|\<cr>"
  finally
    call winrestview(cview)
  endtry
endfunction

function ddd#camel_to_underscore(name) abort

  " change leading uppercase to lower case
  let s = substitute(a:name, '\v\C^[A-Z]', '\l\0', '')

  " change other uppercase to _lowercase
  return substitute(s, '\v\C[A-Z]', '_\l\0', 'g')
endfunction

function ddd#underscore_to_camel(name, leading_uppercase) abort
  let s = substitute(a:name, '\v\c_([a-z])', '\u\1', 'g')
  if a:leading_uppercase
    let s = substitute(s, '\v\C[a-z]', '\u\0', '')
  endif
  return s
endfunction

function ddd#reload_ftplugin(unlet_list) abort
  for var in a:unlet_list
    if exists(var)
      exe 'unlet' var
    endif
  endfor
  e
endfunction

" require git diff-highlight
function ddd#diff_line(lnum0, ...) abort
  let line0 = getline(a:lnum0)
  let line1 = getline(get(a:000, 0, '.'))
  let cmd = printf( 'diff -u --color=always <(echo %s) <(echo %s) | diff-highlight',
        \ shellescape(line0, 1), shellescape(line1, 1) )
  " exe 'term' cmd
  call term_start(['bash', '-c', cmd])
endfunction
