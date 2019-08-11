if exists('b:loaded_glsl_cfg')
  finish
endif
let b:loaded_glsl_cfg = 1

setlocal shiftwidth=2 tabstop=2 textwidth=80
setlocal commentstring=//\ %s
setlocal complete-=t
" setlocal complete+=s
" setlocal thesaurus+=~/.vim/thesaurus/glsl.txt
setlocal omnifunc=syntaxcomplete#Complete

" setup glslang option
let s:glsl_stages = {
            \    'vert': ['vert', 'vs', 'vs.glsl'],
            \    'frag': ['frag', 'fs', 'fs.glsl'],
            \    'geom': ['geom', 'gs', 'gs.glsl'],
            \    'comp': ['comp', 'cs', 'cs.glsl'],
            \    'tesc': ['tesc', 'cont', 'tc', 'tc.glsl'],
            \    'tese': ['tese', 'eval', 'te', 'te.glsl'],
            \   }


function! s:getStage()
    let filename = expand('%:t')
    for [stage, extensions] in items(s:glsl_stages)
        for extension in extensions
            if filename =~ printf('\v.+\.%s$', extension)
                return stage
            endif
        endfor 
    endfor
    return ''
endfunction

let s:stage = s:getStage()
if s:stage ==# ''
  echoe 'faled to determine stage'
endif

let b:ale_glsl_glslang_options = printf('-S %s', s:stage)

" text object
vnoremap <buffer> if :<C-U>silent! call cdef#selPf('i')<cr>
onoremap <buffer> af :normal vaf<cr>
onoremap <buffer> if :normal vif<cr>

nnoremap <buffer> <c-j> :call G_fzf_cpp_btags()<cr>
nnoremap <buffer> <a-o> :call myglsl#alternate()<cr>
