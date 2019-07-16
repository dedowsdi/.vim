function! misc#op#operand(type, visual)
  if a:visual
    return [misc#getVisualString(), visualmode()]
  else
    let vmode = a:type ==# 'line' ? 'V' : a:type ==# 'char' ? 'v' : "\<ctrl-v>"
    return [misc#getMarkString("'[", "']", vmode), vmode]
  endif
endfunction

function! misc#op#execute(type, visual, operator)
  if a:visual | exec 'norm gv'.a:operator | return | endif
  " backup last visual
  let [m0, m1, lvm] = [getpos("'<"), getpos("'>"), visualmode()]
  let vcmd = a:type ==# 'line' ? "'[V']" :  '`[v`]'
  exec 'norm '.vcmd.a:operator
  " restore last visual and cursor after that
  let pos = getcurpos()
  call setpos("'<", m0) | call setpos("'>", m1) | exec 'norm! `<'.lvm."`>\<esc>"
  call setpos('.', pos)
endfunction

function! misc#op#searchLiteral(type, ...)
  let @/ = misc#op#operand(a:type, a:0 > 0)[0]
  let @/ = misc#literalizeVim(@/)
endfunction

function! misc#op#literalGrep(type, ...)
  let operand = misc#op#operand(a:type, a:0>0)
  call setreg('"', misc#literalizeGrep(operand[0]))
  call feedkeys(":grep -F \<c-r>=@\"\<cr> ")
endfunction

" search pattern is <word> or literal
function! misc#op#substitude(type, ...)
  call call('misc#op#searchLiteral', [a:type] + a:000)
  call feedkeys(':%s//')
endfunction

function! misc#op#searchInBrowser(type, ...)
  let operand = misc#op#operand(a:type, a:0>0)
  silent! exec 'silent! !google-chrome "http://google.com/search?q=' . operand[0] . '" &>/dev/null &'
  redraw!
endfunction

" opfunc must be a real function, function reference won't work?
"
" (type, visual, cmd, wise)
function! misc#op#system(type, ...)
  let visual = get(a:000, 0, 0)
  let operand = misc#op#operand(a:type, visual)

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
function! misc#op#column(type, ...)
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

function! misc#op#clangFormat(type, ...)
  let curpos = getcurpos()
  let lines = getpos("'[")[1] . ':' . getpos("']")[1]
  let cmd = '%!clang-format -style=file -fallback-style=LLVM -lines=' . lines . ' ' . expand('%')
  call misc#log#debug('ClangFormat command : ' . cmd)
  silent exec cmd
  call setpos('.', curpos)
endfunction
