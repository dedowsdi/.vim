let g:ddd_notify_severity = get(g:, 'ddd_notify_severity', 3)
let g:NOTIFY_ALWAYS = 0
let g:NOTIFY_FATEL = 1
let g:NOTIFY_WARN = 2
let g:NOTIFY_NOTICE = 3
let g:NOTIFY_INFO = 4
let g:NOTIFY_DEBUG = 5
let g:NOTIFY_TRIVIAL = 6

function s:notify(msg, ...) abort
  let lvl = get(a:000, 0, g:NOTIFY_NOTICE)
  if lvl > g:ddd_notify_severity | return | endif
  if lvl == g:NOTIFY_FATEL
    echoe a:msg
  else
    echom a:msg
  endif
endfunction

function ddd#log#set_notify_severity(v)
  let severity = min([a:v, g:NOTIFY_TRIVIAL])
  let severity = max([a:v, 0])
  let g:ddd_notify_severity = severity
  let names = [
        \ 'NOTIFY_ALWAYS',
        \ 'NOTIFY_FATEL',
        \ 'NOTIFY_WARN',
        \ 'NOTIFY_NOTICE',
        \ 'NOTIFY_INFO',
        \ 'NOTIFY_DEBUG',
        \ 'NOTIFY_TRIVIAL',
        \ ]
  call ddd#log#notice('set g:ddd_notify_severity to ' . names[g:ddd_notify_severity] )
endfunction

function ddd#log#always(msg) abort
  call s:notify(a:msg, g:NOTIFY_ALWAYS)
endfunction
function ddd#log#fatel(msg) abort
  call s:notify(a:msg, g:NOTIFY_FATEL)
endfunction
function ddd#log#warn(msg) abort
  call s:notify(a:msg, g:NOTIFY_WARN)
endfunction
function ddd#log#notice(msg) abort
  call s:notify(a:msg, g:NOTIFY_NOTICE)
endfunction
function ddd#log#info(msg) abort
  call s:notify(a:msg, g:NOTIFY_INFO)
endfunction
function ddd#log#debug(msg) abort
  call s:notify(a:msg, g:NOTIFY_DEBUG)
endfunction
function ddd#log#trivial(msg) abort
  call s:notify(a:msg, g:NOTIFY_TRIVIAL)
endfunction
