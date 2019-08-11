if exists('g:loaded_misc_plugin')
  finish
endif
let g:loaded_misc_plugin = 1

" ==============================================================================
" cpp
" ==============================================================================

let g:mycppDefSrcExt    = get(g:, 'mycppDefSrcExt'    , 'cpp')
let g:mycppBuildDir     = get(g:, 'mycppBuildDir'     , './')

com -nargs=* -complete=customlist,mycpp#makeComplete CppRun           call mycpp#run(<q-args>)
com -nargs=* -complete=customlist,mycpp#makeComplete CppMake          update|silent call mycpp#make(<q-args>)
com -nargs=* -complete=customlist,mycpp#makeComplete CppMakeFileName  exec 'CppMake ' . expand('%:t:r')
com -nargs=* -complete=customlist,mycpp#makeComplete CppMakeRun       update|silent call mycpp#makeRun(<q-args>)
com -nargs=* -complete=customlist,mycpp#makeComplete CppMakeDebug     update|silent call mycpp#makeDebug(<q-args>)
com -nargs=* -complete=customlist,mycpp#makeComplete CppRenderdoc     silent call mycpp#doTarget('renderdoccmd capture', <q-args>, '', 1)
com -nargs=* -complete=customlist,mycpp#makeComplete CppApitrace      silent call mycpp#doTarget('apitrace trace', <q-args>, '')
com -nargs=* -complete=customlist,mycpp#makeComplete CppValgrind      silent call mycpp#doTarget('valgrind', <q-args>, '')
com CppMakePP       update|silent call mycpp#makePP()
com -nargs=0 CppJsonProj                                              call mycpp#openProjectFile()
com -nargs=0 CppSearchDerived                                         call mycpp#searchDerived()
com -nargs=0 CppCmake call mycpp#cmake()

com -nargs=* -complete=customlist,mycpp#makeComplete CppDebug         call mycpp#debug(<q-args>)
com CppDebugToggleBreak call mycpp#debugToggleBreak()
com CppDebugStep        call mycpp#debugStep()
com CppDebugNext        call mycpp#debugNext()
com CppDebugContinue    call mycpp#debugContinue()
com CppDebugFinish      call mycpp#debugFinish()
com CppDebugEvaluate    call mycpp#debugEvaluate()
com CppDebugStop        call mycpp#debugStop()
com CppDebugFrameUp     call mycpp#debugFrameUp()
com CppDebugFrameDown   call mycpp#debugFrameDown()

" ==============================================================================
" vim
" ==============================================================================
com! -nargs=0 VimlReloadScript :call  misc#viml#reloadLoadedScript()
com! -nargs=0 VimlBreakHere :call misc#viml#breakHere()
com! -nargs=0 VimlBreakNumberedFunction :call misc#viml#breakNumberedFunction()
com! -nargs=? VimlGotoFunction :call misc#viml#gotoFunction(<f-args>)
com! -nargs=0 VimlJoin :call misc#viml#join()
com! -nargs=? List call misc#viml#list(expand('<sfile>'), expand('<slnum>'), <f-args>)

com! RecordYank :call misc#dc#startCopy(1)
com! RecordYankAppend :call misc#dc#startCopy(0)
com! RecordPaste :call misc#dc#paste()
com! RecordStop :call misc#dc#stopCopy()

com! -nargs=+ -complete=customlist,s:tt_complete TT call system('tmux_tt ' . <q-args>)

function! s:tt_complete(ArgLead, CmdLine, CursorPos)
  return sort(filter(systemlist('cd ~/.tt_template && printf "%s\n" *'),
        \ 'stridx(v:val, a:ArgLead)==0'))
endfunction

