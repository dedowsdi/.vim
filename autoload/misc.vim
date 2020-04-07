function misc#warn(mes) abort
  echohl WarningMsg | echom a:mes | echohl None
endfunction

" a hack, maybe i should do it in another way
function misc#hasjob(job) abort
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
function misc#open(file) abort
  let nr = bufnr(a:file)
  if nr != -1
    exec printf('buffer %d', nr)
  else
    exec printf('edit %s', a:file)
  endif
endfunction

" return [0,1), it's time based, it's awful.
function misc#rand_by_time() abort
  " there are 6 digits after . of reltimestr
  return str2nr(matchstr(reltimestr(reltime()), '\v\.\zs\d+')[1:]) / 100000.0
endfunction

let s:rndm_m1 = 32007779 + (localtime()%100 - 50)
let s:rndm_m2 = 23717810 + (localtime()/86400)%100
let s:rndm_m3 = 52636370 + (localtime()/3600)%100

" copied from https://github.com/posva/Rndm
function misc#rand()
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

function misc#get_c(lnum, cnum) abort
  return matchstr(getline(a:lnum), '\%' . a:cnum . 'c.')
endfunction
function misc#get_cc() abort
  return misc#get_c(line('.'), col('.'))
endfunction

function misc#get_v(lnum, vnum) abort
  return matchstr(getline(a:lnum), '\%' . a:vnum . 'v.')
endfunction
function misc#get_vv() abort
  return misc#get_v(line('.'), col('.'))
endfunction

" search until one of expr found, ignore everything in pairs, doesn't include
" current character
" jump_pairs and expr should be completely different
" expr : desired pattern
" jump_pairs : such as (<{[ or )>}], when meet, execute %
function misc#search_over_pairs(expr, jump_pairs, flags) abort

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

function misc#visual_select(range, mode) abort

  " note that '< and '> are not changed until this visual mode finishes
  call setpos('.', a:range[0]) | exec 'normal! ' . a:mode | call setpos('.', a:range[1])
endfunction

function misc#swap_range(range0, range1, mode) abort
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

function misc#get_range(range, mode) abort
  return misc#get_pos_string(a:range[0], a:range[1], a:mode)
endfunction

function misc#replace_range(range, content, mode) abort
  let [cview, paste, reg_text, reg_type]= [winsaveview(), &paste, @a, getregtype('a')]
  try
    let [&paste, @a]= [1, a:content]
    call misc#visual_select(a:range, a:mode)
    silent normal! "ap
  finally
    call winrestview(cview) | let &paste = paste | call setreg('a', reg_text, reg_type)
  endtry
endfunction

"return new trimed characterwise range
function misc#trim_range(range) abort
  try
    let cview = winsaveview()
    let new_range = deepcopy(a:range)

    call setpos('.', a:range[0]) | call search('\v\S', 'cW') | let new_range[0] = getpos('.')
    call setpos('.', a:range[1]) | call search('\v\S', 'bcW') | let new_range[1] = getpos('.')

    return new_range
  finally
    call winrestview(cview)
  endtry
endfunction

" pos can be [l,c] or getpos() format
function misc#cmp_pos(p0, p1) abort
  if len(a:p0) != len(a:p1)
    throw 'can not compare different type position'
  endif

  if len(a:p0) == 2
    let [l0, c0, l1, c1] = a:p0 + a:p1
  elseif len(a:p0) == 4 || len(a:p0) == 5
    let [l0, c0, l1, c1] = a:p0[1:2] + a:p1[1:2]
  else
    throw 'unknow position data'
  endif

  if l0 < l1
    return -1
  elseif l0 > l1
    return 1
  elseif c0 < c1
    return -1
  elseif c0 > c1
    return 1
  endif

  return 0
endfunction

function misc#translate_pos(pos, step) abort
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

function misc#char_right(...) abort
  let step = get(a:000, 0, 1)
  " are there any option the same as backspace ?
  exec 'normal! '.step.' '
endfunction

function misc#char_left(...) abort
  let step = get(a:000, 0, 1)
  let backspace = &backspace|try
    let &backspace='indent,eol,start' 
    exec 'normal! '.step.''
  finally|let &backspace = backspace|endtry
endfunction

function misc#trim(s, ...) abort
  let no_left = get(a:000, 0, 0)
  let no_right = get(a:000, 1, 0)
  let res = a:s
  if !no_left|let res = matchstr(res, '\v^\s*\zs.*')|endif
  if !no_right|let res = matchstr(res, '\v.{-}\ze\s*$')|endif
  return res
endfunction

"add lnum, cnum to jump list
function misc#create_jumps(lnum,cnum) abort
  let [start_line, start_col]= [line('.'), col('.')] | try
    let cview = winsaveview()

    call cursor(a:lnum, a:cnum)
    normal! m'

  finally
    call winrestview(cview)
  endtry
endfunction

" copy last visual without side effect. Won't work for <c-v>$
function misc#get_visual_string() abort
  return misc#get_mark_string("'<", "'>", visualmode())
