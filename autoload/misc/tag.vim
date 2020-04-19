function misc#tag#readtagsi(args) abort
  let cmd = printf( 'readtagsi %s %s',
              \ join( map( tagfiles(), { i,v-> printf('-t "%s"', v)  } ) ),
              \ a:args )
  call misc#log#debug(cmd)
  call append( line('.'), systemlist(cmd) )
endfunction
