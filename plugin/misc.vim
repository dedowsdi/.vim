" vim:set foldmethod=marker :

if exists('g:loaded_misc_plugin')
  finish
endif
let g:loaded_misc_plugin = 1

" mo {{{1
function s:add_mo(keys, func)
    exec printf('nnoremap %s :call %s<cr>', a:keys, a:func)
    exec printf('vnoremap %s <esc>:exec "norm! gv" <bar> call %s<cr>', a:keys, a:func)

    " use forced motion wise or v
    exec printf('onoremap <expr> %s printf(":normal %%s%s<cr>",
                \ mode(1) ==# "no" ? "v" : mode(1)[2])', a:keys, a:keys)
endfunction
call s:add_mo('<plug>dedowsdi_mo_vertical_E', 'misc#mo#vertical_motion("E")')
call s:add_mo('<plug>dedowsdi_mo_vertical_W', 'misc#mo#vertical_motion("W")')
call s:add_mo('<plug>dedowsdi_mo_vertical_B', 'misc#mo#vertical_motion("B")')
call s:add_mo('<plug>dedowsdi_mo_expr', 'misc#mo#expr()')

" to {{{1

" key is executed as
"   exe "norm {vmode}{key}"
function s:omap(key, mode, default_vmode)
  let vmode = a:mode ==# 'no' ? a:default_vmode : a:mode[2]
  if vmode ==# "\<c-v>"
    let vmode .= vmode
  endif

  " apply forced motion, pass register.
  return printf(':exe "normal %s%s\"%s' . "\<cr>", vmode, a:key, v:register)
endfunction

" add text object, assume func prototype as: func(ai)
function s:add_to(ai, letter, default_vmode, func, ...) abort
  let prefix = get(a:000, 0, '<plug>dedowsdi_to_')
  if a:ai =~# 'a'
    let key = printf('%sa%s', prefix, a:letter)
    exe printf('vnoremap %s <esc>:silent! call call("%s", ["a"])<cr>', key, a:func)
    exe printf('onoremap <expr> %s <sid>omap(''\%s'', mode(1), "%s")', key, key, a:default_vmode)
  endif

  if a:ai =~# 'i'
    let key = printf('%si%s', prefix, a:letter)
    exe printf('vnoremap %s <esc>:silent! call call("%s", ["i"])<cr>', key, a:func)
    exe printf('onoremap <expr> %s <sid>omap(''\%s'', mode(1), "%s")', key, key, a:default_vmode)
  endif
endfunction

call s:add_to('ai', 'a', 'v',      'misc#to#sel_cur_arg')
call s:add_to('i',  'e', 'v',      'misc#to#sel_expr')
call s:add_to('ai', 'l', 'v',      'misc#to#sel_letter')
call s:add_to('ai', 'n', 'v',      'misc#to#sel_number')
call s:add_to('i',  'c', '\<c-v>', 'misc#to#column')
call s:add_to('ai', 'f', 'V',      'misc#viml#sel_func', '<plug>dedowsdi_viml_to_')

" op {{{1

" circumvent count, register changes
function s:setup_opfunc(func)
  let &opfunc = a:func
  return 'g@'
endfunction

function s:add_op(key, func)
  exe printf('nnoremap <expr> %s <sid>setup_opfunc("%s")', a:key, a:func)
  exe printf('vnoremap %s :<c-u>call %s(visualmode(), 1)<cr>', a:key, a:func)
endfunction

call s:add_op('<plug>dedowsdi_op_search_literal', 'misc#op#search_literal')
call s:add_op('<plug>dedowsdi_op_substitute', 'misc#op#substitude')
call s:add_op('<plug>dedowsdi_op_system', 'misc#op#system')
call s:add_op('<plug>dedowsdi_op_bar', 'misc#op#column')
call s:add_op('<plug>dedowsdi_op_literal_grep', 'misc#op#literal_grep')
call s:add_op('<plug>dedowsdi_op_browse', 'misc#op#search_in_browser')

nnoremap <plug>dedowsdi_op_co :call misc#op#omo('co')<cr>
nnoremap <plug>dedowsdi_op_do :call misc#op#omo('do')<cr>
nnoremap <plug>dedowsdi_op_guo :call misc#op#omo('guo')<cr>
nnoremap <plug>dedowsdi_op_gUo :call misc#op#omo('gUo')<cr>
nnoremap <plug>dedowsdi_op_g~o :call misc#op#omo('gso')<cr>

" cpp {{{1
let g:mycpp_def_src_ext    = get(g:, 'mycpp_def_src_ext'    , 'cpp')
let g:mycpp_build_dir     = get(g:, 'mycpp_build_dir'     , './')

com CppDumpProjFile call mycpp#dump_proj_file()
com -nargs=* -complete=customlist,mycpp#make_complete CppRun           call mycpp#exe('cd %w && %E %a', 1, <q-args>, 0)
com -nargs=* -complete=customlist,mycpp#make_complete CppMake          update | call mycpp#exe('cd %B && make -j3 %A %t', 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppMakeFileName  exec 'CppMake ' . expand('%:t:r')
com -nargs=* -complete=customlist,mycpp#make_complete CppMakeRun       update | call mycpp#exe('cd %B && make %A %t && cd %w && %E %a', 1, <q-args>, 0)
com -nargs=* -complete=customlist,mycpp#make_complete CppMakeDebug     update | call mycpp#exe('cd %B && make %t && cd %w && gdb %A --args %E %a', 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppRenderdoc     call mycpp#exe('cd "%w" && renderdoccmd capture %A "%E" %a', 1, <q-args>)

let s:apitrace_opencmd = 'cd "%b" && qapitrace $(grep -oP "(?<=tracing to ).*$" trace.log)'
com -nargs=* -complete=customlist,mycpp#make_complete -bar CppApitrace   call mycpp#exe('cd "%w" && apitrace trace "%E" %a |& tee trace.log && ' . s:apitrace_opencmd, 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppOpenLastApitrace      call mycpp#exe(s:apitrace_opencmd, 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppNNL           call mycpp#exe('cd "%w" && nnl --activity="Frame Debugger" --exe="%E" --args="%a" ', 0, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppValgrind      call mycpp#exe('cd "%w" && valgrind %A %E ', 1, <q-args>)
com -nargs=+ -complete=customlist,mycpp#make_pp_complete CppMakePP  update | call mycpp#make_pp(<f-args>)
com -nargs=0 CppJsonProj                                              call mycpp#open_project_file()
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

" misc {{{1

let g:dedowsdi_misc_complete_maxitem_per_direction = 16
inoremap <plug>dedowsdi_misc_complete_next_expression <c-r>=misc#complete_expresson(0)<cr>
inoremap <plug>dedowsdi_misc_complete_prev_expression <c-r>=misc#complete_expresson(1)<cr>


com -range -nargs=+ T call misc#mult_t(<line1>, <line2>, <f-args>)
com -bar CamelToUnderscore exe printf('%%s/\v\C<%s>/%s/g', expand('<cword>'),
      \ misc#camel_to_underscore(expand('<cword>')))
com CamelToUnderscoreAndSearchNext CamelToUnderscore | exec "norm! \<c-o>" | SearchNextCamel
com SearchNextCamel call search('\v\C\w*[A-Z]\w*', 'W')
com -nargs=1 SetNotifySeverity call misc#log#set_notify_severity(<f-args>)

function s:repeat_plug_map(lhs, rhs)
  exec printf('nnoremap <silent> %s %s:silent! call repeat#set("\<lt>%s")<cr>',
        \ a:lhs, a:rhs, a:lhs[1:])
endfunction

call s:repeat_plug_map('<Plug>dedowsdi_misc_pair_add_space', ':call misc#expand_pair(1)<cr>')
call s:repeat_plug_map('<Plug>dedowsdi_misc_pair_minus_space', ':call misc#expand_pair(0)<cr>')
