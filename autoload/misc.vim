function! misc#warn(mes) abort
  echohl WarningMsg | echom a:mes | echohl None
endfunction

" a hack, maybe i should do it in another way
function! misc#hasjob(job) abort
  try
    call jobpid(a:job) | return 1
  catch /^Vim\%((\a\+)\)\=:E900/ " catch error E900
    return 0
  endtry
endfunction

" check if quickfix window is open
"function! misc#isQfListOpen() abort
  "for i in range(1, winnr('$'))
    "let bufnr = winbufnr(i)
    "if getbufvar(bufnr, '&buftype') ==# 'quickfix'
      "return 1
    "endif
  "endfor
  "return 0
"endfunction

" is this necessary?
function! misc#open(file) abort
  let nr = bufnr(a:file)
  if nr != -1
    exec printf('buffer %d', nr)
  else
    exec printf('edit %s', a:file)
  endif
endfunction

" return [0,1), it's time based, it's awful.
function! misc#rand_by_time() abort
  " there are 6 digits after . of reltimestr
  return str2nr(matchstr(reltimestr(reltime()), '\v\.\zs\d+')[1:]) / 100000.0
endfunction

let s:rndm_m1 = 32007779 + (localtime()%100 - 50)
let s:rndm_m2 = 23717810 + (localtime()/86400)%100
let s:rndm_m3 = 52636370 + (localtime()/3600)%100

" copied from https://github.com/posva/Rndm
function! misc#rand()
    let m4= s:rndm_m1 + s:rndm_m2 + s:rndm_m3
    if( s:rndm_m2 < 50000000 )
        let m4= m4 + 1357
    endif
    if( m4 >= 100000000 )
        let m4= m4 - 100000000
        if( m4 >= 100000000 )
            let m4= m4 - 100000000
        endif
    endif
    let s:rndm_m1 = s:rndm_m2
    let s:rndm_m2 = s:rndm_m3
    let s:rndm_m3 = m4
    "return s:rndm_m3
    return s:rndm_m3 / 100000000.0
endfun

function! misc#get_c(lnum, cnum) abort
  return matchstr(getline(a:lnum), '\%' . a:cnum . 'c.')
endfunction
function! misc#get_cc() abort
  return misc#get_c(line('.'), col('.'))
endfunction

function! misc#get_v(lnum, vnum) abort
  return matchstr(getline(a:lnum), '\%' . a:vnum . 'v.')
endfunction
function! misc#get_vv() abort
  return misc#get_v(line('.'), col('.'))
endfunction

