" things to remember when you create text object:
"
" omap is always implemented in terms of vmap, the only way to know it's an omap
" is to use state() ? In order to pass register and forced motion from omap to
" vmap, one can use:
"
"   :normal <FMW(forced motion wise)><key>"<register><cr>

" It's a bit weird that "<register> appears after key, get used to it.
"
" the FMW is the same as the visualmode() after vmap call
" <sid>select_text_object(), your textobject also has it's own wisemode, it
" might be different from FMW, if current state() has o, you can apply FMW(same
" as visualmode()).
"
" visualmode() refer to last visual mode, not current, so `norm! V` won't set
" visualmode() to `V`, but `norm! V\<esc>` or `norm! VV` will do.
"
" `norm! V:` reset col to start of line, be very very careful about this, we
" must avoid that, use
"    vnoremap key <esc>:...
" instead of
"    vnoremap key :<c-u>...
"
"
" In order to pass motion force from omap to vmap, one can use mode(1), but mode
" is transient, it has to be used with <expr>:
" omap <expr> <sid>omap(key, mode(1), default_wise)

function s:force_motion() abort
  if mode() !~# "[vV\<c-v>]"
    throw "illegal mode in force motion"
  endif

  " visualmode is last visual mode, which is applied by norm! [vV<c-v>] through
  " omap, it's the same as forced motion wise,  mode() is current visual mode,
  " which is also the current text object wise mode.
  if state() =~# 'o'
    if visualmode() !=# mode()
      exe 'norm!' visualmode()
    endif
  endif
endfunction

function s:assert_start_state() abort
  if mode() =~# "[vV\<c-v>]"
    throw "illegal visual mode in start of text object"
  endif
endfunction

" return [itemIndex, [total range], [item1 range, item 2 range ....]]
" itemIndex will be -1 if it can not be found.(eg: cursor at ( or , or ) )
"
" search starts at current cursor.
"
" opts : {exclude_space:1, delim:',', guard:'()', 'jump_pairs':[(),[],{},<>}
function misc#to#get_args(opts) abort

  try
    let cur_pos = getpos('.')
    let cview = winsaveview()
    let delim = get(a:opts, 'delim', ',')
    let guard = get(a:opts, 'guard', '()')
    let exclude_space = get(a:opts, 'exclude_space', 1)
    let jump_pairs = get(a:opts, 'jump_pairs', ['()','[]','{}','<>'])
    let [left_guard, right_guard] = [guard[0], guard[1]]
    let total_range = [[0,0], [0,0]]
    let arg_ranges = []

    let [left_pairs, right_pairs] = ['', '']
    for item in jump_pairs
      let left_pairs .= item[0]
      let right_pairs .= item[1]
    endfor

    if misc#get_cc() ==# right_guard
      call misc#char_left()
    endif

    "goto left guard first
    if !misc#search_over_pairs(left_guard, right_pairs, 'bcW')
      return []
    endif

    let total_range[0] = getpos('.')
    call misc#char_right() " move away from (
    let arg_range_start = getpos('.')
    call misc#char_left() " move back to (

    "find item ranges and right guard
    while misc#search_over_pairs(right_guard.delim, left_pairs, 'W')
      let c = misc#get_cc()
      if c ==# delim
        call misc#char_left()  " move cursor away from ','
        let arg_ranges += [[arg_range_start, getpos('.') ]]
        call misc#char_right(2) " move cursor forward away from ','
        let arg_range_start = getpos('.')
        call misc#char_left()  " move cursor back to  ','
      else
        let total_range[1] = getpos('.')
        call misc#char_left()  " move cursor back away from ','
        let arg_ranges += [[arg_range_start, getpos('.')]]
        break
      endif
    endwhile

    "find current item index
    let [arg_index, size]  = [0, len(arg_ranges)]
    while arg_index != size
      let range = arg_ranges[arg_index]
      if misc#cmp_pos(range[0], cur_pos) <= 0 && misc#cmp_pos(range[1], cur_pos) >=0
        break
      endif
      let arg_index += 1
    endwhile

    "set arg_index to -1 if it's invalid
    if arg_index == len(arg_ranges) | let arg_index = -1 | endif

    "exclude space after find current item, allow current character to be space
    if exclude_space
      for range in arg_ranges
        "carefule here, don't use let range = misc#trim_range(range)
        let trimed_range = misc#trim_range(range)
        let [range[0], range[1]] = [trimed_range[0], trimed_range[1] ]
      endfor
    endif

    return [arg_index, total_range, arg_ranges]

  finally
    call winrestview(cview)
  endtry
endfunction

