if exists("g:loaded_misc_plugin")
  finish
endif
let g:loaded_misc_plugin = 1

" ==============================================================================
" cpp
" ==============================================================================

let g:mycppDefSrcExt    = get(g:, 'mycppDefSrcExt'    , 'cpp')
let g:mycppBuildDir     = get(g:, 'mycppBuildDir'     , "./")

command! -nargs=* -complete=customlist,mycpp#makeComplete CppRun               : call mycpp#run(<q-args>)
command! -nargs=* -complete=customlist,mycpp#makeComplete CppDebug              : call mycpp#debug(<q-args>)
command! -nargs=* -complete=customlist,mycpp#makeComplete CppMake              : wa|silent call mycpp#make(<q-args>)
command! -nargs=* -complete=customlist,mycpp#makeComplete CppMakeRun           : wa|silent call mycpp#makeRun(<q-args>)
command! -nargs=* -complete=customlist,mycpp#makeComplete CppMakeDebug         : wa|silent call mycpp#makeDebug(<q-args>)
command! -nargs=* -complete=customlist,mycpp#makeComplete CppRenderdoc         : silent call mycpp#doTarget('renderdoccmd capture', <q-args>, '', 1)
command! -nargs=* -complete=customlist,mycpp#makeComplete CppApitrace          : silent call mycpp#doTarget('apitrace trace', <q-args>, '')
command! -nargs=* -complete=customlist,mycpp#makeComplete CppNvidiaGfxDebugger : silent call mycpp#doTarget('LD_PRELOAD=~/.tgd/libs/libNvidia_gfx_debugger.so', <q-args>, '')
command! -nargs=* -complete=customlist,mycpp#makeComplete CppValgrind          : silent call mycpp#doTarget('valgrind', <q-args>, '')
command! -nargs=0 CppJsonProj                                                  : call mycpp#openProjectFile()
command! -nargs=0 CppSearchDerived                                             : call mycpp#searchDerived()

" ==============================================================================
" vim
" ==============================================================================
command! -nargs=0 VimlReloadScript :call  misc#viml#reloadLoadedScript()
command! -nargs=0 VimlBreakHere :call misc#viml#breakHere()
command! -nargs=0 VimlBreakNumberedFunction :call misc#viml#breakNumberedFunction()
command! -nargs=? VimlGotoFunction :call misc#viml#gotoFunction(<f-args>)
command! -nargs=0 VimlJoin :call misc#viml#join()
command! -nargs=? List call misc#viml#list(expand('<sfile>'), expand('<slnum>'), <f-args>)

command! RecordYank :call misc#dc#startCopy(1)
command! RecordYankAppend :call misc#dc#startCopy(0)
command! RecordPaste :call misc#dc#paste()
command! RecordStop :call misc#dc#stopCopy()

