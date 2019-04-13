let s:curFile = expand('%')
let s:testFile = expand("<sfile>:p:h").'/testfile.cpp'

"call myvim#startScript()

try
  silent execute 'edit ' . s:testFile
  let bnr = 0
  let s:fooRange = [[bnr,3,6,0],[bnr,3,8,0]]
  let s:var0Range = [[bnr,3,10,0], [bnr,3,19,0]]
  let s:var1Range = [[bnr,3,22,0], [bnr,3,35,0]]
  let s:var1FullRange = deepcopy(s:var1Range)
  let s:var1FullRange[0][2] -= 1
  let s:var2Range = [[bnr,3,38,0], [bnr,3,47,0]]
  let s:var2FullRange = deepcopy(s:var2Range)
  let s:var2FullRange[0][2] -= 1
  let s:var2FullRange[1][2] += 1
  let s:itemRanges = [s:var0Range, s:var1Range, s:var2Range]
  let s:totalRange = [[bnr,3,9,0], [bnr,3,49,0]]

  echom "test myvim#comparePos"
  call misc#test#assert(myvim#cmpPos([bnr, 1,1], [bnr, 3,2]) == -1, expand('<sfile>').':'.expand('<slnum>'))
  call misc#test#assert(myvim#cmpPos([bnr, 1,1], [bnr, 1,2]) == -1, expand('<sfile>').':'.expand('<slnum>'))
  call misc#test#assert(myvim#cmpPos([bnr, 1,1], [bnr, 1,1]) == 0 , expand('<sfile>').':'.expand('<slnum>'))
  call misc#test#assert(myvim#cmpPos([bnr, 3,1], [bnr, 1,2]) == 1 , expand('<sfile>').':'.expand('<slnum>'))
  call misc#test#assert(myvim#cmpPos([bnr, 3,3], [bnr, 3,1]) == 1 , expand('<sfile>').':'.expand('<slnum>'))

  echom "test myvim#replaceRange"
  call misc#test#assertEqual(myvim#getRange(s:fooRange, 'v'), "foo",
        \expand('<sfile>').':'.expand('<slnum>') )

  call myvim#replaceRange(s:fooRange, "abc", 'v')
  call misc#test#assertEqual(myvim#getRange(s:fooRange, 'v'), "abc",
        \expand('<sfile>').':'.expand('<slnum>') )

  call myvim#replaceRange(s:fooRange, "foo", 'v')
  call misc#test#assertEqual(myvim#getRange(s:fooRange, 'v'), "foo",
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test myvim#trimRange"
  call misc#test#assertEqual(s:var0Range, myvim#trimRange(s:var0Range),
        \expand('<sfile>').':'.expand('<slnum>') )
  call misc#test#assertEqual(s:var1Range, myvim#trimRange(s:var1FullRange),
        \expand('<sfile>').':'.expand('<slnum>') )
  call misc#test#assertEqual(s:var2Range, myvim#trimRange(s:var2FullRange),
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test myvim#swapRange"
  let var0 = myvim#getRange(s:var0Range, 'v')
  let var1 = myvim#getRange(s:var1Range, 'v')
  let var2 = myvim#getRange(s:var2Range, 'v')
  call myvim#swapRange(s:var0Range, s:var2Range, 'v')
  call misc#test#assertEqual(myvim#getRange(s:var0Range, 'v'), var2,
        \expand('<sfile>').':'.expand('<slnum>') )

  edit!

  echom "test myvim#searchOverPairs"
  call setpos('.', s:totalRange[0])
  call myvim#searchOverPairs(')', '({[<', 'W' )
  call misc#test#assertEqual(getpos('.'), s:totalRange[1],
        \expand('<sfile>').':'.expand('<slnum>') )

  call myvim#searchOverPairs('(', ')}]>', 'bW' )
  call misc#test#assertEqual(getpos('.'), s:totalRange[0],
        \expand('<sfile>').':'.expand('<slnum>') )

  call setpos('.', s:var1Range[0])
  call myvim#searchOverPairs(')', '({[<', 'W' )
  call misc#test#assertEqual(getpos('.'), s:totalRange[1],
        \expand('<sfile>').':'.expand('<slnum>') )

  call setpos('.', s:var1Range[0])
  call myvim#searchOverPairs('(', ')}]>', 'bW' )
  call misc#test#assertEqual(getpos('.'), s:totalRange[0],
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test misc#to#getArgs"
  call setpos('.', s:var1Range[0])
  call misc#test#assertEqual(misc#to#getArgs({}), [1,s:totalRange, s:itemRanges],
        \expand('<sfile>').':'.expand('<slnum>') )

  call setpos('.', s:var0Range[0])
  call misc#test#assertEqual(misc#to#getArgs({"direction":"l"}),
        \ [0,s:totalRange, s:itemRanges],
        \expand('<sfile>').':'.expand('<slnum>') )

finally | silent execute 'edit ' . s:curFile | endtry

"call myvim#endScript()