function misc#to#sel_cur_arg(ai) abort
  call s:assert_start_state()
  let opts = {'exclude_space': a:ai ==# 'i'}
  let ranges = misc#to#get_args(opts)

  if ranges == [] | call misc#warn('illigal range') | return | endif

  let [arg_index, total_range, arg_ranges] = [ranges[0], ranges[1], ranges[2]]
  if arg_index == -1
    call misc#warn('you should not place your cursor at ' . misc#get_cc() )
    return
  endif

  let cur_arg_range = ranges[2][arg_index]
  call misc#visual_select(cur_arg_range, 'v')
  call s:force_motion()
endfunction

" select regex pattern, pattern must contain %#
function misc#to#sel(pat, ai) abort
  call s:assert_start_state()

  if stridx(a:pat, '%#') ==# -1
    throw 'sel pattern must contain %#'
  endif

  try
    let spat = @/
    let @/ = a:pat
    call misc#log#debug( printf( 'sel : %s', @/ ) )
    norm! gn
    if mode() !~# "[vV\<c-v>]"
      return 0
    endif

    " expand to right or left neighbor space
    if a:ai ==# 'a'
      if !search( '\v%#.\s+', 'ce', line('.') )
        norm! o

        " mimic vaw, ignore leading space
        call search( '\v\S\zs\s+%#.', 'bc', line('.') )
        norm! o
      endif
    endif

    call s:force_motion()

    return 1
  finally
    let @/ = spat
  endtry
endfunction

function misc#to#sel_letter(ai) abort
  return misc#to#sel( '\v[a-zA-Z]*%#[a-zA-Z]+', a:ai )
endfunction

function misc#to#sel_number(ai) abort
  return misc#to#sel( '\v[0-9.\-]*%#[0-9.\-]+', a:ai )
endfunction

function misc#to#sel_file(ai) abort
  call s:assert_start_state()
  1
  norm! V
  $
  call s:force_motion()
endfunction

" TODO implement a?
function misc#to#column(ai) abort
  call s:assert_start_state()
  exec "norm! \<c-v>"
  if misc#get_cc() !~# '\s'
    call misc#mo#vertical_motion('E')
  else
    " doesn't exist or is blank
    call misc#mo#vertical_motion('S')
    if misc#get_cc() !~# '\s'
      norm! k
    endif
  endif
  call s:force_motion()
endfunction

" select lines if current line is between patterns, otherwise do nothing
" style : 0 : use ai to include or exclude pattern line
" style : 1 : use ai to include or exclude space
function misc#to#sel_lines(pattern0, pattern1, ai, style)
  call s:assert_start_state()

  try
    let cpos = getcurpos()
    let cview = winsaveview()

    " jump to start line or exit
    if !search(a:pattern0, 'bcW') | return | endif
    let startline = line('.')

    " jump to end line or exit
    if !search(a:pattern1, 'W') | return | endif
    let endline = line('.')
    if endline < cpos[1] | return | endif

    " adjust start and end for i
    if a:ai ==# 'i' && a:style == 0
      let startline += 1
      let endline -= 1
      if startline > endline | return | endif
    endif

    " add trailing or preceding space for 'a' if style is 1
    if a:style == 1 && a:ai ==# 'a'

      " | branch is used to handle leading and trailing blank lines in the buffer
      if search('\v^.*\S|%$', 'W')
        if getline('.') =~# '\S'
          -
        endif
      endif

      " if no space after endline, search backward from startline
      if line('.') != endline
        let endline = line('.')
      else
        exec startline
        if search('\v^.*\S|%1l', 'bW')
          if getline('.') =~# '\S'
            +
          endif
          let startline = line('.')
        endif
      endif
    endif

  finally
    call winrestview(cview)
  endtry

  " visually select from startline to endline
  exec startline
  norm! V
  exec endline
  call s:force_motion()
endfunction

" ov : o for omap, v for v map
" jk : j or k or jk. j for down, k for up.
" visuall block wisely select current column until blank line.
"function! misc#to#sel_column(ov, jk) abort
  "let [cur_vnum, cur_lnum, col_lnum0, col_lnum1, lnum] =
              "\ [virtcol('.')] + repeat([line('.')], 4)
  "" do nothing if cursor in blank
  "if misc#get_v(cur_lnum, cur_vnum) =~# '\v\s'
    "if a:ov ==# 'v' | exec 'normal! ' | endif | return
  "endif

  "" get column end
  "if stridx(a:jk, 'j') != -1
    "while 1
      "let lnum = lnum + 1
      "if lnum > line('$') || misc#get_v(lnum, cur_vnum) =~# '\v^$|\s'
        "let col_lnum1 = lnum - 1 | break
      "endif
    "endwhile
  "endif

  "" get column start
  "if stridx(a:jk, 'k') != -1
    "let lnum = cur_lnum
    "while 1
      "let lnum = lnum - 1
      "if lnum <= 0 || misc#get_v(lnum, cur_vnum) =~# '\v^$|\s'
        "let col_lnum0 = lnum + 1 | break
      "endif
    "endwhile
  "endif

  "" visual select
  "call cursor(col_lnum0, col('.'))
  "exec "normal! \<c-v>"
  "call cursor(col_lnum1, col('.'))
"endfunction
