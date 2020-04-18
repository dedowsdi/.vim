" Current implementation doesn't work well for large data.
"
" keys:
"   <cr> is remapped in normal and command mode to jump.
"   If you need to find next/previous search, you can use c-g and c-t in command
"   mode.
"   <c-y> is remapped in command as <cr>
"
"   <esc> is remapped in command mode to abort. If you want to return to normal
"   mode, use c-c or c-\c-n
"   If you want to abort in normal mode, use <c-w>q or :q
"
" sink:
"   a Funcref
"   a predefined sink name, it's value can be one of:
"     file     file name with optional leading numbers:
"                path
"                1 : path
"     line     lnum...
"     ilist    index:lnum ...
"     fline    file:line:...
"     tag      name\tpath\tline
"     btag     name\tline
"
" source:
"   a shell command, it must starts with !, it's executed as `exe 'read' a:source`
"
"   a regex pattern, it must starts with /, the / is just a marker, you don't
"   need to close it, the pattern will be used to execute ilist on current
"   buffer
"
"   a vim command such as oldfiles, it's executed as `:put! =execute(a:source)`
"
"   a vim Funcref, it's executed as `call a:source()`, the function is in
"   full charge of filling the hare buffer.
"
"   a List

" Note all source is applied after hare buffer cureated, the current
" buffer is the hare buffer, not the original one.
"
" ...:
"   keys feeded to feedkeys(), it defaults to `/\v<`
function misc#hare#jump(sink, source, ...) abort

  try
    let winid = win_getid()
    let bnr = bufnr()
    keepalt topleft new
    16wincmd _
    let b:hare_orig_winid = winid
    let b:hare_orig_buf = bnr
    set filetype=hare

    call s:fill_buffer(a:source)
    setlocal nomodifiable

    call s:install_map(a:sink)
    call s:install_autocmd()
    call feedkeys(a:0 > 0 ? a:1 : '/\v<', 'n')

  catch /.*/
    echohl WarningMsg
    echom v:exception
    echohl None

    wincmd q
  endtry
endfunction

" 1st string in cmd used as sink, others used as source
function misc#hare#exec(cmd) abort
  let l = matchlist(a:cmd, '\v^(\S+)\s+(.+)$')
  if empty(l)
    throw 'invalid cmd : ' . a:cmd
  endif

  let [sink, source] = l[1:2]
  call misc#hare#jump(sink, source)
endfunction

function s:fill_buffer(source) abort
  let stype = type(a:source)
  if stype == v:t_list
    call setline(1, a:source)
  elseif stype == v:t_string
    if empty(stype)
      throw 'empty source string'
    endif

    let c = a:source[0]
    if c==# '!'
      exe 'read' a:source
    elseif c==# '/'
      put! =win_execute(b:hare_orig_winid, printf('ilist! /%s/', a:source[1:]))
    else
      put! =execute(a:source)
    endif
  elseif stype == v:t_func
    call a:source()
  else
    throw 'unknown source type ' . stype
  endif
  1
endfunction

function s:install_map(sink) abort

  let stype = type(a:sink)

  if stype ==# v:t_func
    let Hare_sink = a:sink
  elseif stype ==# v:t_string
    if !has_key(s:default_sinks, a:sink)
      throw 'unknown sink ' . a:sink
    endif

    let Hare_sink = s:default_sinks[a:sink]
  else
    throw 'unknown sink type ' . a:sink
  endif

  exe printf('nnoremap <buffer> <cr>
        \ :call call(%s, [])<cr>', string(get(Hare_sink, 'name')))
  exe printf('cnoremap <buffer> <cr>
        \ <cr>:call call(%s, [])<cr>', string(get(Hare_sink, 'name')))
  cnoremap <buffer> <esc> <esc>:wincmd q<cr>
  cnoremap <buffer> <c-y> <cr>
endfunction

function s:install_autocmd() abort
  augroup au_hare_buffer | au!
    autocmd  WinLeave <buffer> call s:quit_hare()
  augroup end
endfunction

function s:quit_hare() abort
  exe win_id2win(b:hare_orig_winid) 'wincmd w'
endfunction

function s:close_hair_buffer() abort
  " let wid = b:hare_orig_winid
  wincmd q
  " exe  win_id2win(wid) 'wincmd w'
endfunction

function s:file_sink() abort
  let path = matchstr(getline('.'), '\v^(\d+\s*:?\s*)?\zs.+')
  if empty(path)
    throw 'Illegal file : ' . getline('.')
  endif
  call s:close_hair_buffer()
  call s:open_file(path)
endfunction

function s:line_sink() abort
  let lnum = matchstr(getline('.'), '\v^\s*\d+')
  if empty(lnum)
    throw 'Illegal line : ' . getline('.')
  endif
  call s:close_hair_buffer()
  exe lnum
endfunction

function s:ilist_sink() abort
  let lnum = matchstr(getline('.'), '\v^\s*\d+\s*:\s*\zs\d+')
  if empty(lnum)
    throw 'Illegal line : ' . getline('.')
  endif
  call s:close_hair_buffer()
  exe lnum
endfunction

function s:fline_sink() abort
  let l = matchlist(getline('.'), '\v^([^:]+)\s*:\s*(\d+):')
  if empty(l)
    throw 'Illegal tag line' . getline('.')
  endif

  let [path, lnum] = l[1:2]
  call s:close_hair_buffer()
  call s:open_file(path)
  exe lnum
endfunction

function s:tag_sink() abort
  let l = matchlist(getline('.'), '\v^[^\t]+\t([^\t]+)\t([^\t]+)')
  if empty(l)
    throw 'Illegal tag line' . getline('.')
  endif

  let parent_pattern = '\v^\!_TAG_PARENT_PATH\t*\zs.+'
  let [lnum, col] = searchpos(parent_pattern, 'bWn')
  let parent = lnum==0 ? '' : matchstr(getline(lnum), parent_pattern) . '/'

  let [path, pattern] = l[1:2]
  call s:close_hair_buffer()
  call s:open_file(parent . path)
  exe pattern
endfunction

function s:btag_sink() abort
  let l = matchlist(getline('.'), '\v^[^\t]+\t([^\t]+)')
  if empty(l)
    throw 'Illegal btag line' . getline('.')
  endif

  let pattern = l[1]
  call s:close_hair_buffer()
  exe pattern
endfunction

function s:open_file(path) abort
  let bnr = bufnr(a:path)
  if bnr == -1
    exe 'e' a:path
  elseif bnr != bufnr('')
    if bufwinid(bnr) != -1
      exe bufwinnr(bnr) 'wincmd w'
    else
      exe 'b' bnr
    endif
  endif
endfunction

let s:default_sinks = {
      \ 'file': function('s:file_sink'),
      \ 'ilist': function('s:ilist_sink'),
      \ 'line': function('s:line_sink'),
      \ 'fline': function('s:fline_sink'),
      \ 'tag': function('s:tag_sink'),
      \ 'btag': function('s:btag_sink'),
      \ }
