syn match glProcedure /\v\C<gl[A-Z]\w*/
syn match glPrimitive /\v\CGL[a-z]\w*/

highlight link glProcedure Function
highlight link glPrimitive Type
