function! misc#cpp#loadAbbreviation()
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
  :iab <buffer>  cfoff // clang-format off
  :iab <buffer>  cfon // clang-format on

  :iab <buffer> smd #ifdef _DEBUG<CR>#endif<esc>O
  :iab <buffer> smif #if<CR>#endif<esc>O

  "boost  abbreviation
  :iab <buffer> br boost::regex
  :iab <buffer> brm boost::regex_match()<Left>
  :iab <buffer> brs boost::regex_search()<Left>
  :iab <buffer> brr boost::regex_replace()<Left>
  :iab <buffer> bsm boost::smatch

endfunction()
