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

function! misc#op#literalCopyGrep(type, ...)
  let operand = misc#op#operand(a:type, a:0>0)
  call setreg(v:register, misc#literalizeGrep(operand[0]))
endfunction

" search pattern is <word> or literal
function! misc#op#substitude(type, ...)
  call call('misc#op#searchLiteral', [a:type] + a:000)
  let cmd = @/[2:] ==# expand('<cword>') ?
        \ printf(':%%s/\v<%s>/', expand('<cword>')) : ':%s//'
  call feedkeys(cmd)
endfunction
