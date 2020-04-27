function ddd#proj#load_map(type)
  if a:type ==# 'c'
    nnoremap <f5> :CppMakeRun<cr>
    nnoremap <c-f5> :CppDebug<cr>
    nnoremap <s-f5> :CppDebugStop<cr>
    nnoremap <f6> :CppCmake<cr>
    nnoremap <f7> :CppMake<cr>
    nnoremap <c-f2> :CppDebugEvaluate<cr>
    vnoremap <c-f2> :<c-u>CppDebugEvaluate<cr>
    nnoremap <f9> :CppDebugToggleBreak<cr>
    nnoremap <f10> :CppDebugNext<cr>
    nnoremap <c-f10> :CppDebugContinue<cr>
    nnoremap <c-f11> :CppDebugStep<cr>
    nnoremap <s-f11> :CppDebugFinish<cr>
    nnoremap <a-u> :CppDebugFrameUp<cr>
    nnoremap <a-d> :CppDebugFrameDown<cr>
  endif
endfunction
