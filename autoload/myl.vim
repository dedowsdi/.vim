function! myl#runLpfg()
  :call misc#term#jtermopen({'cmd':'lpfg -w 800 800 -wp 1000 30 ' . expand('%'), 'closeAll':1})
endfunction
