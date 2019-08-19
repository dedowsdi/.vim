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

setlocal shiftwidth=2 tabstop=2 textwidth=80
setlocal commentstring=//\ %s
setlocal formatoptions-=o

" text object
vnoremap <buffer> af :<C-U>silent! call cdef#selPf('a')<cr>
vnoremap <buffer> if :<C-U>silent! call cdef#selPf('i')<cr>
onoremap <buffer> af :normal vaf<cr>
onoremap <buffer> if :normal vif<cr>

" operator
nnoremap ,f :set opfunc=misc#op#clangFormat<cr>g@
vnoremap ,f  :<c-u>call misc#op#clangFormat(visualmode(), 1)<cr>
nmap <expr> ,ff ',f' . v:count1 . '_'

" external application
nnoremap <buffer> <leader>aa :CppApitrace
nnoremap <buffer> <leader>al :CppOpenLastApitrace
nnoremap <buffer> <leader>ar :CppRenderdoc<cr>
nnoremap <buffer> <leader>an :CppNNL<cr>

" misc
" nnoremap <f4>  :YcmCompleter GetType<cr>
nnoremap <buffer> <c-j>      :call <sid>fzf_cpp_btags()<cr>
nnoremap <buffer> <a-o>      :CdefSwitchFile<cr>
nnoremap <buffer> <c-f7>     :YcmDiags<cr>
inoremap <buffer> <c-l>      ->
nnoremap <buffer> <f8>       :CdefSwitch<cr>
nnoremap <buffer> <leader>ed :CdefDef<cr>
vnoremap <buffer> <leader>ed :CdefDef<cr>
nnoremap <buffer> <leader>ei :call mycpp#manualInclude()<cr>
nnoremap <buffer> <s-f7>     :CppMakeFileName<cr>

if !exists(':FZF')
  finish
endif

"type, scope, signature, inheritance

function s:fzf_cpp_btags()

  let fzf_btags_cmd = 'ctags -D "META_Object(library,name)=" -f -
            \ --excmd=number --sort=no --fields-c++=+{properties}{template}
            \ --fields=KsSi --kinds-c++=+pUN --links=yes --language-force=c++'
  " display everything except filename and line number.
  " fuzzy search all fields.
  call fzf#vim#buffer_tags(
        \ '',[fzf_btags_cmd . ' ' . expand('%:S')],
        \ {'options' :
        \      '--tiebreak=begin --with-nth 1,4.. --nth .. --prompt "Ctags> "'}
        \ )
endfunction
