if exists('g:loaded_zxdmd')
  finish
endif
let g:loaded_zxdmd = 1

iab M/ \frac{}{}<LEFT><LEFT><LEFT>
iab Ms \sqrt{}<LEFT>
iab Md \frac{\text{d}}{\text{d}x}

com MdAddBackSlash  :%s/\v\\@<!<(
      \sin|cos|tan|cot|arccos|arcsin|arctan|sinh|cosh|tanh|cosh|frac|sqrt|log
      \|pm
      \)>/\\\0/g
nnoremap \$ :normal! ^i$<Esc>A$<Esc>
com MdAddLineBreak :global /\v^[^#]/ :s/\v\s*$/  

com -buffer -nargs=+ LinkVimHelp let @+ = ddd#vimh#link_vim(0, <q-args>)
com -buffer -nargs=+ LinkNvimHelp let @+ = ddd#vimh#link_nvim(1, <q-args>)
com -buffer UpdateVimHelpLink call ddd#vimh#update_link(0)
com -buffer UpdateNvimHelpLink call ddd#vimh#update_link(1)
