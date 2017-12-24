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

call myvim#startScript()

try 
  silent execute 'edit ' . s:testFile

  echom "test myvim#comparePos"
  call myvim#test#assert(myvim#cmpPos([1,1], [3,2]) == -1, expand('<sfile>').':'.expand('<slnum>'))
  call myvim#test#assert(myvim#cmpPos([1,1], [1,2]) == -1, expand('<sfile>').':'.expand('<slnum>'))
  call myvim#test#assert(myvim#cmpPos([1,1], [1,1]) == 0 , expand('<sfile>').':'.expand('<slnum>'))
  call myvim#test#assert(myvim#cmpPos([3,1], [1,2]) == 1 , expand('<sfile>').':'.expand('<slnum>'))
  call myvim#test#assert(myvim#cmpPos([3,3], [3,1]) == 1 , expand('<sfile>').':'.expand('<slnum>'))

  echom "test myvim#replaceRange"
  call myvim#test#assertEqual(myvim#getRange(s:fooRange), "foo",
        \expand('<sfile>').':'.expand('<slnum>') )

  call myvim#replaceRange(s:fooRange, "abc")
  call myvim#test#assertEqual(myvim#getRange(s:fooRange), "abc",
        \expand('<sfile>').':'.expand('<slnum>') )

  call myvim#replaceRange(s:fooRange, "foo")
  call myvim#test#assertEqual(myvim#getRange(s:fooRange), "foo",
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test myvim#trimRange"
  call myvim#test#assertEqual(s:var0Range, myvim#trimRange(s:var0Range),
        \expand('<sfile>').':'.expand('<slnum>') )
  call myvim#test#assertEqual(s:var1Range, myvim#trimRange(s:var1FullRange),
        \expand('<sfile>').':'.expand('<slnum>') )
  call myvim#test#assertEqual(s:var2Range, myvim#trimRange(s:var2FullRange),
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test myvim#swapRange" 
  let var0 = myvim#getRange(s:var0Range)
  let var1 = myvim#getRange(s:var1Range)
  let var2 = myvim#getRange(s:var2Range)
  call myvim#swapRange(s:var0Range, s:var2Range)
  call myvim#test#assertEqual(myvim#getRange(s:var0Range), var2,
        \expand('<sfile>').':'.expand('<slnum>') )

  silent normal! u

  echom "test myvim#searchWithJumpPair"
  call cursor(s:totalRange[0])
  call myvim#searchWithJumpPair(')', '({[<', {"direction":"l"} )
  call myvim#test#assertEqual([line('.'), col('.')], s:totalRange[1],
        \expand('<sfile>').':'.expand('<slnum>') )

  call myvim#searchWithJumpPair('(', ')}]>', {"direction":"h"} )
  call myvim#test#assertEqual([line('.'), col('.')], s:totalRange[0],
        \expand('<sfile>').':'.expand('<slnum>') )

  call cursor(s:var1Range[0])
  call myvim#searchWithJumpPair(')', '({[<', {"direction":"l"} )
  call myvim#test#assertEqual([line('.'), col('.')], s:totalRange[1],
        \expand('<sfile>').':'.expand('<slnum>') )

  call cursor(s:var1Range[0])
  call myvim#searchWithJumpPair('(', ')}]>', {"direction":"h"} )
  call myvim#test#assertEqual([line('.'), col('.')], s:totalRange[0],
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test myvim#getItemRanges"
  call cursor(s:var1Range[0])
  call myvim#test#assertEqual(myvim#getItemRanges({}), [1,s:totalRange, s:itemRanges],
        \expand('<sfile>').':'.expand('<slnum>') )

  call cursor(s:var0Range[0])
  call myvim#test#assertEqual(myvim#getItemRanges({"direction":"l"}), 
        \ [0,s:totalRange, s:itemRanges],
        \expand('<sfile>').':'.expand('<slnum>') )

finally | silent execute 'edit ' . s:curFile | endtry

call myvim#endScript()
