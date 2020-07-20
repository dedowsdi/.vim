" vim:set foldmethod=marker :

if &compatible || exists('g:loaded_ddd_plugin')
  finish
endif
let g:loaded_ddd_plugin = 1

" mo {{{1
function s:add_mo(keys, func)
    exec printf('nnoremap %s :call %s<cr>', a:keys, a:func)
    exec printf('xnoremap %s <esc>:exec "norm! gv" <bar> call %s<cr>', a:keys, a:func)

    " use v for ordinary operate pending mode, otherwise use forced motion
    " onoremap <expr> key printf("normal %skey<cr>", mode(1) ==# "no" ? "v" : mode(1)[2]) )
    exec printf('onoremap <expr> %s printf(":normal %%s%s<cr>",
                \ mode(1) ==# "no" ? "v" : mode(1)[2])', a:keys, a:keys)
endfunction
call s:add_mo('<plug>ddd_mo_vertical_E', 'ddd#mo#vertical_motion("E")')
call s:add_mo('<plug>ddd_mo_vertical_W', 'ddd#mo#vertical_motion("W")')
call s:add_mo('<plug>ddd_mo_vertical_B', 'ddd#mo#vertical_motion("B")')

" to {{{1

" support forced motion and register with custom operator
"   exe "norm {vmode}{key}\"register"
function s:omap(key, mode, default_vmode)

  " use default_vmode for ordinary operator pending mode, it should be the same
  " as textobject wisemode, otherwise use forced motion
  let vmode = a:mode ==# 'no' ? a:default_vmode : a:mode[2]
  if vmode ==# "\<c-v>"
    let vmode .= vmode
  endif

  " apply forced motion, pass register.
  return printf(':exe "normal %s%s\"%s' . "\<cr>", vmode, a:key, v:register)
endfunction

" add text object, assume func prototype as: func(ai). support forced-motion and
" register.
function s:add_to(ai, letter, default_vmode, func, ...) abort
  let prefix = get(a:000, 0, '<plug>ddd_to_')
  if a:ai =~# 'a'
    let key = printf('%sa%s', prefix, a:letter)
    exe printf('xnoremap %s <esc>:silent! call call("%s", ["a"])<cr>', key, a:func)
    exe printf('onoremap <expr> %s <sid>omap(''\%s'', mode(1), "%s")', key, key, a:default_vmode)
  endif

  if a:ai =~# 'i'
    let key = printf('%si%s', prefix, a:letter)
    exe printf('xnoremap %s <esc>:silent! call call("%s", ["i"])<cr>', key, a:func)
    exe printf('onoremap <expr> %s <sid>omap(''\%s'', mode(1), "%s")', key, key, a:default_vmode)
  endif
endfunction

call s:add_to('ai', 'l', 'v',      'ddd#to#sel_letter')
call s:add_to('ai', 'n', 'v',      'ddd#to#sel_number')
call s:add_to('i',  'c', '\<c-v>', 'ddd#to#column')
call s:add_to('ai', 'f', 'V',      'ddd#vim#sel_func', '<plug>ddd_vim_to_')

" op {{{1

" circumvent count, register changes
function s:setup_opfunc(func)
  let &opfunc = a:func
  return 'g@'
endfunction

function s:add_op(key, func)
  exe printf('nnoremap <expr> %s <sid>setup_opfunc("%s")', a:key, a:func)
  exe printf('xnoremap %s :<c-u>call %s(visualmode(), 1)<cr>', a:key, a:func)
endfunction

call s:add_op('<plug>ddd_op_search_literal', 'ddd#op#search_literal')
call s:add_op('<plug>ddd_op_substitute_literal', 'ddd#op#substitude_literal')
call s:add_op('<plug>ddd_op_search_in_browser', 'ddd#op#search_in_browser')
call s:add_op('<plug>ddd_op_get_column', 'ddd#op#get_column')
call s:add_op('<plug>ddd_op_clang_format', 'ddd#op#clang_format')

" replace word or single non word non space character, the replacement can
" contain newline.
"
" co use \v\C%V<wor%Vd> as search pattern, the %V will fail for 2nd+ items of
" last line if your replacement contains newline (the '> won't change after 1st
" item replacement?, the 2nd+ items are in new lines, they are out of the visual
" area).
nnoremap <plug>ddd_op_co :call ddd#op#omo('co')<cr>
nnoremap <plug>ddd_op_do :call ddd#op#omo('do')<cr>
nnoremap <plug>ddd_op_guo :call ddd#op#omo('guo')<cr>
nnoremap <plug>ddd_op_gUo :call ddd#op#omo('gUo')<cr>
nnoremap <plug>ddd_op_g~o :call ddd#op#omo('gso')<cr>

" cpp {{{1
let g:ddd_cpp_def_src_ext    = get(g:, 'ddd_cpp_def_src_ext'    , 'cpp')
com CppGotoLastInclude call ddd#cpp#goto_last_include()
com CppDebugToggleBreak call ddd#cpp#debug_toggle_break()
com CppIncludeOsg call ddd#cpp#include_osg()

" gterm {{{1
com GtermToggle call ddd#gterm#toggle()
com GtermRepeat call ddd#gterm#repeat_cmd()

" tgterm {{{1
com TgtermToggle call ddd#tgterm#toggle()
com TgtermRepeat call ddd#tgterm#repeat_cmd()

" make {{{1
com -nargs=* -bang -complete=customlist,ddd#make#complete Make
      \ call ddd#make#make(<bang>0, <q-args>)

" undo {{{1
com -nargs=+ -bang UndoTag call ddd#undo#tag(<bang>0, <f-args>)
com -nargs=1 -complete=customlist,ddd#undo#complete_tag UndoCheckout call ddd#undo#checkout(<f-args>)
com UndoCheckoutBranchPoint call ddd#undo#undo_branch_point()
com UndoListTags call ddd#undo#list_tags()

if &undofile
  com UndoCheckoutStart call ddd#undo#undostart()
  com U0 UndoCheckoutStart

  " install a 0 tag for existing file
  augroup undotree_tag
    au!

    autocmd BufRead * if &buftype ==# '' && &modifiable
                   \|   call ddd#undo#tag_start()
                   \|   exe 'nnoremap <buffer> u :call ddd#undo#safeundo()<cr>'
                   \| endif
  augroup end

endif

" hisst {{{1
cnoremap <Plug>ddd_hist_expand_hist_wild <c-\>eddd#hist#expand(1)<cr>
cnoremap <Plug>ddd_hist_expand_hist <c-\>eddd#hist#expand(0)<cr>

" ahl {{{1
com! AhlRemoveWindowHighlights call ddd#ahl#remove_wnd_highlights()
com! AhlRemoveCursorHighlights call ddd#ahl#remove_cursor_highlights()
call s:add_op('<plug>ddd_ahl_remove_cursor_highlights', 'ddd#ahl#op')

" popup {{{1
if !has('nvim')
  let [s:psk_down, s:psk_up, s:psk_rotate] = get(g:, 'ddd_popup_scroll_keys', [0, 0, 0])
  if type(s:psk_down) !=# v:t_number
    exe printf('nnoremap <expr> %s ddd#popup#scroll_cursor_popup(1)
          \ ? "<esc>" : "%s"', s:psk_down, s:psk_down)
    exe printf('nnoremap <expr> %s ddd#popup#scroll_cursor_popup(0)
          \ ? "<esc>" : "%s"', s:psk_up, s:psk_up)
    exe printf('nnoremap <expr> %s ddd#popup#rotate_cursor_popup(0)
          \ ? "<esc>" : "%s"', s:psk_rotate, s:psk_rotate)
  endif
endif

" popup {{{1
com -nargs=? SaveBufferLayout call ddd#layout#save(<q-args>)
com -nargs=? RestoreBufferLayout call ddd#layout#restore(<q-args>)

" hare {{{1

let g:ddd_hare_dynamic_filter_threshold = get(g:, 'ddd_hare_dynamic_filter_threshold', 4096)
let g:ddd_hare_local_marks = get(g:, 'ddd_hare_local_marks', 4)
let g:ddd_hare_global_marks = get(g:, 'ddd_hare_global_marks', 4)
let g:ddd_hare_height = get(g:, 'ddd_hare_height', 8)
let g:ddd_ctag_update_delay = get(g:, 'ddd_ctag_update_delay', 6000)

nnoremap <silent> <plug>ddd_hare_sink :call ddd#hare#sink()<cr>
cnoremap <silent> <plug>ddd_hare_sink <cr>:call ddd#hare#sink()<cr>

" don't use <esc>, it runs your command even though &cpo has no x
cnoremap <silent> <plug>ddd_hare_abort <c-c>:call ddd#hare#abort()<cr>
noremap <silent> <plug>ddd_hare_abort :<c-u>call ddd#hare#abort()<cr>

com -nargs=+ Hare call ddd#hare#exec(<q-args>)

com History Hare file filter! /^fugitive/ oldfiles

com Ls Hare ls ls

com Fold Hare line /\v.*\{\{\{\d*$

com Buffer call ddd#hare#jump('file',
      \ map(split(execute('ls'), "\n"), {i,v->matchstr(v, '.*"\zs.+\ze"')}))

let g:ddd_find_exclude = '-name .hg -o -name .git -o -name build -o -name .vscode -o -name .clangd'
let g:ddd_project_source = get(g:, 'project_source',
      \ printf('find . -type d \( %s \) -prune -o -type f -print', g:ddd_find_exclude) )

com Src exe 'Hare file !' . g:ddd_project_source

com File exe 'Hare file !find . -type f'

com -nargs=+ Locate Hare file !locate <args>

com GrepCache exe 'Hare fline !cat' @%

com Btag call ddd#hare#jump('btag',
      \ s:get_btag_cmd(&filetype) , s:get_btag_pattern(&filetype))

" {filetype:string or funcref(which return cmd string)}
let g:ddd_hare_btag_cmd = get(g:, 'ddd_hare_btag_cmd', {})

if !has_key(g:ddd_hare_btag_cmd, 'help')
  let g:ddd_hare_btag_cmd.help =
        \ { -> printf('!readtags -t "%s" -Q ''(eq? $input "%s")'' -l
        \ | cut -f1,3-', expand('%:p:h') . '/tags', expand('%:p:t') ) }
endif

if !has_key(g:ddd_hare_btag_cmd, 'c')
  let g:ddd_hare_btag_cmd.c = { -> printf('!ctags -f - --sort=no --fields=ksSi
        \ --fields-c++=+{properties}{template} --language-force=c++ %s
        \ | cut -f1,3-', expand('%:p')) }
endif

if !has_key(g:ddd_hare_btag_cmd, 'cpp')
  let g:ddd_hare_btag_cmd.cpp = g:ddd_hare_btag_cmd.c
endif

function s:get_btag_cmd(filetype) abort
  if has_key(g:ddd_hare_btag_cmd, a:filetype)
    let Cmd = g:ddd_hare_btag_cmd[a:filetype]
    return type(Cmd) ==# v:t_func ? Cmd() : Cmd
  endif
  return printf('!ctags --fields=k -f - %s | cut -f1,3-', expand('%:p'))
endfunction

let g:ddd_hare_btag_pattern = get(g:, 'ddd_hare_btag_pattern', {})
call extend(g:ddd_hare_btag_pattern, {'vim' : '\<'})

function s:get_btag_pattern(filetype) abort
  if has_key(g:ddd_hare_btag_pattern, a:filetype)
    let pat = g:ddd_hare_btag_pattern[a:filetype]
    return type(pat) ==# v:t_func ? pat() : pat
  endif
  return '^'
endfunction

com -nargs=* Tag call ddd#hare#jump('tag',
      \ function('s:read_tags', [<f-args>]), '^', '^!_TAG_PARENT_PATH')

com Tagbar exe 'Hare btag !tagbar' @%

function s:tselect_source(cmd) abort
  " use substitute instead of a %s command, which change last replacement
  " pattern even in a function.
  put! =substitute(execute(a:cmd), '\n \{4,}', '\t', 'g')
  1d_
endfunction

com -nargs=+ -bang -complete=tag Tselect call ddd#hare#jump('tselect',
      \ function('s:tselect_source', ['tselect<bang> <args>']),
      \ '\<', '^\s*#\s\+pri\s\+kind\s\+tag')

com Undolist exe 'Hare undolist undolist'

" [kinds, [prefix]]
" kinds is a combination of single letter kind
function s:read_tags(...) abort
  let kinds = get(a:000, 0, [])
  let prefix = get(a:000, 1, '')
  let cond = ''
  let kcond = empty(kinds) ? '' : printf('(or %s )', join(
        \ map(split(kinds, '\zs'), {i,v->printf('(prefix? $kind "%s")', v)}) ) )
  let pcond = empty(prefix) ? '' : printf('(prefix? $name "%s")', prefix)

  if !empty(pcond)
    let cond = printf('(and %s %s)', kcond, pcond)
  elseif !empty(kcond)
    let cond = printf('%s', kcond)
  endif

  let first_tag = 1
  for tag in tagfiles()
    " must add tag parent path for this to work
    call append('$', printf("!_TAG_PARENT_PATH\t%s", fnamemodify(tag, ':p:h')))
    if first_tag
      1 d_
      let first_tag = 0
    endif

    if empty(cond)
      exe '$read' tag
    else
      let l = dddu#os#systemlist('readtags -t %s -Q %s -el | grep -v "^__anon"',
            \ shellescape(tag), shellescape(cond))
      call append('$', l);
    endif
  endfor
endfunction

" tag {{{1
com -nargs=* CtagServerConnect call ddd#tag#connect_server()
com -nargs=* CtagServerDisconnect call ddd#tag#disconnect_server()
com -nargs=* CtagServerEditLog :e $VIM_PROJ_TMP/tag/log

let g:ddd_connect_ctag_server = get(g:, 'ddd_connect_ctag_server', 0)
if g:ddd_connect_ctag_server
  CtagServerConnect
endif

" pair {{{1
function s:repeat_plug_map(lhs, rhs)
  exec printf('nnoremap <silent> %s %s:silent! call repeat#set("\<lt>%s")<cr>',
        \ a:lhs, a:rhs, a:lhs[1:])
endfunction

nnoremap <Plug>ddd_pair_add_space :call ddd#pair#expand(1)<cr>
nnoremap <Plug>ddd_pair_minus_space :call ddd#pair#expand(0)<cr>

" syntax {{{1
com -nargs=+ Syntax call ddd#syntax#apply(<f-args>)

" abbre {{{1
com -nargs=+ Abbre call ddd#abbre#apply(<f-args>)

" option {{{1
com WhichCinoptions call ddd#option#which_cinoptions()

com -nargs=+ -complete=option PushGlobalOption call ddd#option#push(1, <f-args>)
com -nargs=+ -complete=option PopGlobalOption call ddd#option#pop(1, <f-args>)

com -nargs=+ -complete=option PushLocalOption call ddd#option#push(0, <f-args>)
com -nargs=+ -complete=option PopLocalOption call ddd#option#pop(0, <f-args>)

" misc {{{1
com -bar CamelToUnderscore norm! ciw<c-r>=ddd#camel_to_underscore(@@)<cr><esc>
com -bar -bang UnderscoreToCamel norm! ciw<c-r>=ddd#underscore_to_camel(@@, <bang>0)<cr><esc>
com -nargs=1 SetNotifySeverity call ddd#log#set_notify_severity(<f-args>)

com -bang -nargs=1 Slide call ddd#slide#prepare(<bang>0, <f-args>)

com -count WinFitBuf call ddd#win_fit_buf(<count>)

augroup auto_format_table
  autocmd!
augroup end

com EnableAutoFormatTable autocmd! auto_format_table BufWrite <buffer> call ddd#format_table()
com DisableAutoFormatTable autocmd! auto_format_table BufWrite <buffer>

com -nargs=0 CloseFinishedTerminal call ddd#close_finished_terminal()

com -nargs=? Browse call ddd#browse(<f-args>)

com -range UnsortUniq let g:__d={} | <line1>,<line2>g/^/
      \ if has_key(g:__d, getline('.')) | d | else | let g:__d[getline('.')]=1 | endif

com Synstack echo map( synstack(line('.'), col('.')), 'synIDattr(v:val, "name")' )

com SynID echo synIDtrans(synID(line('.'), col('.'), 1))

com -nargs=+ SynIDattr echo synIDattr(
            \ synIDtrans(synID(line('.'), col('.'), 1)), <f-args>)

com HiTest source $VIMRUNTIME/syntax/hitest.vim

com TrimTrailingWhitespace :keepp %s/\v\s+$//g

com DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
  \ | diffthis | wincmd p | diffthis

let g:ddd_type_interval=get(g:, 'ddd_type_interval', '200ms')
com -nargs=+ Type call ddd#type(<q-args>)

com -nargs=+ DiffLine call ddd#diff_line(<f-args>)

com -nargs=+ -bang Time call ddd#time(<bang>0, <q-args>)
