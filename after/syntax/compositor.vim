"""""""""""""""""""""""""""""""""""""
"  Language:ogre2 compositor        "
"""""""""""""""""""""""""""""""""""""

if exists("b:current_syntax")
  finish
endif

syn keyword compositorBlock
      \ compositor_node
      \ target
      \ pass
      \ workspace
      \ shadow_map
      \ compositor_node_shadow

syn keyword compositorNodeParameter in out texture
syn keyword compositorTargetParameter slice
syn keyword compositorPassType
      \ clear
      \ generate_mipmaps
      \ quad
      \ resolve
      \ render_scene
      \ stencil
      \ uav_queue
      \ custom

syn keyword compositorPassParameter
      \ num_initial
      \ identifier
      \ execution_mask
      \ viewport_modifier_mask
      \ colour_value
      \ buffers
      \ colour_write
      \ depth_value
      \ stencil_value
      \ material
      \ input
      \ rq_first
      \ rq_last
      \ viewport
      \ use_quad
      \ expose
      \ camera
      \ overlays
      \ shadows
      \ visibility_mask
      \ viewport
      \ camera_cubemap_reorient
      \ lod_bias
      \ lod_update_list
      \ lod_camera
      \ check
      \ comp_func
      \ ref_value
      \ mask
      \ fail_op
      \ depth_fail_op
      \ pass_op
      \ two_sided
      \ keep_previous_uavs
      \ uav_external
      \ uav
      \ starting_slot
syn keyword compositorShadowNodeParameter
      \ num_splits
      \ light_direction_threshold
      \ optimal_adjust_factor
      \ use_aggressive_focus_region
      \ technique
      \ pssm_lambda

syn keyword compositorShadowTechnique uniform
      \ planeoptimal
      \ focused
      \ lispsm
      \ pssm

syn keyword compositorTextureFormat
      \ PF_A8R8G8B8
      \ PF_R8G8B8A8
      \ PF_R8G8B8
      \ PF_FLOAT16_RGBA
      \ PF_FLOAT16_RGB
      \ PF_FLOAT16_R
      \ PF_FLOAT32_RGBA
      \ PF_FLOAT32_RGB
      \ PF_FLOAT32_R

syn keyword compositorWorkspaceParameter connect connect_output alias
syn keyword compositorConstant on off yes no light split max


syn match compositorGlobalTexture /\v^global_\w+/
syn match compositorNumber /\v<[0-9.]+>|0x[0-9a-fA-f]+/
syn match compositorComment /\v\/\/.*/
"syn keyword compositorProperty

highlight link compositorBlock Structure
highlight link compositorWorkspaceParameter Identifier
highlight link compositorNodeParameter Identifier
highlight link compositorTargetParameter Underlined
highlight link compositorPassParameter Identifier
highlight link compositorShadowNodeParameter Identifier
highlight link compositorPassType Underlined
highlight link compositorShadowTechnique Underlined
highlight link compositorGlobalTexture Special
highlight link compositorNumber Special
highlight link compositorConstant Constant
highlight link compositorComment Comment

