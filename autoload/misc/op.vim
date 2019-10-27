" return [text, wise]
function! misc#op#get_oeprand(type, visual) abort
  if a:visual
    return [misc#get_visual_string(), visualmode()]
  else
    let vmode = a:type ==# 'line' ? 'V' : a:type ==# 'char' ? 'v' : "\<ctrl-v>"
    return [misc#get_mark_string("'[", "']", vmode), vmode]
  endif
endfunction

function! misc#op#visual_select_operand(type, visual, mark_only) abort
  if a:visual
    exec 'norm gv'
  else
    let vmode = a:type ==# 'line' ? 'V' : a:type ==# 'char' ? 'v' : "\<c-v>"
    exe printf("norm! `[%s`]\<esc>%s", vmode, a:mark_only ? "\<esc>" : "")
  endif
endfunction

" op can be opfunc or mapping
function! misc#op#execute(op, type, visual) abort
  call misc#op#visual_select_operand(a:type, a:visual, 0)
  if exists('*'.a:op)
    call call (a:op, [a:type] + a:000)
  else
    exec 'norm!' a:op
  endif
endfunction

function! misc#op#search_literal(type, ...) abort
  let @/ = misc#op#get_oeprand(a:type, a:0 > 0)[0]
  let @/ = misc#literalize_vim(@/)
endfunction

function! misc#op#literal_grep(type, ...) abort
  let operand = misc#op#get_oeprand(a:type, a:0>0)
  call setreg('"', misc#literalize_grep(operand[0]))
  call feedkeys(":grep -F \<c-r>=@\"\<cr> ")
endfunction

" search pattern is <word> or literal
function! misc#op#substitude(type, ...) abort
  call call('misc#op#search_literal', [a:type] + a:000)
  call feedkeys(':%s//')
endfunction

function! misc#op#search_in_browser(type, ...)
  let operand = misc#op#get_oeprand(a:type, a:0>0)
  silent! exec 'silent! !google-chrome "http://google.com/search?q=' . operand[0] . '" &>/dev/null &'
  redraw!
endfunction

" opfunc must be a real function, function reference won't work?
"
" (type, visual, cmd, wise)
function! misc#op#system(type, ...) abort
  let visual = get(a:000, 0, 0)
  let operand = misc#op#get_oeprand(a:type, visual)

  let cmd = get(a:000, 1, '')
  if empty(cmd)
    let cmd = input('shell command : ')
    if empty(cmd) | return | endif
  endif

  let wise = get(a:000, 2, '')
  if empty(wise)
    let wise = input('wise : ')
    if empty(wise) | return | endif
  endif

  call setreg(v:register, system(cmd, operand[0]), wise)
endfunction

" a-b        : range(a, b)
" a,b        : a and b
" a-         : a until last
" -b         : 1 until b
function! misc#op#column(type, ...) abort
  let column = input('column : ')
  if empty(column) || column <= 0 | return | endif

  let cmd = ''
  let first = 1
  for item in split(column, ',')

    " print OFS for non first item
    if !first
      let cmd .= ' printf OFS;'
    endif
    let first = 0

    if item =~# '-'
      let [i0, i1] = split(item, '\v\s*\-\s*', 1)
      if i0 ==# '' | let i0 = 1 | endif

      if i1 ==# ''

        " print until last filed
        let cmd .= printf('for(i=%d;i<=NF;i++) {printf "%%s", (i==%d ? "" : OFS) $i}; ', i0, i0)
      else
        let cmd .= ' printf "%s", ' . join(map(range(i0, i1), '''$'' . v:val'), ' OFS ') . ';'
      endif
    else
      let cmd .= printf('printf "%%s", $%d; ', item)
    endif
  endfor
  let cmd .= ' printf "\n";'
  let cmd = printf("awk '{%s}' ", cmd)

  call misc#log#debug('column commmand : ' . cmd)

  call call ('misc#op#system', [a:type] + [get(a:000, 0, 0), cmd, 'b'])
endfunction

function! misc#op#clang_format(type, ...) abort

  " clang-format.py will check l:lines to determine range
  let l:lines = printf('%d:%d', getpos("'[")[1], getpos("']")[1])
  let cmd = printf('py3file %s', g:clang_format_py_path)
  call misc#log#debug('ClangFormat command : ' . cmd)
  exec cmd
endfunction

function! misc#op#setup_keep_cursor(func)
  let &opfunc = a:func
  call s:store_cursor()
  return 'g@'
endfunction

function! s:restore_cursor() abort
  if !exists('s:cpos')
    return
  endif
  call setpos('.', s:cpos)
endfunction

function! s:store_cursor() abort
  let s:cpos = getcurpos()
endfunction

" mimic https://github.com/t9md/atom-vim-mode-plus/wiki/OccurrenceModifier
function! misc#op#co_old(type, ...) abort

  if a:0
    throw "dont call ChangeWords in visual mode"
  end

  let visual = a:0 > 0

  " setup search pattern, restrict it in operator text
  let cword = @@
  let cword_len = len(cword)
  if cword_len == 1
    let @/ = printf('\v%%V<%s>', cword)
  else
    let @/ = printf('\v%%V<%s%%V%s>', cword[0:-2], cword[-1:-1])
  endif

  call misc#op#visual_select_operand(type, visual, 0)

  call feedkeys(":s///g\<left>\<left>", 'n')
endfunction

" mimic https://github.com/t9md/atom-vim-mode-plus/wiki/OccurrenceModifier
" omo short for Occurence Modifier Operator
function! misc#op#omo(operator) abort
  let s:omo_old_mark_a = getpos("'a")
  " there is no way to get current word in opfunc, must mark it here
  norm! "_yiw
  norm! ma
  exe 'set opfunc=misc#op#omo_' . a:operator . 'o'
  call feedkeys('g@')
endfunction

function! misc#op#omo_co(type, ...) abort

  let visual = a:0 > 0
  call misc#op#visual_select_operand(a:type, visual, 1)

  " hook callback
  augroup mo_co_insert
    au!
    autocmd InsertLeave <buffer> ++once call s:co_insert_leave()
  augroup end

  " go back to starting position, change current word
  norm! `a

  call feedkeys('ciw')

endfunction

function! misc#op#omo_do(type, ...) abort
  call misc#op#execute('misc#op#omo_co', a:type, a:0 > 0)
  call feedkeys("\<esc>")
endfunction

function! misc#op#omo_guo(type, ...) abort
  let str = tolower(expand('<cword>'))
  call misc#op#execute('misc#op#omo_co', a:type, a:0 > 0)
  call feedkeys(printf("%s\<esc>", str))
endfunction

function! misc#op#omo_gUo(type, ...) abort
  let str = toupper(expand('<cword>'))
  call misc#op#execute('misc#op#omo_co', a:type, a:0 > 0)
  call feedkeys(printf("%s\<esc>", str))
endfunction

function! s:co_insert_leave() abort

  let cword = @"
  let replacement = misc#get_last_change()
  let is_word = cword !~# '\W'
  try
    " undo last change, all change are done in following :substitute, this also
    " make sure `< and `> is still valid.
    norm! u

    " mark visual end with special string mark
    norm `>
    let visual_end_mark = repeat("\x82", 8)
    " use append instead of insert to take care of line end visual end.
    call misc#append_string_mark(visual_end_mark)

    " mark first change with special string mark that ends with space, so it
    " doesn't pollute the word boundary
    norm! `a
    let first_change_mark = repeat("\x81", 8) . ' '
    call misc#insert_string_mark(first_change_mark)

    " setup search pattern, restrict it in operator text
    let cword_len = len(cword)
    if is_word
      if cword_len == 1
        let @/ = printf('\v%%V<%s>', cword)
      else
        let @/ = printf('\v%%V<%s%%V%s>', cword[0:-2], cword[-1:-1])
      endif
    else
      let w = escape(cword, '\')
      if cword_len == 1
        let @/ = printf('\V\%%V%s', w)
      else
        let @/ = printf('\V\%%V%s\%%V%s', w[0:-2], w[-1:-1])
      endif
    endif

    call misc#log#debug('omo : @/ : ' . @/)

    " scale visual area after change
    norm! `<v
    call misc#search_string_mark(visual_end_mark)
    exe "norm! \<esc>"

    " replace all except the starting one
    let cmd = printf("'<,'>s//%s/eg", substitute(replacement, '\n', '\r', 'g'))
    call misc#log#debug('omo : substitute : ' . cmd)
    exe cmd

  finally
    " clear string marks
    norm! `a^
    call misc#search_string_mark(visual_end_mark)
    call misc#remove_string_mark(visual_end_mark)
    norm! `a^
    call misc#search_string_mark(first_change_mark)
    call misc#remove_string_mark(first_change_mark)
    let @@ = cword
    call setpos("'a", s:omo_old_mark_a)
  endtry
endfunction
