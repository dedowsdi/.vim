"""""""""""""""""""""""""""""""""""""
"  Language:ogre2 hlms material     "
"""""""""""""""""""""""""""""""""""""

if exists("b:current_syntax")
  finish
endif

" material property
syn keyword materialParameter
      \ diffuse
      \ specular
      \ roughness
      \ fresnel
      \ diffuse_map
      \ normal_map
      \ roughness_map
      \ specular_map
      \ detail_map0
      \ detail_map1
      \ detail_map2
      \ detail_map3
      \ detail_blend_mode0
      \ detail_blend_mode1
      \ detail_blend_mode2
      \ detail_blend_mode3
      \ detail_normal_map0
      \ detail_normal_map1
      \ detail_normal_map2
      \ detail_normal_map3
      \ detail_offset_scale0
      \ detail_offset_scale1
      \ detail_offset_scale2
      \ detail_offset_scale3
      \ detail_weight_map

" material type
syn keyword materialType pbs unlit

" material statement
syn keyword materialStatement hlms

" comment
syn match materialComment /\/\/.*/

highlight link materialParameter Type
highlight link materialStatement Statement
highlight link materialComment Comment
highlight link materialType Underlined