endfunction

function misc#get_mark_string(m0, m1, vmode)
  return misc#get_pos_string(getpos(a:m0), getpos(a:m1), a:vmode)
endfunction

function misc#get_pos_string(p0, p1, vmode)
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

function misc#literalize_vim(str)
    return '\V' . substitute(escape(a:str, '\'), '\n', '\\n', 'g')
endfunction

function misc#literalize_grep(str)
  let s = substitute(a:str, "'", "'\\\\''", 'g')
  return printf("'%s'", escape(s, '%#|'))
endfunction

function misc#switch_rtp(path) abort
  if !has_key(s:, 'original_rtp') | let s:original_rtp = &rtp | endif
  let &rtp = printf('%s,%s,%s', s:original_rtp, a:path, a:path.'/after')
endfunction

function s:get_help_file(tag) abort
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

function misc#create_vimhelp_link(tag) abort
  let anchor = substitute(a:tag, '[^a-zA-Z_\-]',
        \ '\=printf("%%%2X", char2nr(submatch(0)))', 'g')
  return 'https://vimhelp.org/' . s:get_help_file(a:tag) . '.html#' . anchor
endfunction

function misc#create_nvimhelp_link(tag) abort
  return 'https://neovim.io/doc/user/' .
        \ fnamemodify(s:get_help_file(a:tag), ':r') . '.html#' . a:tag
endfunction

" 0 vim
" 1 nvim
function misc#update_link(type) abort
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

function misc#camel_to_underscore(name) abort

  " change leading uppercase to lower case
  let s = substitute(a:name, '\v\C^[A-Z]', '\l\0', '')

  " change other uppercase to _lowercase
  return substitute(s, '\v\C[A-Z]', '_\l\0', 'g')
endfunction

function misc#underscore_to_camel(name, leading_uppercase) abort
  let s = substitute(a:name, '\v\c_([a-z])', '\u\1', 'g')
  if a:leading_uppercase
    let s = substitute(s, '\v\C[a-z]', '\u\0', '')
  endif
  return s
endfunction

function misc#complete_expresson(backward) abort
  let l = matchlist(getline('.'), printf('\v(.*)(<\w+)\zs%%%dc', col('.')))
  if empty(l) || l[2] ==# ''
    return ''
  endif
  let start_col = len(l[1])+1
  let base = l[2]

  let view = winsaveview()

  " collect completions, if there are duplicates, prefer before cursor
  " completions for backward, after cursor completions for forward.
  "
  " note that if you don't clear duplicates, vim will do it for you, not sure
  " what rule is used by vim.

  " place cursor at start of current word
  norm! b
  let cpos = getcurpos()
  let pattern = '\v<'.base

  let comps = {}
  let flag0 = a:backward ? 'bW' : 'W'
  let flag1 = a:backward ? 'W' : 'bW'

  for flag in [flag0, flag1]
    call setpos('.', cpos)
    let idx = 0
    while search(pattern, flag) && idx < g:dedowsdi_misc_complete_maxitem_per_direction
      exe "norm y\<plug>dedowsdi_to_ie"
      if !has_key(comps, @@)
        let comps[@@] = line('.')
        let idx += 1
      endif
    endwhile
  endfor

  call winrestview(view)

  " join completions, follow the same convention as ctrl-p and ctrl-n,
  " completions after cursor on top of the list.

  " sort by line
  let sorted_comps = sort( items(comps), { v1,v2 -> v1[1] - v2[1] } )

  " get items after cursor, and items before cursor
  let before_curosr_comps = []
  let after_cursor_comps = []
  for [text, lnum] in sorted_comps
    if lnum <= cpos[1]
      let before_curosr_comps += [text]
    else
      let after_cursor_comps += [text]
    endif
  endfor

  call complete(start_col, after_cursor_comps + before_curosr_comps)
  if a:backward
    " are there other ways to do this ?
    call feedkeys(repeat("\<c-p>", 2))
  endif
  return ''
endfunction

" get change from `[ to `](exclusive), note that if backspace past `[, you won't
" get that part of change.
function misc#get_last_change() abort
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
  if pos0 == pos1
    return ''
  endif

  let change = misc#get_pos_string(pos0, pos1, 'v')

  " mark motion is exclusive, '] might past end of line for 1 byte.
  if pos1[2] <= len( getline(pos1[1]) )
    let change = change[0:-2]
  endif

  return change
endfunction

function s:default_string_mark()
  return repeat("\x80", 8)
endfunction

" add string mark at cursor
function misc#insert_string_mark(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let l = getline('.')
  let c = col('.')
  call setline('.', strpart(l, 0, c - 1) . smark . strpart(l, c - 1) )
endfunction

" append string mark after cursor
function misc#append_string_mark(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let l = getline('.')
  let c = col('.')
  call setline('.', strpart(l, 0, c) . smark . strpart(l, c) )
endfunction

function misc#search_string_mark(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let flags = get(a:000, 1, '')
  if !search(smark, flags)
    throw 'string mark not found'
  endif
endfunction

" always assume cursor on 1st character of string mark
function misc#remove_string_mark(...) abort
  let smark = get(a:000, 0, s:default_string_mark())
  let l = getline('.')
  let c = col('.')
  call setline('.', strpart(l, 0, c - 1) . strpart(l, c - 1 + len(smark)) )
endfunction

function misc#abort_do(out_cmd, inner_cmd, ...) abort
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

function misc#mult_t(line1, line2, ...) abort
  let text = getline(a:line1, a:line2)

  " convert addresses to real line numbers
  let addresses = deepcopy(a:000)
  call map(addresses, {i,v -> misc#cmdline#address2lnum(v)})

  " apply in reverse order
  for address in reverse( sort(addresses, 'n') )
    call append(address, text)
  endfor
endfunction

" {'open_pair':"(", "close_pair":")", "pos0":[l,c], "pos1":[l,c]}
function misc#get_cur_pair() abort
  try
    let cpos = getcurpos()
    let cview = winsaveview()

    let pairs = split(substitute(&matchpairs, ':', '', 'g'), ',')
    let pos0 = []
    let pos1 = []
    let open_pair = ''
    let close_pair = ''
    let cchar = misc#get_cc()

    for pair in pairs

      call setpos('.', cpos)

      " get close pair position
      let p1 = cchar == pair[1] ?
            \ [ line('.'), col('.') ] :
            \ searchpairpos( '\V'.pair[0], '', '\V'.pair[1], 'W' )
      if p1 == [0, 0]
        continue
      endif

      let c1 = misc#get_cc()

      " get open pair position
      norm! %
      let p0 = [ line('.'), col('.') ]
      if p0 == p1
        continue
      endif

      let c0 = misc#get_cc()

      if misc#cmp_pos( p0, cpos[1:2] ) == 1 || misc#cmp_pos( p1, cpos[1:2] ) == -1
        continue
      endif

      " test with last found pair
      if pos0 == [] || misc#cmp_pos(pos0, p0) == -1 && misc#cmp_pos(pos1, p1) == 1
        let pos0 = p0
        let pos1 = p1
        let close_pair = c1
        let open_pair = c0
      endif

    endfor

    return pos0 == [] ? {} : { 'open_pair':open_pair, "close_pair":close_pair, "pos0":pos0, "pos1":pos1 }

  finally
    call winrestview(cview)
  endtry

endfunction

function misc#expand_pair(add) abort
  let pair = misc#get_cur_pair()
  if pair == {}
    return
  endif

  try
    if a:add
      call cursor(pair.pos1)
      exe "norm! i \<esc>"
      call cursor(pair.pos0)
      exe "norm! a \<esc>"
    else
      call cursor(pair.pos1)
      norm! h
      if misc#get_cc() == ' '
        norm! x
      endif
      call cursor(pair.pos0)
      norm! l
      if misc#get_cc() == ' '
        norm! x
      endif
    endif

  finally

    " always stop at open pair?
    call cursor(pair.pos0)
  endtry
endfunction

function misc#reload_ftplugin(unlet_list) abort
  for var in a:unlet_list
    if exists(var)
      exe 'unlet' var
    endif
  endfor
  e
endfunction

" Set up map, slide step, slide save.
function misc#prepare_slide(save, step) abort

  if a:step == 1 && !a:save
    silent! nunmap <c-a>
    silent! nunmap <c-x>
    return
  endif

  nnoremap <c-a> :<c-u>call <sid>slide(1, v:count1)<cr>
  nnoremap <c-x> :<c-u>call <sid>slide(0, v:count1)<cr>
  let s:slide_step = str2float(a:step)
  let s:slide_save = a:save

endfunction

let s:slide_step = 0.1
let s:slide_save = 0

function s:slide(positive, steps) abort

  " split current line into 3 parts by first number whose ends column is no less
  " then current column
  "
  "                               match 1, 1., 1.1,   or .1, with
  "                               optional leading -, the ending must
  "                               occur after cursor column
  "             leading part------++++++++++++++++++++++++++++++++++++---- tail part
  let pattern = printf( '\v^(.{-})(%%(-?\d+\.?%%(\d+)?|-?\.\d+)%%>%dc)(.*$)', col('.') )
  let matches = matchlist( getline('.'),  pattern )
  if empty(matches)
    return
  endif
  let [part0, part1, part2] = matches[1:3]

  " update number, join line
  let number = str2float(part1)
  let number += s:slide_step * a:steps * (a:positive ? 1 : -1)

  " convert float to string, remove trailing 0
  let new_part1 = substitute(printf('%f', number), '\v\..{-}\zs0+$', '', 'g')
  call setline('.', part0 . new_part1 . part2)

  " place cursor at number end
  call cursor( line('.'), len(part0) + len(new_part1) )

  if s:slide_save
    w
  endif
endfunction

function misc#win_fit_buf(extra_lines) abort
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
