" this file is loaded before $VIMRUNTIME/scripts.vim

" if your filetype can only be detected by content
let s:str = getline(1)
if s:str =~? '-*-c++-*-'
  setfiletype=cpp | finish
endif
