" async make
"
" update quickfix after it, you can see the making progress if you set
" g:ddd_make_hddden to 0.
"
" Show make successful message if no error, no warning happens.
"
" Show found n qf entries if there exists quickfix entry with specific buffer
" number and line number.
"
" Toggle making buffer if user request make again during making.
"
" Delete last making buffer if new making starts.

let g:ddd_make_hidden = get(g:, 'ddd_make_hidden', 1)
let g:ddd_make_split = get(g:, 'ddd_make_split', '16split')
let g:ddd_make_success_cb = get(g:, 'ddd_make_success_cb', '')
let s:making = 0

augroup ag_ddd_make | au! | augroup end

function ddd#make#make(run_success_cb, args) abort
  if s:making
    if bufwinid(s:make_buf) == -1
      " show making buffer
      exe g:ddd_make_split
      exe 'b' s:make_buf
      setlocal winfixwidth winfixheight
      let &statusline = s:make_cmd
      echo s:make_cmd
      wincmd p
    else
      " hide making buffer
      exe printf('%d wincmd q', bufwinnr(s:make_buf))
    endif
    return
  endif

  " wipe last result (don't use delete, otherwise you will see (1) in terminal
  " buffer name )
  if exists('s:make_buf') && bufexists(s:make_buf)
    silent! exe 'bwipe' s:make_buf
  endif

  " spawn new make
  let s:make_cmd = &makeprg
  if !empty(a:args)
    let s:make_cmd .= ' ' . a:args
  endif

  echo s:make_cmd

  " use term_opencmd to stop vim from wipe finished terminal buffer after it's
  " closed
  let options = {'close_cb': function('s:close_cb'),
        \ 'term_finish' : 'open',
        \ 'term_opencmd' : 'call setbufvar(%d, "&buftype", "")' }

  if a:run_success_cb
    let options.exit_cb = function('s:exit_cb')
  endif

  if g:ddd_make_hidden
    let options.hidden = 1
    let s:make_buf = term_start(s:make_cmd, options)
  else
    exe g:ddd_make_split
    setlocal winfixwidth winfixheight
    let options.curwin = 1
    let s:make_buf = term_start(s:make_cmd, options)
    wincmd p
  endif

  let s:making = 1
endfunction

function s:exit_cb(job, status) abort
  if a:status != 0 || empty(g:ddd_make_success_cb)
    return
  endif

  if type(g:ddd_make_success_cb) == v:t_func
    call call(g:ddd_make_success_cb(), [])
  elseif type(g:ddd_make_success_cb) == v:t_string
    exe g:ddd_make_success_cb
  else
    throw 'Illegal success callback, it should be FuncRef or String'
  endif
endfunction

function s:close_cb(channel) abort

  " look, you can not get buffer content directly here.
  call timer_start(10, function('s:make_callback_impl'))
endfunction

function s:make_callback_impl(timer) abort

  exe 'cgetbuffer' s:make_buf

  " consider entry with num zero bufnr and lnum an error or warning
  let qfl = filter(getqflist(), {k,v -> v.bufnr != 0 && v.lnum != 0})

  if empty(qfl)
    echohl htmlTagName
    echo 'make successful'
    echohl None
  else
    echohl WarningMsg
    echom printf('found %d qf entries', len(qfl))
    echohl None
  endif

  let s:making = 0
endfunction

function ddd#make#complete(arg_lead, cmd_line, cursor_pos) abort
  let Cpfunc = function('s:make_help_complete')

  if has_key(g:, 'ddd_make_complete_callback')
    let cbtype = type(g:ddd_make_complete_callback)
    if cbtype == v:t_func
      let Cpfunc = g:ddd_make_complete_callback
    else
      let Cpfunc = s:make_complete_callbacks[g:ddd_make_complete_callback]
    endif
  endif

  return Cpfunc(a:arg_lead, a:cmd_line, a:cursor_pos)
endfunction

function ddd#make#progress() abort
  if s:making
    let s = getbufline(s:make_buf, '$')[0]
    return len(s) > 20 ? s[0:19] . '...' : ''
  else
    return ''
  endif
endfunction

function s:make_help_complete(arg_lead, cmd_line, cursor_pos) abort
  let cmd = printf('%s -s help | sed -E ''s/^\.\.\.\s+//'' ', &makeprg)
  let targets = systemlist(cmd)
  return sort(filter(targets, {i,v -> stridx(v, a:arg_lead) == 0}))
endfunction

function s:make_qp_complete(arg_lead, cmd_line, cursor_pos) abort
  " https://unix.stackexchange.com/a/230050/344312
  let cmd = printf('%s -qp | awk -F":" ''/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}'' | sort -u ', &makeprg)
  let targets = systemlist(cmd)
  return sort(filter(targets, {i,v -> stridx(v, a:arg_lead) == 0}))
endfunction

let s:make_complete_callbacks = {
      \ 'make_help' : function('s:make_help_complete'),
      \ 'make_qp' : function('s:make_qp_complete'),
      \ }
