" vim:set foldmethod=marker :

if &compatible || exists('g:loaded_misc_plugin')
  finish
endif
let g:loaded_misc_plugin = 1

" mo {{{1
function s:add_mo(keys, func)
    exec printf('nnoremap %s :call %s<cr>', a:keys, a:func)
    exec printf('xnoremap %s <esc>:exec "norm! gv" <bar> call %s<cr>', a:keys, a:func)

    " use v for ordinary operate pending mode, otherwise use forced motion
    " onoremap <expr> key printf("normal %skey<cr>", mode(1) ==# "no" ? "v" : mode(1)[2]) )
    exec printf('onoremap <expr> %s printf(":normal %%s%s<cr>",
                \ mode(1) ==# "no" ? "v" : mode(1)[2])', a:keys, a:keys)
endfunction
call s:add_mo('<plug>dedowsdi_mo_vertical_E', 'misc#mo#vertical_motion("E")')
call s:add_mo('<plug>dedowsdi_mo_vertical_W', 'misc#mo#vertical_motion("W")')
call s:add_mo('<plug>dedowsdi_mo_vertical_B', 'misc#mo#vertical_motion("B")')

" to {{{1

" key is executed as
"   exe "norm {vmode}{key}"
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
  let prefix = get(a:000, 0, '<plug>dedowsdi_to_')
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

call s:add_to('ai', 'a', 'v',      'misc#to#sel_cur_arg')
call s:add_to('ai', 'l', 'v',      'misc#to#sel_letter')
call s:add_to('ai', 'n', 'v',      'misc#to#sel_number')
call s:add_to('i',  'c', '\<c-v>', 'misc#to#column')
call s:add_to('ai', 'f', 'V',      'misc#viml#sel_func', '<plug>dedowsdi_viml_to_')
call s:add_to('i', 'F', 'V',      'misc#to#sel_file')

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

call s:add_op('<plug>dedowsdi_op_search_literal', 'misc#op#search_literal')
call s:add_op('<plug>dedowsdi_op_substitute_literal', 'misc#op#substitude_literal')
call s:add_op('<plug>dedowsdi_op_system', 'misc#op#system')
call s:add_op('<plug>dedowsdi_op_literal_grep', 'misc#op#literal_grep')
call s:add_op('<plug>dedowsdi_op_search_in_browser', 'misc#op#search_in_browser')
call s:add_op('<plug>dedowsdi_op_get_column', 'misc#op#get_column')
call s:add_op('<plug>dedowsdi_op_clang_format', 'misc#op#clang_format')

nnoremap <plug>dedowsdi_op_co :call misc#op#omo('co')<cr>
nnoremap <plug>dedowsdi_op_do :call misc#op#omo('do')<cr>
nnoremap <plug>dedowsdi_op_guo :call misc#op#omo('guo')<cr>
nnoremap <plug>dedowsdi_op_gUo :call misc#op#omo('gUo')<cr>
nnoremap <plug>dedowsdi_op_g~o :call misc#op#omo('gso')<cr>

" cpp {{{1
let g:mycpp_def_src_ext    = get(g:, 'mycpp_def_src_ext'    , 'cpp')
let g:mycpp_build_dir     = get(g:, 'mycpp_build_dir'     , './')

com CppDumpProjFile call mycpp#dump_proj_file()
com -nargs=* -complete=customlist,mycpp#make_complete CppRun           call mycpp#exe('cd "%w" && "%E" %a', 1, <q-args>, 0)
com -nargs=* -complete=customlist,mycpp#make_complete CppMake          update | call mycpp#exe('cd "%B" && make -j3 %A %t', 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppMakeFileName  exec 'CppMake ' . expand('%:t:r')
com -nargs=* -complete=customlist,mycpp#make_complete CppMakeRun       update | call mycpp#exe('cd "%B" && make %A %t && cd "%w" && "%E" %a', 1, <q-args>, 0)
com -nargs=* -complete=customlist,mycpp#make_complete CppMakeDebug     update | call mycpp#exe('cd "%B" && make %t && cd "%w" && gdb %A --args "%E" %a', 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppRenderdoc     call mycpp#exe('cd "%w" && renderdoccmd capture %A "%E" %a', 1, <q-args>)

let s:apitrace_opencmd = 'cd "%b" && qapitrace $(grep -oP "(?<=tracing to ).*$" trace.log)'
com -nargs=* -complete=customlist,mycpp#make_complete -bar CppApitrace   call mycpp#exe('cd "%w" && apitrace trace "%E" %a |& tee trace.log && ' . s:apitrace_opencmd, 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppOpenLastApitrace      call mycpp#exe(s:apitrace_opencmd, 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppNNL           call mycpp#exe('cd "%w" && nnl --activity="Frame Debugger" --exe="%E" --args="%a" ', 0, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppValgrind      call mycpp#exe('cd "%w" && valgrind %A "%E" %a', 1, <q-args>)
com -nargs=+ -complete=customlist,mycpp#make_pp_complete CppMakePP  update | call mycpp#make_pp(<f-args>)
com CppConfig call mycpp#open_project_file()
com -nargs=0 CppSearchDerived                                         call mycpp#search_derived()
com -nargs=* -complete=shellcmd CppCmake call mycpp#cmake(<q-args>)

com -nargs=* -complete=customlist,mycpp#make_complete CppDebug         call mycpp#debug(<q-args>)
com CppDebugToggleBreak call mycpp#debug_toggle_break()
com CppDebugStep        call mycpp#debug_step()
com CppDebugNext        call mycpp#debug_next()
com CppDebugContinue    call mycpp#debug_continue()
com CppDebugFinish      call mycpp#debug_finish()
com CppDebugEvaluate    call mycpp#debug_evaluate()
com CppDebugStop        call mycpp#debug_stop()
com CppDebugFrameUp     call mycpp#debug_frame_up()
com CppDebugFrameDown   call mycpp#debug_frame_down()

" vim {{{1
com -nargs=0 VimlReloadScript :call  misc#viml#reload_loaded_script()
com -nargs=0 VimlBreakHere :call misc#viml#break_here()
com -nargs=0 VimlBreakNumberedFunction :call misc#viml#break_numbered_function()
com -nargs=? VimlGotoFunction :call misc#viml#goto_function(<f-args>)
com -nargs=0 VimlJoin :call misc#viml#join()
com -nargs=? List call misc#viml#list(expand('<sfile>'), expand('<slnum>'), <f-args>)
com -nargs=+ -complete=command DoAbort call misc#abort_do(<f-args>)
com -nargs=+ LinkVimHelp let @+ = misc#create_vimhelp_link(<q-args>)
com -nargs=+ LinkNvimHelp let @+ = misc#create_nvimhelp_link(<q-args>)
com UpdateVimHelpLink call misc#update_link(0)
com UpdateNvimHelpLink call misc#update_link(1)

" term {{{1
nnoremap <plug>dedowsdi_term_toggle_gterm :call misc#term#toggle_gterm()<cr>
tnoremap <plug>dedowsdi_term_toggle_gterm <c-w>:call misc#term#toggle_gterm()<cr>

" record {{{1
com RecordStart :call misc#dc#start_copy(1)
com RecordStartAppend :call misc#dc#start_copy(0)
com RecordPaste :call misc#dc#paste()
com RecordStop :call misc#dc#stop_copy()

function s:record_sink(item) abort
  let @@ = a:item
  norm! p
endfunction

if executable('fzf')
  nnoremap <a-r> :call fzf#run(fzf#wrap({
        \ 'source' : misc#dc#get_texts(),
        \ 'sink': function('<sid>record_sink'),
        \ }))<cr>
