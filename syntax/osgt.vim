if exists("b:current_syntax")
  finish
endif
" let b:current_syntax=1

syn match osgt_node_class /\v<osg\w*::\w+>/ contains=osgt_attribute
syn keyword osgt_stateset StateSet

" Attribute deriveds, uniform, shader
syn keyword osgt_attribute
      \ AlphaFunc BindImageTexture BlendColor BlendEquation BlendFunc BufferIndexBinding
      \ Capability ClampColor ClipControl ClipPlane ColorMask ColorMatrix CullFace Depth
      \ DepthRangeIndexed Fog FragmentProgram FrameBufferObject FrontFace Hint Light
      \ LightModel LineStipple LineWidth LogicOp Material Multisample PatchParameter
      \ Point PointSprite PolygonMode PolygonOffset PolygonStipple PrimitiveRestartIndex
      \ Program SampleMaski Sampler Scissor ScissorIndexed ShadeModel ShaderAttribute
      \ Stencil StencilTwoSided TexEnv TexEnvCombine TexEnvFilter TexGen TexMat Texture
      \ VertexAttribDivisor VertexProgram Viewport
      \ Uniform Shader

syn keyword osgt_node_property DataVariance Name UniqueID

syn match osgt_gl_value /\<GL_[A-Z_]\+/

syn match osgt_comment /^#.*/

hi! link osgt_gl_value Constant
hi! link osgt_stateset keyword
hi! link osgt_attribute osgt_gl_value
hi! link osgt_node_class Type
hi! link osgt_node_property Identifier
hi! link osgt_comment Comment
