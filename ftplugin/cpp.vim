if exists("b:loaded_cpp_cfg")
  finish
endif
let b:loaded_cpp_cfg = 1

:setlocal shiftwidth=2 tabstop=2 textwidth=80 expandtab
call mycpp#loadAbbreviation()

nmap     <buffer> <leader>de <Plug>CdefDefineTag
vmap     <buffer> <leader>de <Plug>CdefDefineRange
nmap     <buffer> <leader>df <Plug>CdefDefineFile
nmap     <buffer> <leader>du <Plug>CdefUpdatePrototype
nnoremap <buffer> <F5>       :Cmr<CR>
nnoremap <buffer> <F7>       :Cm<CR>
nmap     <buffer> <F8>       <Plug>CdefSwitchBetProtoAndFunc
nmap     <buffer> <F4>       <Plug>CdefSwitchFile
nmap     <buffer> <F2>       <Plug>CdefRename
