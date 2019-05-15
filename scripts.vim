let str = getline(1)
if str =~? '-*-c++-*-' | set filetype=cpp 
  finish
endif
