"if exists("g:loaded_cppcfg")
  "finish
"endif
"let g:loaded_cppcfg = 1

:setlocal shiftwidth=2 tabstop=2

"cpp abbrevation
:iab <buffer>  sI #include
:iab <buffer>  ssc static_cast<>()<Left><Left><Left>
:iab <buffer>  sdc dynamic_cast<>()<left><left><left>
:iab <buffer>  scc const_cast<>()<left><left><left>
:iab <buffer>  src reinterpret_cast<>()<left><left><left>
:iab <buffer>  sss std::stringstream
:iab <buffer>  sspc std::static_pointer_cast<>()<left><left><left>
:iab <buffer>  sdpc std::dynamic_pointer_cast<>()<left><left><left>
:iab <buffer>  scpc std::const_pointer_cast<>()<left><left><left>
:iab <buffer>  srpc std::reinterpret_pointer_cast<>()<left><left><left>
:iab <buffer>  sup std::unique_ptr<><Left>
:iab <buffer>  ssp std::shared_ptr<><Left>
:iab <buffer>  sup std::unique_ptr<><Left>
:iab <buffer>  swp std::weak_ptr<><Left>
:iab <buffer>  sap std::auto_ptr<><Left>
:iab <buffer>  sfl std::forward_list<><Left>
:iab <buffer>  sus std::unordered_set<><Left>
:iab <buffer>  sum std::unordered_map<><Left>
:iab <buffer>  stpt template<typename T><Left>
:iab <buffer>  stpc template<class T><Left>

:iab <buffer>  Cfs //------------------------------------------------------------------------------

"macro
:iab <buffer> smd #ifdef _DEBUG<CR>#endif<esc>O
:iab <buffer> smif #if<CR>#endif<esc>O

"boost  abbreviation
:iab <buffer> br boost::regex
:iab <buffer> brm boost::regex_match()<Left>
:iab <buffer> brs boost::regex_search()<Left>
:iab <buffer> brr boost::regex_replace()<Left>
:iab <buffer> bsm boost::smatch


"sdl2
":iab <buffer> S SDL_
":iab <buffer> Sk SDLK_

"cscope-----------------------------------------------------
"if has("cscope")
  "set csprg=/usr/bin/cscope
  ""search cscope databases before tag files
  "set csto=0
  ""use cstag instead of tag
  "set cst
  ""print message when adding a cscope database
  "set nocsverb
  ""use quickfix
  "set cscopequickfix=s-,c-,d-,i-,t-,e-
  "" add any database in current directory
  "if filereadable("cscope.out")
    "cs add cscope.out
    "" else add database pointed to by environment
  "elseif $CSCOPE_DB != ""
    "cs add $CSCOPE_DB
  "endif
  "set csverb
"endif

"0 or s: Find this C symbol
"1 or g: Find this definition
"2 or d: Find functions called by this function
"3 or c: Find functions calling this function
"4 or t: Find this text string
"6 or e: Find this egrep pattern
"7 or f: Find this file
"8 or i: Find files #including this file
"nnoremap <Leader><Leader>s :lcs find s <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>g :lcs find g <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>c :lcs find c <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>t :lcs find t <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>e :lcs find e <C-R>=expand("<cword>")<CR><CR>
"nnoremap <Leader><Leader>f :lcs find f <C-R>=expand("<cfile>")<CR><CR>
"nnoremap <Leader><Leader>i :lcs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nnoremap <Leader><Leader>d :lcs find d <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cs :cs find s <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cg :cs find g <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cc :cs find c <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Ct :cs find t <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Ce :cs find e <C-R>=expand("<cword>")<CR><CR>
"command! -nargs=0  Cf :cs find f <C-R>=expand("<cfile>")<CR><CR>
"command! -nargs=0  Ci :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"command! -nargs=0  Cd :cs find d <C-R>=expand("<cword>")<CR><CR>

"check ctags --list-kind=c++ for detail
"Most of the time i need only functin declaration tags, i don't need function
"definition tags.
"command! -nargs=0 Cut :!ctags --c++-kinds=+p-f include/* src/*
