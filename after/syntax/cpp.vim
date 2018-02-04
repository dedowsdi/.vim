syn match glProcedure /\v\C<gl[A-Z]\w*/
syn match glPrimitive /\v\CGL[a-z]\w*/
syn match glEnum /\v\CGL_\w+/

highlight link glProcedure Function
highlight link glPrimitive Type
highlight link glEnum Macro
