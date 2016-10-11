let s:curFile = expand('%')
let s:testFile = expand("<sfile>:p:h").'/testfile.cpp'
let s:fooRange = [[3,6],[3,8]]
let s:var0Range = [[3,10], [3,19]]
let s:var1Range = [[3,22], [3,35]]
let s:var1FullRange = deepcopy(s:var1Range)
let s:var1FullRange[0][1] -= 1
let s:var2Range = [[3,38], [3,47]]
let s:var2FullRange = deepcopy(s:var2Range)
let s:var2FullRange[0][1] -= 1
let s:var2FullRange[1][1] += 1
let s:itemRanges = [s:var0Range, s:var1Range, s:var2Range]
let s:totalRange = [[3,9], [3,49]]

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

  echom "test misc#trimRange"
  call misc#test#assertEqual(s:var0Range, misc#trimRange(s:var0Range),
        \expand('<sfile>').':'.expand('<slnum>') )
  call misc#test#assertEqual(s:var1Range, misc#trimRange(s:var1FullRange),
        \expand('<sfile>').':'.expand('<slnum>') )
  call misc#test#assertEqual(s:var2Range, misc#trimRange(s:var2FullRange),
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test misc#swapRange" 
  let var0 = misc#getRange(s:var0Range)
  let var1 = misc#getRange(s:var1Range)
  let var2 = misc#getRange(s:var2Range)
  call misc#swapRange(s:var0Range, s:var2Range)
  call misc#test#assertEqual(misc#getRange(s:var0Range), var2,
        \expand('<sfile>').':'.expand('<slnum>') )

  silent normal! u

  echom "test misc#searchWithJumpPair"
  call cursor(s:totalRange[0])
  call misc#searchWithJumpPair(')', '({[<', {"direction":"l"} )
  call misc#test#assertEqual([line('.'), col('.')], s:totalRange[1],
        \expand('<sfile>').':'.expand('<slnum>') )

  call misc#searchWithJumpPair('(', ')}]>', {"direction":"h"} )
  call misc#test#assertEqual([line('.'), col('.')], s:totalRange[0],
        \expand('<sfile>').':'.expand('<slnum>') )

  call cursor(s:var1Range[0])
  call misc#searchWithJumpPair(')', '({[<', {"direction":"l"} )
  call misc#test#assertEqual([line('.'), col('.')], s:totalRange[1],
        \expand('<sfile>').':'.expand('<slnum>') )

  call cursor(s:var1Range[0])
  call misc#searchWithJumpPair('(', ')}]>', {"direction":"h"} )
  call misc#test#assertEqual([line('.'), col('.')], s:totalRange[0],
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test misc#getItemRanges"
  call cursor(s:var1Range[0])
  call misc#test#assertEqual(misc#getItemRanges({}), [1,s:totalRange, s:itemRanges],
        \expand('<sfile>').':'.expand('<slnum>') )

  call cursor(s:var0Range[0])
  call misc#test#assertEqual(misc#getItemRanges({"direction":"l"}), 
        \ [0,s:totalRange, s:itemRanges],
        \expand('<sfile>').':'.expand('<slnum>') )

finally | silent execute 'edit ' . s:curFile | endtry

call misc#endScript()
