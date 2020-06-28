if exists('b:loaded_cpp_cfg')
  finish
endif
let b:loaded_cpp_cfg = 1

Abbre cpp

com -buffer ReloadCppFtplugin call ddd#reload_ftplugin(['b:loaded_cpp_cfg', 'b:loaded_c_cfg'])
