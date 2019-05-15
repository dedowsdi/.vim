if exists("did_load_filetypes") | finish | endif

augroup filetypedetect
  autocmd BufNewFile,BufRead *.cont,*.vert,*.tesc,*.tese,*.eval,*.geom,*.comp,*.frag set filetype=glsl
augroup END
