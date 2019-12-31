if exists('did_load_filetypes') | finish | endif

" this file is sourced before the default FileType autocommands have been
" installed

" If your file type can be detected by file name
augroup filetypedetect
  au!
  autocmd! BufNewFile,BufRead *.cont,*.vert,*.tesc,*.tese,*.eval,*.geom,*.comp,*.frag setfiletype glsl
  autocmd! BufNewFile,BufRead *.compositor setfiletype compositor
  autocmd! BufNewFile,BufRead *.material setfiletype material
  autocmd! BufNewFile *.l setfiletype cpfg
  autocmd! BufNewFile,BufRead *.osgt setfiletype osgt
augroup END
