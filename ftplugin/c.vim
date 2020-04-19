if exists('b:loaded_c_cfg')
  finish
endif
let b:loaded_c_cfg = 1

setlocal cinoptions&
setlocal cinoptions+=l1  " case indent
setlocal cinoptions+=g0  " no accessor indent
"setlocal cinoptions+=h-s " no statement indent after accessor
setlocal cinoptions+=N-s " no namespace indent
" no indent for contiuous state ment, avoid indent after Q_OBJECT kind stuff.
" you need to manually indent for continuous line.
setlocal cinoptions+=+0

setlocal shiftwidth=4 tabstop=4 softtabstop=4 textwidth=80
setlocal commentstring=//\ %s
setlocal formatoptions-=o
setlocal foldmethod=indent

" text object
vnoremap <buffer> af :<C-U>silent! call cdef#sel_pf('a')<cr>
vnoremap <buffer> if :<C-U>silent! call cdef#sel_pf('i')<cr>
onoremap <buffer> af :normal vaf<cr>
onoremap <buffer> if :normal vif<cr>
vnoremap <buffer> aC :<C-U>silent! call cdef#sel_class('a')<cr>
vnoremap <buffer> iC :<C-U>silent! call cdef#sel_class('i')<cr>
onoremap <buffer> aC :normal vaC<cr>
onoremap <buffer> iC :normal viC<cr>

" external application
nnoremap <buffer> <leader>aa :CppApitrace<cr>
nnoremap <buffer> <leader>al :CppOpenLastApitrace<cr>
nnoremap <buffer> <leader>ar :CppRenderdoc<cr>
nnoremap <buffer> <leader>an :CppNNL<cr>

" misc
" nnoremap <f4>  :YcmCompleter GetType<cr>
nnoremap <buffer> <c-j>      :call <sid>fzf_cpp_btags()<cr>
nnoremap <buffer> <a-o>      :CdefSwitchFile<cr>
" nnoremap <buffer> <c-f7>     :YcmDiags<cr>
inoremap <buffer> <c-l>      ->
nnoremap <buffer> <f8>       :CdefSwitch<cr>
nnoremap <buffer> _d :CdefDef<cr>
vnoremap <buffer> _d :CdefDef<cr>
nnoremap <buffer> _D :CdefDefAndSwitch<cr>
vnoremap <buffer> _D :CdefDefAndSwitch<cr>
nnoremap <buffer> _p :CdefFuncToProto<cr>
nnoremap <buffer> _P :CdefFuncToProtoAndSwitch<cr>
nnoremap <buffer> _s :CdefCreateSourceFile<cr>
nnoremap <buffer> _h :CdefAddHeadGuard<cr>
nnoremap <buffer> _g :CdefGetSet<cr>
vnoremap <buffer> _g :CdefGetSet<cr>
nnoremap <buffer> _G :CdefConstGetSet<cr>
vnoremap <buffer> _G :CdefConstGetSet<cr>
nnoremap <buffer> <s-f7>     :CppMakeFileName<cr>
nnoremap <buffer> <leader>cc :CppConfig<cr>

if !exists(':FZF')
  finish
endif

"type, scope, signature, inheritance

function s:fzf_cpp_btags()

  let fzf_btags_cmd = '!ctags
        \ -f -
        \ --sort=no
        \ --fields-c++=+{properties}{template}
        \ --fields=ksSi
        \ --links=yes
        \ --language-force=c++ ' . expand('%')
        \ . '| cut -f1,3-'

  " display everything except filename and line number.
  " fuzzy search all fields.
  " call fzf#vim#buffer_tags(
  "       \ '',[fzf_btags_cmd . ' ' . expand('%:S')],
  "       \ {'options' :
  "       \      '--tiebreak=begin --with-nth 1,4.. --nth .. --prompt "Ctags> "'}
  "       \ )

  call misc#hare#jump('btag', fzf_btags_cmd)
endfunction
