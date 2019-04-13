let s:timing = 0
let s:timeText = ''

function! misc#timer#startTimer(desc) abort
  if s:timing | call misc#timer#endTimer() | endif
  let s:scriptTimer = reltime()
  let s:timeText = a:desc
  let s:timeing = 1
endfunction

function! misc#timer#endTimer() abort
  if !s:timing
    echom s:timeText.' Done in '.reltimestr(reltime(s:scriptTimer)).' seconds'
    let s:timeing = 0
  endif
endfunction
