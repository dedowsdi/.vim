let s:curFile = expand('%')
let s:testFile = expand("<sfile>:p:h").'/testfile.cpp'

try
  let v:errors = []
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

  echom "test misc#comparePos"
  call assert_true(misc#cmpPos([bnr, 1,1], [bnr, 3,2]) == -1, expand('<sfile>').':'.expand('<slnum>'))
  call assert_true(misc#cmpPos([bnr, 1,1], [bnr, 1,2]) == -1, expand('<sfile>').':'.expand('<slnum>'))
  call assert_true(misc#cmpPos([bnr, 1,1], [bnr, 1,1]) == 0 , expand('<sfile>').':'.expand('<slnum>'))
  call assert_true(misc#cmpPos([bnr, 3,1], [bnr, 1,2]) == 1 , expand('<sfile>').':'.expand('<slnum>'))
  call assert_true(misc#cmpPos([bnr, 3,3], [bnr, 3,1]) == 1 , expand('<sfile>').':'.expand('<slnum>'))

  echom "test misc#replaceRange"
  call assert_equal( "foo",misc#getRange(s:fooRange, 'v'),
        \expand('<sfile>').':'.expand('<slnum>') )

  call misc#replaceRange(s:fooRange, "abc", 'v')
  call assert_equal( "abc",misc#getRange(s:fooRange, 'v'),
        \expand('<sfile>').':'.expand('<slnum>') )

  call misc#replaceRange(s:fooRange, "foo", 'v')
  call assert_equal( "foo",misc#getRange(s:fooRange, 'v'),
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test misc#trimRange"
  call assert_equal(s:var0Range, misc#trimRange(s:var0Range),
        \expand('<sfile>').':'.expand('<slnum>') )
  call assert_equal(s:var1Range, misc#trimRange(s:var1FullRange),
        \expand('<sfile>').':'.expand('<slnum>') )
  call assert_equal(s:var2Range, misc#trimRange(s:var2FullRange),
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test misc#swapRange"
  let var0 = misc#getRange(s:var0Range, 'v')
  let var1 = misc#getRange(s:var1Range, 'v')
  let var2 = misc#getRange(s:var2Range, 'v')
  call misc#swapRange(s:var0Range, s:var2Range, 'v')
  call assert_equal(var2, misc#getRange(s:var0Range, 'v'),
        \expand('<sfile>').':'.expand('<slnum>') )

  edit!

  echom "test misc#searchOverPairs"
  call setpos('.', s:totalRange[0])
  call misc#searchOverPairs(')', '({[<', 'W' )
  call assert_equal(s:totalRange[1], getpos('.'),
        \expand('<sfile>').':'.expand('<slnum>') )

  call misc#searchOverPairs('(', ')}]>', 'bW' )
  call assert_equal(s:totalRange[0], getpos('.'),
        \expand('<sfile>').':'.expand('<slnum>') )

  call setpos('.', s:var1Range[0])
  call misc#searchOverPairs(')', '({[<', 'W' )
  call assert_equal(s:totalRange[1], getpos('.'),
        \expand('<sfile>').':'.expand('<slnum>') )

  call setpos('.', s:var1Range[0])
  call misc#searchOverPairs('(', ')}]>', 'bW' )
  call assert_equal(s:totalRange[0], getpos('.'),
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test misc#to#getArgs"
  call setpos('.', s:var1Range[0])
  call assert_equal([1,s:totalRange, s:itemRanges], misc#to#getArgs({}),
        \expand('<sfile>').':'.expand('<slnum>') )

  call setpos('.', s:var0Range[0])
  call assert_equal([0,s:totalRange, s:itemRanges],
        \ misc#to#getArgs({"direction":"l"}),
        \expand('<sfile>').':'.expand('<slnum>') )

  if !empty(v:errors)
    echo v:errors
  endif

finally | silent execute 'edit ' . s:curFile | endtry

"call misc#endScript()
