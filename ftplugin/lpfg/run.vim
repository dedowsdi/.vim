if exists('b:loaded_lpfg_run')
  finish
endif
let b:loaded_lpfg_run = 1

call misc#ui#loadFiletypeMap('lpfg')