" search until one of expr found, ignore everything in pairs, doesn't include
" current character
" jump_pairs and expr should be completely different
" expr : desired pattern
" jump_pairs : such as (<{[ or )>}], when meet, execute %
function! misc#search_over_pairs(expr, jump_pairs, flags) abort

  let search_expr = '\v[' . a:expr . escape(a:jump_pairs, ']') . ']'
  " c in flags will be used only for the 1st time search.
  let [first_time, flags] = [1, a:flags]
  while search(search_expr, flags)
    if first_time
      let first_time = 0
      let flags = substitute(flags, 'c', '', 'g')
    endif
    if stridx(a:expr, misc#get_cc()) != -1
      return 1
    else
      keepjumps normal! %
    endif
  endwhile
  return 0

endfunction

function! misc#visual_select(range, mode) abort
  " note that '< and '> are not changed during the entire script lifetime. I
  " guess 'normal ' .. is pending ?
  call setpos('.', a:range[0]) | exec 'normal! ' . a:mode | call setpos('.', a:range[1])
endfunction

function! misc#swap_range(range0, range1, mode) abort
  if misc#cmp_pos(a:range0[0], a:range1[0]) < 0
     let [left_range, right_range] = [a:range0, a:range1]
  else
     let [left_range, right_range] = [a:range1, a:range0]
  endif

  " replace right rangre 1st, otherwise left range will be corrupted
  let tmp = misc#get_range(right_range, a:mode)
  call misc#replace_range(right_range, misc#get_range(left_range, a:mode), a:mode)
  call misc#replace_range(left_range, tmp, a:mode)
endfunction

function! misc#get_range(range, mode) abort
  return misc#get_pos_strng(a:range[0], a:range[1], a:mode)
endfunction

function! misc#replace_range(range, content, mode) abort
  let [cursor_pos, paste, reg_text, reg_type]= [getcurpos(), &paste, @a, getregtype('a')]
  try
    let [&paste, @a]= [1, a:content]
    call misc#visual_select(a:range, a:mode)
    silent normal! "ap
  finally
    call setpos('.', cursor_pos) | let &paste = paste | call setreg('a', reg_text, reg_type)
  endtry
endfunction

"return new trimed characterwise range
function! misc#trim_range(range) abort
  let pos = getcurpos() | try
    let new_range = deepcopy(a:range)

    call setpos('.', a:range[0]) | call search('\v\S', 'cW') | let new_range[0] = getpos('.')
    call setpos('.', a:range[1]) | call search('\v\S', 'bcW') | let new_range[1] = getpos('.')

    return new_range
  finally | call setpos('.', pos) | endtry
endfunction

function! misc#cmp_pos(lhs, rhs) abort
  if a:lhs[0] != a:rhs[0]
    throw 'cmp_pos support only pos on the same buffer'
  endif

  if a:lhs[1] < a:rhs[1]
    return -1
  elseif a:lhs[1] > a:rhs[1]
    return 1
  elseif a:lhs[2] < a:rhs[2]
    return -1
  elseif a:lhs[2] > a:rhs[2]
    return 1
  endif

  return 0
endfunction

function! misc#translate_pos(pos, step) abort
  let [start_line, start_col]= [line('.'), col('.')] | try
    call cursor(a:pos)
    if(a:step < 0)
      call misc#char_left(-a:step)
    else
      call misc#char_right(a:step)
    endif
    return getpos('.')[1:2]
  finally | call cursor(start_line, start_col) | endtry
endfunction

function! misc#char_right(...) abort
  let step = get(a:000, 0, 1)
  " are there any option the same as backspace ?
  exec 'normal! '.step.' '
endfunction

function! misc#char_left(...) abort
  let step = get(a:000, 0, 1)
  let backspace = &backspace|try
    let &backspace='indent,eol,start' 
    exec 'normal! '.step.''
  finally|let &backspace = backspace|endtry
endfunction

function! misc#trim(s, ...) abort
  let no_left = get(a:000, 0, 0)
  let no_right = get(a:000, 1, 0)
  let res = a:s
  if !no_left|let res = matchstr(res, '\v^\s*\zs.*')|endif
  if !no_right|let res = matchstr(res, '\v.{-}\ze\s*$')|endif
  return res
endfunction

"add lnum, cnum to jump list
function! misc#create_jumps(lnum,cnum) abort
  let [start_line, start_col]= [line('.'), col('.')] | try
    let oldpos = getpos('.')

    call cursor(a:lnum, a:cnum)
    normal! m'

  finally
    call setpos('.', oldpos)
  endtry
endfunction

function! misc#synstack()
  if !exists('*synstack') | return | endif
  return map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" copy last visual without side effect. Won't work for <c-v>$
function! misc#get_visual_string() abort
  return misc#get_mark_string("'<", "'>", visualmode())
endfunction

function! misc#get_mark_string(m0, m1, vmode)
  return misc#get_pos_string(getpos(a:m0), getpos(a:m1), a:vmode)
endfunction

function! misc#get_pos_string(p0, p1, vmode)
  let [lnum1, col1] = a:p0[1:2]
  let [lnum2, col2] = a:p1[1:2]
  let lines = getline(lnum1, lnum2)
  if a:vmode =~# "\<c-v>"
    let lines = map(lines, 'v:val[col1-1 : col2-1]')
  elseif a:vmode ==# 'V'
    let lines[-1] .= "\n"
  else
    let lines[-1] = lines[-1][:col2 - 1]
    let lines[0] = lines[0][col1 - 1:]
  endif
  return join(lines, "\n")
endfunction

function! misc#literalize_vim(str)
    return '\V' . substitute(escape(a:str, '\'), '\n', '\\n', 'g')
endfunction

function! misc#literalize_grep(str)
  let s = substitute(a:str, "'", "'\\\\''", 'g')
  return printf("'%s'", escape(s, '%#|'))
endfunction

function! misc#switch_rtp(path) abort
  if !has_key(s:, 'original_rtp') | let s:original_rtp = &rtp | endif
  let &rtp = printf('%s,%s,%s', s:original_rtp, a:path, a:path.'/after')
endfunction

function! s:get_help_file(tag) abort
  let throw_msg=''
  try
    let tags_bak = &tags
    let &tags = $VIMRUNTIME . '/doc/tags'
    let l = taglist('\V\C\^' . escape(a:tag, '\') . '\$')

    " very weird, if i combime throw and if to one line, it doesn't throw ...
    if empty(l)
      throw a:tag . ' not found'
    endif
    if len(l) > 1
      throw 'multiple tags found : ' . string(l)
    endif
    return fnamemodify(l[0].filename, ':t')
  finally
    let &tags = tags_bak
  endtry
endfunction

function! misc#create_vimhelp_link(tag) abort
  let anchor = substitute(a:tag, '[^a-zA-Z_\-]',
        \ '\=printf("%%%2X", char2nr(submatch(0)))', 'g')
  return 'https://vimhelp.org/' . s:get_help_file(a:tag) . '.html#' . anchor
endfunction

function! misc#create_nvimhelp_link(tag) abort
  return 'https://neovim.io/doc/user/' .
        \ fnamemodify(s:get_help_file(a:tag), ':r') . '.html#' . a:tag
endfunction

" 0 vim
" 1 nvim
function! misc#update_link(type) abort
  " clear link, delete \ before [ or ] in link clause
  %s/\v\[\s*(\:h(elp)?\s*\S+)\]\s*\[\d+\]/\=substitute(submatch(1), '\v\\\ze[\[\]]','','g')/ge
  g/\v^\[\d+\]\s*\:\s*http.*$/d

  let link_dict = {}
  let [reg_text, reg_type] = [@", getregtype('"')]
  let paste_back = &paste
  " avoid auto wrap if line exceeds textwidth
  set paste
  try
    let idx = 1 | norm! gg
    let @/ = '\v\:h(elp)?\s+\S+'
    while search(@/, 'Wc')
      norm! ygn
      let tag = matchstr(@", '\v\S+$')
      " escape [ and ]
      let link_text = substitute(@", '\v[\[\]]', '\\\0', 'g')
      let link_idx = has_key(link_dict, tag) ? link_dict[tag] : idx
      exec printf('norm! cgn[%s][%d]', link_text, link_idx)
      if has_key(link_dict, tag) | continue | endif
      let link = a:type == 0 ?
            \ misc#create_vimhelp_link(tag) : misc#create_nvimhelp_link(tag)
      let link = printf('[%d]:%s', idx, link)
      call append(line('$'), link)
      let link_dict[tag] = idx
      let idx += 1
    endwhile
  finally
    call setreg('"', reg_text, reg_type)
    let &paste = paste_back
  endtry
endfunction

function! misc#create_test_map()
  for i in range(1, 12)
    exec printf('map <buffer> <f%d> :echo "f%d"<cr>', i, i)
    exec printf('map <buffer> <c-f%d> :echo "c-f%d"<cr>', i, i)
    exec printf('map <buffer> <s-f%d> :echo "s-f%d"<cr>', i, i)
  endfor nnoremap <buffer> <c-left> :echo 'c-left'<cr>
  nnoremap <buffer> <c-right> :echo 'c-right'<cr>
endfunction

function! misc#camel_to_underscore(name)
  let s = substitute(a:name, '\v\C^[A-Z]', '\l\0', '')
  return substitute(s, '\v\C[A-Z]', '_\l\0', 'g')
endfunction

function! misc#complete_expresson(backward)
  let l = matchlist(getline('.'), printf('\v(.*)(<\w+)\zs%%%dc', col('.')))
  if empty(l) || l[2] ==# ''
    return ''
  endif
  let start_col = len(l[1])+1
  let base = l[2]

  let view = winsaveview()

  " place cursor at start of current WORD
  norm! B
  let cpos = getcurpos()
  let pattern = '\v<'.base

  " collection completion before cursor
  let part0 = []
  while search(pattern, 'bW')
    norm yie
    let part0 = [ @" ] + part0
  endwhile

  " collection completion after cursor
  call setpos('.', cpos)
  let part1 = []
  while search(pattern, 'W')
    norm yie
    let part1 = part1 + [ @" ]
  endwhile

  call winrestview(view)

  " join completions, follow in the same convention as ctrl-p and ctrl-n
  call complete(start_col, part1 + part0)
  if a:backward
    " are there other ways to do this ?
    call feedkeys(repeat("\<c-p>", 2))
  endif
  return ''
endfunction

" get change from `[ to `](exclusive), note that if backspace past `[, you won't
" get that part of change.
function! misc#get_last_change() abort
  " try
  "   let [reg_type, reg_content, old_ve] = [@@, getregtype('"'), &virtualedit]
  "   " mark motion is exclusive, but it can't past end of line if 've' is empty
  "   set ve=onemore
  "   let end_with_blank_line = getpos("']")[2] == 1
  "   norm! `[y`]
  "   let change = @@
  "   return end_with_blank_line ? change . "\<cr>" : change
  " finally
  "   call setreg('"', reg_content, reg_type)
  "   let &ve = old_ve
  " endtry

  let pos0 = getpos("'[")
  let pos1 = getpos("']")

  " mark motion is exclusive. It's possible that pos1[2]-1 = 0, it's a blank
  " line in this case.
  let pos1[2] -= 1
  return misc#get_pos_string(pos0, pos1, 'v')
endfunction

function! s:default_string_mark()
  return repeat("\x80", 8)
endfunction

" add string mark at cursor
function! misc#insert_string_mark(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let l = getline('.')
  let c = col('.')
  call setline('.', strpart(l, 0, c - 1) . smark . strpart(l, c - 1) )
endfunction

" append string mark after cursor
function! misc#append_string_mark(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let l = getline('.')
  let c = col('.')
  call setline('.', strpart(l, 0, c) . smark . strpart(l, c) )
endfunction

function! misc#search_string_mark(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let flags = get(a:000, 1, '')
  if !search(smark, flags)
    throw 'string mark not found'
  endif
endfunction

" always assume cursor on 1st character of string mark
function! misc#remove_string_mark(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let l = getline('.')
  let c = col('.')
  call setline('.', strpart(l, 0, c - 1) . strpart(l, c - 1 + len(smark)) )
endfunction

function! misc#abort_do(out_cmd, inner_cmd, ...) abort
  try
    let inner_cmd = a:inner_cmd . join(a:000, ' ')

    let cmd_dict = {
                \ 'cdo'   : ['cfirst',   'cnext'   ],
                \ 'ldo'   : ['lfirst',   'lnext'   ],
                \ 'argdo' : ['first',    'next'    ],
                \ 'bufdo' : ['bfirst',   'bnext'   ],
                \ 'windo' : ['wincmd t', 'wincmd w'],
                \ 'tabdo' : ['tabfirst', 'tabnext' ],
                \ 'cfdo'  : ['cfirst',   'cnfile'  ],
                \ 'cldo'  : ['lfirst',   'lnfile'  ],
                \ }

    set eventignore+=Syntax

    if !has_key(cmd_dict, a:out_cmd)
      throw a:out_cmd . ' not found'
    endif

    let l:count = 2147483648
    if a:out_cmd == 'bufdo'
      let l:count = len(split(execute('buffers'), "\n"))
    endif

    let [first_cmd, next_cmd] = cmd_dict[a:out_cmd]
    exe first_cmd
    while l:count > 0
        exe inner_cmd
        exe next_cmd
        let l:count -= 1
    endwhile
  " catch /^Vim\%((\a\+)\)\=:E42:/  " cfirst, lfirst
  " catch /^Vim\%((\a\+)\)\=:E553:/ " cnext
  " catch /^Vim\%((\a\+)\)\=:E163:/ " next
  " catch /^Vim\%((\a\+)\)\=:E87:/  " bnext

  finally
    set eventignore-=Syntax
  endtry
endfunction