endif

" hlcmd {{{1
com -nargs=0 ToggleCommandHighlight call misc#hlcmd#toggle()
silent ToggleCommandHighlight

" undo {{{1
com -nargs=+ -bang UndotreeTag call misc#undo#tag(<bang>0, <f-args>)
com -nargs=1 -complete=customlist,misc#undo#complete_tag UndotreeCheckout call misc#undo#checkout(<f-args>)
com UndotreeCheckoutBranchPoint call misc#undo#undo_branch_point()
com UndotreeListTags call misc#undo#list_tags()

if &undofile
  com UndotreeCheckoutStart call misc#undo#undostart()
  com U0 UndotreeCheckoutStart

  " install a 0 tag for existing file
  augroup undotree_tag
    au!

    autocmd BufRead * if &buftype ==# '' && &modifiable
                   \|   call misc#undo#tag_start()
                   \|   exe 'nnoremap <buffer> u :call misc#undo#safeundo()<cr>'
                   \| endif
  augroup end

endif

" readline {{{hist
cnoremap <Plug>dedowsdi_hist_expand_hist_wild <c-\>emisc#hist#expand(1)<cr>
cnoremap <Plug>dedowsdi_hist_expand_hist <c-\>emisc#hist#expand(0)<cr>

" readline {{{1
cnoremap <Plug>dedowsdi_readline_beginning_of_line <c-b>
cnoremap <Plug>dedowsdi_readline_kill <c-\>emisc#readline#kill()<cr>
cnoremap <Plug>dedowsdi_readline_forward_char <right>
cnoremap <Plug>dedowsdi_readline_backward_char <left>
cnoremap <Plug>dedowsdi_readline_forward_word <c-right>
cnoremap <Plug>dedowsdi_readline_backward_word <c-left>
cnoremap <Plug>dedowsdi_readline_uppercase_word <c-\>emisc#readline#word_case(1)<cr>
cnoremap <Plug>dedowsdi_readline_lowercase_word <c-\>emisc#readline#word_case(0)<cr>
cnoremap <Plug>dedowsdi_readline_forward_delete <c-\>emisc#readline#forward_delete()<cr>

