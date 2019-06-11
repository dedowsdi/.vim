if exists("g:loaded_zxdmd")
  finish
endif
let g:loaded_zxdmd = 1

iab M/ \frac{}{}<LEFT><LEFT><LEFT>
iab Md \frac{\text{d}}{\text{d}x}
iab Mi \int\_{a}^{b} f(x) \text{d}x
iab Ms \sum\_{i=0}^n

command! MdAddBackSlash  :%s/\v\\@<!<(
      \sin|cos|tan|cot|arccos|arcsin|arctan|sinh|cosh|tanh|cosh|frac|sqrt|log
      \|pm
      \)>/\\\0/g
nnoremap \$ :normal! ^i$<Esc>A$<Esc>

command! MdAddLineBreak :global /\v^[^#]/ :s/\v\s*$/  
