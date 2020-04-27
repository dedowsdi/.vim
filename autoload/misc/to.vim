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
