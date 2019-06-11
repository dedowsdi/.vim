let g:notify_severity = get(g:, 'notify_severity', 3)
let g:NOTIFY_ALWAYS = 0
let g:NOTIFY_FATEL = 1
let g:NOTIFY_WARN = 2
let g:NOTIFY_NOTICE = 3
let g:NOTIFY_INFO = 4
let g:NOTIFY_DEBUG = 5
let g:NOTIFY_TRIVIAL = 6

function! s:notify(msg, ...) abort
  let lvl = get(a:000, 0, g:NOTIFY_NOTICE)
  if lvl > g:notify_severity | return | endif
  if lvl == g:NOTIFY_FATEL
    echoe a:msg
  else
    echom a:msg
  endif
endfunction

function! misc#log#always(msg) abort
  call s:notify(a:msg, g:NOTIFY_ALWAYS)
endfunction
function! misc#log#fatel(msg) abort
  call s:notify(a:msg, g:NOTIFY_FATEL)
endfunction
function! misc#log#warn(msg) abort
  call s:notify(a:msg, g:NOTIFY_WARN)
endfunction
function! misc#log#notice(msg) abort
  call s:notify(a:msg, g:NOTIFY_NOTICE)
endfunction
function! misc#log#info(msg) abort
  call s:notify(a:msg, g:NOTIFY_INFO)
endfunction
function! misc#log#debug(msg) abort
  call s:notify(a:msg, g:NOTIFY_DEBUG)
endfunction
function! misc#log#trivial(msg) abort
  call s:notify(a:msg, g:NOTIFY_TRIVIAL)
endfunction
