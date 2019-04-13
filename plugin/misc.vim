if exists("g:loaded_misc_plugin")
  finish
endif
let g:loaded_misc_plugin = 1

" ==============================================================================
" cpp
" ==============================================================================

command! -nargs=? Cnec :call  mycpp#genEnumCase(<f-args>)
command! -nargs=* -complete=customlist,mycpp#makeComplete Cr     :call mycpp#run(<q-args>)
command! -nargs=* -complete=customlist,mycpp#makeComplete Cd     :call mycpp#debug(<q-args>)
command! -nargs=* -complete=customlist,mycpp#makeComplete Cm     :wa|silent call mycpp#make(<q-args>)
command! -nargs=* -complete=customlist,mycpp#makeComplete Cmr    :wa|silent call mycpp#makeRun(<q-args>)
command! -nargs=* -complete=customlist,mycpp#makeComplete Cmd    :wa|silent call mycpp#makeDebug(<q-args>)
command! -nargs=0 -complete=customlist,mycpp#makeComplete Cmake  :wa|silent call mycpp#cmake()
command! -nargs=* -complete=customlist,mycpp#makeComplete Cut    :silent call mycpp#updateTarget(<q-args>)

command! -nargs=* -complete=customlist,mycpp#makeComplete Crenderdoc :silent call mycpp#doTarget("renderdoccmd capture", <q-args>, '', 1)
command! -nargs=* -complete=customlist,mycpp#makeComplete Capitrace  :silent call mycpp#doTarget("apitrace trace", <q-args>, '')
command! -nargs=* -complete=customlist,mycpp#makeComplete CnvidiaGfxDebugger   :silent call mycpp#doTarget("LD_PRELOAD=~/.tgd/libs/libNvidia_gfx_debugger.so", <q-args>, '')
command! -nargs=* -complete=customlist,mycpp#makeComplete Cvalgrind   :silent call mycpp#doTarget("valgrind", <q-args>, '')
"refactor
command! -nargs=? Cgan :call mycpp#getArgNames({"type":"string", "reg":<q-args>})
command! -nargs=0 Db :call mycpp#debugging_break_line()
command! -nargs=0 Dp :call mycpp#debugging_print()

let g:mycppDefSrcExt    = get(g:, 'mycppDefSrcExt'    , 'cpp')
let g:mycppCreateSrc    = get(g:, 'mycppCreateSrc'    , 1)
let g:mycppClassPrefix  = get(g:, 'mycppClassPrefix'  , '')
let g:mycppPreRequisite = get(g:, 'mycppPreRequisite' , [])
let g:mycppStable       = get(g:, 'mycppStable'       , [])
let g:mycppMakes        = get(g:, 'mycppMakes'        , {})
let g:mycppBuildDir     = get(g:, 'mycppBuildDir'     , "./")

" ==============================================================================
" vim
" ==============================================================================
command! -nargs=0 V :source %
command! -nargs=0 VV :call  misc#viml#reloadLoadedScript()
command! -nargs=0 Vb :breakadd here
command! -nargs=0 Vbf :call misc#viml#breakFunction()
command! -nargs=? Vgf :call misc#viml#gotoFunction(<f-args>)
