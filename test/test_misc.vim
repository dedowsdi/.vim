let s:curFile = expand('%')
let s:testFile = expand("<sfile>:p:h").'/testfile.cpp'
let s:fooRange = [[3,6],[3,8]]
let s:var0Range = [[3,10], [3,19]]
let s:var1Range = [[3,21], [3,35]]
let s:var2Range = [[3,37], [3,46]]
let s:itemRanges = [s:var0Range, s:var1Range, s:var2Range]
let s:totalRange = [[3,9], [3,47]]

call misc#startScript()

try 
  silent execute 'edit ' . s:testFile

  echom "test misc#comparePos"
  call misc#test#assert(misc#cmpPos([1,1], [3,2]) == -1, expand('<sfile>').':'.expand('<slnum>'))
  call misc#test#assert(misc#cmpPos([1,1], [1,2]) == -1, expand('<sfile>').':'.expand('<slnum>'))
  call misc#test#assert(misc#cmpPos([1,1], [1,1]) == 0 , expand('<sfile>').':'.expand('<slnum>'))
  call misc#test#assert(misc#cmpPos([3,1], [1,2]) == 1 , expand('<sfile>').':'.expand('<slnum>'))
  call misc#test#assert(misc#cmpPos([3,3], [3,1]) == 1 , expand('<sfile>').':'.expand('<slnum>'))

  echom "test misc#replaceRange"
  call misc#test#assertEqual(misc#getRange(s:fooRange), "foo",
        \expand('<sfile>').':'.expand('<slnum>') )

  call misc#replaceRange(s:fooRange, "abc")
  call misc#test#assertEqual(misc#getRange(s:fooRange), "abc",
        \expand('<sfile>').':'.expand('<slnum>') )

  call misc#replaceRange(s:fooRange, "foo")
  call misc#test#assertEqual(misc#getRange(s:fooRange), "foo",
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test misc#swapRange" 
  let var0 = misc#getRange(s:var0Range)
  let var1 = misc#getRange(s:var1Range)
  let var2 = misc#getRange(s:var2Range)
  call misc#swapRange(s:var0Range, s:var2Range)
  call misc#test#assertEqual(misc#getRange(s:var0Range), var2,
        \expand('<sfile>').':'.expand('<slnum>') )

  silent normal! u

  echom "test misc#searchIgnoreScope"
  call cursor(s:totalRange[0])
  call misc#searchIgnoreScope(')', '({[<', {"direction":"l"} )
  call misc#test#assertEqual([line('.'), col('.')], s:totalRange[1],
        \expand('<sfile>').':'.expand('<slnum>') )

  call misc#searchIgnoreScope('(', ')}]>', {"direction":"h"} )
  call misc#test#assertEqual([line('.'), col('.')], s:totalRange[0],
        \expand('<sfile>').':'.expand('<slnum>') )

  call cursor(s:var1Range[0])
  call misc#searchIgnoreScope(')', '({[<', {"direction":"l"} )
  call misc#test#assertEqual([line('.'), col('.')], s:totalRange[1],
        \expand('<sfile>').':'.expand('<slnum>') )

  call cursor(s:var1Range[0])
  call misc#searchIgnoreScope('(', ')}]>', {"direction":"h"} )
  call misc#test#assertEqual([line('.'), col('.')], s:totalRange[0],
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test misc#getItemRanges"
  call cursor(s:var1Range[0])
  call misc#test#assertEqual(misc#getItemRanges({}), [1,s:totalRange, s:itemRanges],
        \expand('<sfile>').':'.expand('<slnum>') )

finally | silent execute 'edit ' . s:curFile | endtry

call misc#endScript()
