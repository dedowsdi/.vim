let s:cur_file = expand('%')
let s:test_file = expand("<sfile>:p:h").'/testfile.cpp'

try
  let v:errors = []
  silent execute 'edit ' . s:test_file
  let bnr = 0
  let s:foo_range = [[bnr,3,6,0],[bnr,3,8,0]]
  let s:var0_range = [[bnr,3,10,0], [bnr,3,19,0]]
  let s:var1_range = [[bnr,3,22,0], [bnr,3,35,0]]
  let s:var1_full_range = deepcopy(s:var1_range)
  let s:var1_full_range[0][2] -= 1
  let s:var2_range = [[bnr,3,38,0], [bnr,3,47,0]]
  let s:var2_full_range = deepcopy(s:var2_range)
  let s:var2_full_range[0][2] -= 1
  let s:var2_full_range[1][2] += 1
  let s:item_ranges = [s:var0_range, s:var1_range, s:var2_range]
  let s:total_range = [[bnr,3,9,0], [bnr,3,49,0]]

  echom "test misc#compare_pos"
  call assert_true(misc#cmp_pos([bnr, 1,1], [bnr, 3,2]) == -1, expand('<sfile>').':'.expand('<slnum>'))
  call assert_true(misc#cmp_pos([bnr, 1,1], [bnr, 1,2]) == -1, expand('<sfile>').':'.expand('<slnum>'))
  call assert_true(misc#cmp_pos([bnr, 1,1], [bnr, 1,1]) == 0 , expand('<sfile>').':'.expand('<slnum>'))
  call assert_true(misc#cmp_pos([bnr, 3,1], [bnr, 1,2]) == 1 , expand('<sfile>').':'.expand('<slnum>'))
  call assert_true(misc#cmp_pos([bnr, 3,3], [bnr, 3,1]) == 1 , expand('<sfile>').':'.expand('<slnum>'))

  echom "test misc#replace_range"
  call assert_equal( "foo",misc#get_range(s:foo_range, 'v'),
        \expand('<sfile>').':'.expand('<slnum>') )

  call misc#replace_range(s:foo_range, "abc", 'v')
  call assert_equal( "abc",misc#get_range(s:foo_range, 'v'),
        \expand('<sfile>').':'.expand('<slnum>') )

  call misc#replace_range(s:foo_range, "foo", 'v')
  call assert_equal( "foo",misc#get_range(s:foo_range, 'v'),
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test misc#trim_range"
  call assert_equal(s:var0_range, misc#trim_range(s:var0_range),
        \expand('<sfile>').':'.expand('<slnum>') )
  call assert_equal(s:var1_range, misc#trim_range(s:var1_full_range),
        \expand('<sfile>').':'.expand('<slnum>') )
  call assert_equal(s:var2_range, misc#trim_range(s:var2_full_range),
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test misc#swap_range"
  let var0 = misc#get_range(s:var0_range, 'v')
  let var1 = misc#get_range(s:var1_range, 'v')
  let var2 = misc#get_range(s:var2_range, 'v')
  call misc#swap_range(s:var0_range, s:var2_range, 'v')
  call assert_equal(var2, misc#get_range(s:var0_range, 'v'),
        \expand('<sfile>').':'.expand('<slnum>') )

  edit!

  echom "test misc#search_over_pairs"
  call setpos('.', s:total_range[0])
  call misc#search_over_pairs(')', '({[<', 'W' )
  call assert_equal(s:total_range[1], getpos('.'),
        \expand('<sfile>').':'.expand('<slnum>') )

  call misc#search_over_pairs('(', ')}]>', 'bW' )
  call assert_equal(s:total_range[0], getpos('.'),
        \expand('<sfile>').':'.expand('<slnum>') )

  call setpos('.', s:var1_range[0])
  call misc#search_over_pairs(')', '({[<', 'W' )
  call assert_equal(s:total_range[1], getpos('.'),
        \expand('<sfile>').':'.expand('<slnum>') )

  call setpos('.', s:var1_range[0])
  call misc#search_over_pairs('(', ')}]>', 'bW' )
  call assert_equal(s:total_range[0], getpos('.'),
        \expand('<sfile>').':'.expand('<slnum>') )

  echom "test misc#to#get_args"
  call setpos('.', s:var1_range[0])
  call assert_equal([1,s:total_range, s:item_ranges], misc#to#get_args({}),
        \expand('<sfile>').':'.expand('<slnum>') )

  call setpos('.', s:var0_range[0])
  call assert_equal([0,s:total_range, s:item_ranges],
        \ misc#to#get_args({"direction":"l"}),
        \expand('<sfile>').':'.expand('<slnum>') )

  if !empty(v:errors)
    echo v:errors
  endif

finally | silent execute 'edit ' . s:cur_file | endtry

"call misc#end_script()
