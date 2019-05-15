autocmd BufReadPost *.l  if getline(1) =~? 'lpfgall.h' | set filetype=lpfg | else | set filetype=cpfg | endif
