" vim:set foldmethod=marker :

if exists('g:loaded_misc_plugin')
  finish
endif
let g:loaded_misc_plugin = 1

" cpp {{{1
let g:mycpp_def_src_ext    = get(g:, 'mycpp_def_src_ext'    , 'cpp')
let g:mycpp_build_dir     = get(g:, 'mycpp_build_dir'     , './')

com -nargs=* -complete=customlist,mycpp#make_complete CppRun           call mycpp#exe('cd %b && ./%e %a', 1, <q-args>, 0)
com -nargs=* -complete=customlist,mycpp#make_complete CppMake          update | call mycpp#exe('cd %B && make -j3 %A %t', 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppMakeFileName  exec 'CppMake ' . expand('%:t:r')
com -nargs=* -complete=customlist,mycpp#make_complete CppMakeRun       update | call mycpp#exe('cd %B && make %A %t && cd %b &&./%e %a', 1, <q-args>, 0)
com -nargs=* -complete=customlist,mycpp#make_complete CppMakeDebug     update | call mycpp#exe('cd %B && make %t && cd %b && gdb %A --args ./%e %a', 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppRenderdoc     call mycpp#exe('cd "%b" && renderdoccmd capture %A "./%e" %a', 1, <q-args>)

let s:apitrace_opencmd = 'cd "%b" && qapitrace $(grep -oP "(?<=tracing to ).*$" trace.log)'
com -nargs=* -complete=customlist,mycpp#make_complete -bar CppApitrace   call mycpp#exe('cd "%b" && apitrace trace "./%e" %a |& tee trace.log && ' . s:apitrace_opencmd, 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppOpenLastApitrace      call mycpp#exe(s:apitrace_opencmd, 1, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppNNL           call mycpp#exe('cd "%b" && nnl --activity="Frame Debugger" --exe="%e" --args="%a" ', 0, <q-args>)
com -nargs=* -complete=customlist,mycpp#make_complete CppValgrind      call mycpp#exe('cd "%b" && valgrind %A ./%e ', 1, <q-args>)
com -nargs=+ -complete=customlist,mycpp#make_pp_complete CppMakePP  update | call mycpp#make_pp(<f-args>)
com -nargs=0 CppJsonProj                                              call mycpp#open_project_file()
com -nargs=0 CppSearchDerived                                         call mycpp#search_derived()
com -nargs=0 CppCmake call mycpp#cmake()

com -nargs=* -complete=customlist,mycpp#make_complete CppDebug         call mycpp#debug(<q-args>)
com CppDebugToggleBreak call ycpp#debug_toggle_break()
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
    autocmd BufRead * call misc#undo#tag_start()
  augroup end
  nnoremap u :call misc#undo#safeundo()<cr>
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

" misc {{{1
com -range -nargs=+ T call misc#mult_t(<line1>, <line2>, <f-args>)
com -bar CamelToUnderscore exe printf('%%s/\v\C<%s>/%s/g', expand('<cword>'),
      \ misc#camel_to_underscore(expand('<cword>')))
com CamelToUnderscoreAndSearchNext CamelToUnderscore | exec "norm! \<c-o>" | SearchNextCamel
com SearchNextCamel call search('\v\C\w*[A-Z]\w*', 'W')
com -nargs=1 SetNotifySeverity call misc#log#set_notify_severity(<f-args>)
