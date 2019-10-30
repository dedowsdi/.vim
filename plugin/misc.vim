if exists('g:loaded_misc_plugin')
  finish
endif
let g:loaded_misc_plugin = 1

" ==============================================================================
" cpp
" ==============================================================================

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

" ==============================================================================
" vim
" ==============================================================================
com! -nargs=0 VimlReloadScript :call  misc#viml#reload_loaded_script()
com! -nargs=0 VimlBreakHere :call misc#viml#break_here()
com! -nargs=0 VimlBreakNumberedFunction :call misc#viml#break_numbered_function()
com! -nargs=? VimlGotoFunction :call misc#viml#goto_function(<f-args>)
com! -nargs=0 VimlJoin :call misc#viml#join()
com! -nargs=? List call misc#viml#list(expand('<sfile>'), expand('<slnum>'), <f-args>)
com! -nargs=+ -complete=command AbortDo call misc#abort_do(<f-args>)
com! -nargs=+ LinkVimHelp let @+ = misc#create_vimhelp_link(<q-args>)
com! -nargs=+ LinkNvimHelp let @+ = misc#create_nvimhelp_link(<q-args>)
com! UpdateVimHelpLink call misc#update_link(0)
com! UpdateNvimHelpLink call misc#update_link(1)

com! RecordYank :call misc#dc#start_copy(1)
com! RecordYankAppend :call misc#dc#start_copy(0)
com! RecordPaste :call misc#dc#paste()
com! RecordStop :call misc#dc#stop_copy()
com! -bar CamelToUnderscore exe printf('%%s/\v\C<%s>/%s/g', expand('<cword>'),
      \ misc#camel_to_underscore(expand('<cword>')))
com! CamelToUnderscoreAndSearchNext CamelToUnderscore | exec "norm! \<c-o>" | SearchNextCamel
com! SearchNextCamel call search('\v\C\w*[A-Z]\w*', 'W')
com! -nargs=1 SetNotifySeverity call misc#log#set_notify_severity(<f-args>)

com! -nargs=+ -complete=customlist,s:tt_complete TT call system('tmux_tt ' . <q-args>)

cnoremap <a-h> <c-\>emisc#hist#expand(0)<cr>
cnoremap <c-a> <c-b>
cnoremap <a-a> <c-a>
cnoremap <a-k> <c-\>e(getcmdpos() == 1 ? '' : getcmdline()[0:getcmdpos()-2])<cr>
cnoremap <a-u> <c-\>emisc#cmdline#word_case(1)<cr>
cnoremap <a-l> <c-\>emisc#cmdline#word_case(0)<cr>
cnoremap <a-d> <c-\>emisc#cmdline#forward_delete()<cr>
cnoremap <a-b> <c-left>
cnoremap <a-f> <c-right>

function! s:tt_complete(ArgLead, CmdLine, CursorPos)
  return sort(filter(systemlist('cd ~/.tt_template && printf "%s\n" *'),
        \ 'stridx(v:val, a:ArgLead)==0'))
endfunction
