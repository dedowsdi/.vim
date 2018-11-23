if exists("b:loaded_glsl_cfg")
  finish
endif
let b:loaded_glsl_cfg = 1

:setlocal shiftwidth=2 tabstop=2 textwidth=80 expandtab
call myvim#loadFiletypeMap('glsl')

" setup glslang option
let s:glsl_stages = {
            \    'vert': ['vert', 'vs', 'vs.glsl'],
            \    'frag': ['frag', 'fs', 'fs.glsl'],
            \    'geom': ['geom', 'gs', 'gs.glsl'],
            \    'comp': ['comp', 'cs', 'cs.glsl']
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

let stage = s:getStage()
if stage ==# ''
  echoe 'faled to determine stage'
endif

let b:ale_glsl_glslang_options = printf('-S %s', stage)
