autocmd BufRead *.l let &filetype = getline(1) =~? 'lpfgall.h' ? 'lpfg' : 'cpfg'
