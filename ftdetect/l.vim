autocmd BufReadPost *.l  let &filetype = getline(1) =~? 'lpfgall.h' ? 'lpfg' : 'cpfg'
