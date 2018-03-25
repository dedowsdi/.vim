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
command! -nargs=0 -complete=customlist,mycpp#makeComplete Cmaker :wa|silent call mycpp#cmake()

command! -nargs=* -complete=customlist,mycpp#makeComplete Crenderdoc :silent call mycpp#doTarget("renderdoccmd capture", <q-args>, '', 1)
command! -nargs=* -complete=customlist,mycpp#makeComplete Capitrace  :silent call mycpp#doTarget("apitrace trace", <q-args>, '')
command! -nargs=* -complete=customlist,mycpp#makeComplete CnvidiaGfxDebugger   :silent call mycpp#doTarget("LD_PRELOAD=~/.tgd/libs/libNvidia_gfx_debugger.so", <q-args>, '')
command! -nargs=* -complete=customlist,mycpp#makeComplete Cvalgrind   :silent call mycpp#doTarget("valgrind", <q-args>, '')
"refactor
command! -nargs=? Cgan :call mycpp#getArgNames({"type":"string", "reg":<q-args>})
command! -nargs=0 Db :call mycpp#debugging_break_line()
command! -nargs=0 Dp :call mycpp#debugging_print()

nnoremap <leader>cI :call mycpp#gotoLastInclude({"jump":1}) 
      \ <bar>:exec 'normal! o#include '
      \ <bar>:startinsert! <CR>

nnoremap <leader>csd :call mycpp#searchDerived()<CR>
nnoremap <leader>csi :call mycpp#findIncludes()<CR>

nnoremap <leader>bb :call mycpp#toggleBreakpoint()<CR>
"nnoremap <leader>bb :call mycpp#addDebugCommand('break')<CR>
nnoremap <leader>bw :call mycpp#addDebugCommand('watch')<CR>
nnoremap <leader>bs :call mycpp#singleLineBreak()<CR>
nnoremap <leader>mq :call mycpp#makeQuickfix()<CR>
nnoremap <leader>gt :call mycpp#doTarget("apitrace trace", "", "")<CR>
nnoremap <leader>gq :call mycpp#openLastApitrace()<CR>
nnoremap <leader>ga :call mycpp#doTarget("apitrace trace", "", 
\ '<bar>& tee trace.log && qapitrace `grep -oP "(?<=tracing to ).*$" trace.log`')<CR>
nnoremap <leader>gr :Crenderdoc<CR>
nnoremap <leader>gn :CnvidiaGfxDebugger<CR>
nnoremap <F5>       :Cmr<CR>

nnoremap _p :call mycpp#openProjectFile()<CR>
nnoremap _d :call mycpp#openDebugScript()<CR>

nnoremap <m-cr> :call misc#term#toggleGterm()<CR>
tnoremap <m-cr> <C-\><C-n>:call misc#term#toggleGterm()<CR>
nnoremap <C-h> :call misc#term#hideall()<CR>
tnoremap <C-h> <C-\><C-n>:call misc#term#hideall()<CR>

"some cpp head file has no extension
":nnoremap <leader>t :set filetype=cpp<CR>

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
command! -nargs=0 VV :call  reload#reloadLoadedScript()
command! -nargs=0 Vb :breakadd here
command! -nargs=0 Vbf :call myvim#breakFunction()
command! -nargs=? Vgf :call myvim#gotoFunction(<f-args>)