" debugvim {{{1
com -nargs=1 DebugvimDisplay call misc#debugvim#display(<f-args>)
com -nargs=? DebugvimDisableDisplay call misc#debugvim#disable_display(<f-args>)
com -nargs=? DebugvimDeleteDisplay call misc#debugvim#disable_display(<f-args>)
com -nargs=0 DebugvimInfoDisplay call misc#debugvim#info_display()
com -nargs=0 DebugvimEnable call misc#debugvim#enable()
com -nargs=0 DebugvimDisable call misc#debugvim#disable()

" ahl {{{1
com! AhlRemoveWindowHighlights call misc#ahl#remove_wnd_highlights()
com! AhlRemoveCursorHighlights call misc#ahl#remove_cursor_highlights()
call s:add_op('<plug>dedowsdi_ahl_remove_cursor_highlights', 'misc#ahl#op')

" popup {{{1
if !has('nvim')
  let [s:psk_down, s:psk_up, s:psk_rotate] = get(g:, 'dedowsdi_popup_scroll_keys', [0, 0, 0])
  if type(s:psk_down) !=# v:t_number
    exe printf('nnoremap <expr> %s misc#popup#scroll_cursor_popup(1)
          \ ? "<esc>" : "%s"', s:psk_down, s:psk_down)
    exe printf('nnoremap <expr> %s misc#popup#scroll_cursor_popup(0)
          \ ? "<esc>" : "%s"', s:psk_up, s:psk_up)
    exe printf('nnoremap <expr> %s misc#popup#rotate_cursor_popup(0)
          \ ? "<esc>" : "%s"', s:psk_rotate, s:psk_rotate)
  endif
endif

" popup {{{1
com -nargs=? SaveBufferLayout call misc#layout#save(<q-args>)
com -nargs=? RestoreBufferLayout call misc#layout#restore(<q-args>)

" hare {{{1

let g:hare_dynamic_filter_threshold = get(g:, 'hare_dynamic_filter_threshold', 4096)
let g:hare_local_marks = get(g:, 'hare_local_marks', 4)
let g:hare_global_marks = get(g:, 'hare_global_marks', 4)
let g:hare_height = get(g:, 'hare_height', 8)
let g:ctag_update_delay = get(g:, 'ctag_update_delay', 6000)

com -nargs=+ Hare call misc#hare#exec(<q-args>)

com History Hare file filter! /^fugitive/ oldfiles

com Ls Hare ls ls

com Fold Hare line /\v.*\{\{\{\d*$

com Buffer call misc#hare#jump('file',
      \ map(split(execute('ls'), "\n"), {i,v->matchstr(v, '\v.*"\zs.+\ze"')}))

let g:find_exclude = '-name .hg -o -name .git -o -name build -o -name .vscode -o -name .clangd'
let g:project_source = get(g:, 'project_source',
      \ printf('find . -type d \( %s \) -prune -o -type f -print', g:find_exclude) )

com Src exe 'Hare file !' . g:project_source

com File exe 'Hare file !find . -type f'

let g:find_path = []
com Find exe printf('Hare file !find %s -type d \( %s \) -prune -o -type f -print',
            \ join(g:find_path), g:find_exclude)

com -nargs=+ Locate Hare file !locate <args>

com GrepCache exe 'Hare fline !cat' @%

com Btag call misc#hare#jump('btag',
      \ s:get_btag_cmd(&filetype) , s:get_tag_pattern(&filetype))

" {filetype:string or funcref(which return cmd string)}
let g:hare_btag_cmd = get(g:, 'hare_btag_cmd', {})

if !has_key(g:hare_btag_cmd, 'help')
  let g:hare_btag_cmd.help =
        \ { -> printf(' !readtags -t "%s" -Q ''(eq? $input "%s")'' -l
        \ | cut -f1,3-', expand('%:h') . '/tags', expand('%:t') ) }
endif

if !has_key(g:hare_btag_cmd, 'c')
  let g:hare_btag_cmd.c = { -> printf('!ctags -f - --sort=no --fields=ksSi
        \ --fields-c++=+{properties}{template} --language-force=c++ %s
        \ | cut -f1,3-', expand('%')) }
endif

if !has_key(g:hare_btag_cmd, 'cpp')
  let g:hare_btag_cmd.cpp = g:hare_btag_cmd.c
endif

function s:get_btag_cmd(filetype) abort
  if has_key(g:hare_btag_cmd, a:filetype)
    let Cmd = g:hare_btag_cmd[a:filetype]
    return type(Cmd) ==# v:t_func ? Cmd() : Cmd
  endif
  return printf('!ctags --fields=k -f - %s | cut -f1,3-', expand('%'))
endfunction

let g:hare_tag_pattern = get(g:, 'hare_btag_pattern', {})

if !has_key(g:hare_tag_pattern, 'vim')
  let g:hare_tag_pattern.vim = '/\v<'
endif

function s:get_tag_pattern(filetype) abort
  if has_key(g:hare_tag_pattern, a:filetype)
    let pat = g:hare_tag_pattern[a:filetype]
    return type(pat) ==# v:t_func ? pat() : pat
  endif
  return '/\v^'
endfunction

com -nargs=* Tag call misc#hare#jump('tag',
      \ function('s:read_tags', [<f-args>]), s:get_tag_pattern(&filetype))

com Tagbar exe 'Hare btag !tagbar' @%

com -nargs=+ -bang -complete=tag Tselect Hare tselect tselect<bang> <args>

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
      exe printf('$read !readtags -t %s -Q %s -el | grep -v "^__anon"',
            \ shellescape(tag), shellescape(cond))
    endif
  endfor
endfunction

" tag {{{1
com -nargs=+ Readtagsi call misc#readtagsi(<q-args>)

com -nargs=* ConnectCtagServer call misc#tag#connect_server()
com -nargs=* EditCtagServerLog :e $VIM_PROJ_TMP/tag/log

let g:dedowsdi_connect_ctag_server = get(g:, 'dedowsdi_connect_ctag_server', 0)
if g:dedowsdi_connect_ctag_server
  ConnectCtagServer
endif

" misc {{{1

com -range -nargs=+ T call misc#mult_t(<line1>, <line2>, <f-args>)
com -bar CamelToUnderscore norm! ciw<c-r>=misc#camel_to_underscore(@@)<cr><esc>
com -bar -bang UnderscoreToCamel norm! ciw<c-r>=misc#underscore_to_camel(@@, <bang>0)<cr><esc>
com CamelToUnderscoreAndSearchNext CamelToUnderscore | exec "norm! \<c-o>" | SearchNextCamel
com SearchNextCamel call search('\v\C\w*[A-Z]\w*', 'W')
com -nargs=1 SetNotifySeverity call misc#log#set_notify_severity(<f-args>)

function s:repeat_plug_map(lhs, rhs)
  exec printf('nnoremap <silent> %s %s:silent! call repeat#set("\<lt>%s")<cr>',
        \ a:lhs, a:rhs, a:lhs[1:])
endfunction

call s:repeat_plug_map('<Plug>dedowsdi_misc_pair_add_space', ':call misc#expand_pair(1)<cr>')
call s:repeat_plug_map('<Plug>dedowsdi_misc_pair_minus_space', ':call misc#expand_pair(0)<cr>')

com -bang -nargs=1 Slide call misc#prepare_slide(<bang>0, <f-args>)

com -count WinFitBuf call misc#win_fit_buf(<count>)

augroup auto_format_table
  autocmd!
augroup end

com EnableAutoFormatTable autocmd! auto_format_table BufWrite <buffer> call misc#format_table()
com DisableAutoFormatTable autocmd! auto_format_table BufWrite <buffer>

com -nargs=+ -complete=shellcmd Job call misc#job(<q-args>)

com -nargs=* Expand call misc#expand_filepath(<f-args>)

com -nargs=0 CloseFinishedTerminal call misc#close_finished_terminal()

com -nargs=? Browse call misc#browse(<f-args>)

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
