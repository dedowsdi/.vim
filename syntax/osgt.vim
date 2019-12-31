if exists("b:current_syntax")
  finish
endif
" let b:current_syntax=1

syn match node_class /\v<osg\w*::\w+>/ contains=attribute
syn keyword stateset StateSet

" Attribute deriveds, uniform, shader
syn keyword attribute
      \ AlphaFunc BindImageTexture BlendColor BlendEquation BlendFunc BufferIndexBinding
      \ Capability ClampColor ClipControl ClipPlane ColorMask ColorMatrix CullFace Depth
      \ DepthRangeIndexed Fog FragmentProgram FrameBufferObject FrontFace Hint Light
      \ LightModel LineStipple LineWidth LogicOp Material Multisample PatchParameter
      \ Point PointSprite PolygonMode PolygonOffset PolygonStipple PrimitiveRestartIndex
      \ Program SampleMaski Sampler Scissor ScissorIndexed ShadeModel ShaderAttribute
      \ Stencil StencilTwoSided TexEnv TexEnvCombine TexEnvFilter TexGen TexMat Texture
      \ VertexAttribDivisor VertexProgram Viewport
      \ Uniform Shader
syn keyword node_property DataVariance
syn match trivial /\vUniqueID \d+\s*/

syn match gl_value /\<GL_[A-Z_]\+/

highlight link gl_value Constant
highlight link stateset keyword
highlight link stateset_property gl_value
highlight link attribute gl_value
highlight link node_class Type
highlight link node_property Special
highlight link trivial Comment
