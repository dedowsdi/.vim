"""""""""""""""""""""""""""""""""""""
"  Language:ogre2 hlms template     "
"""""""""""""""""""""""""""""""""""""

if exists("b:current_syntax")
  finish
endif

let s:parenInner = '%([^().-])'
let s:parenLvl1 = '%(\('.s:parenInner.'*\))'
let s:parenLvl2 = '%(\(%('.s:parenLvl1.'|'.s:parenInner.')*\))'
let s:parenLvl3 = '%(%('.s:parenLvl2.'|'.s:parenInner.')*)'

syn match hlms_templateFactor /\v\@\w+/
"syn match hlms_templateStatement /\v(\@\w+\s*\()@<=[^()]+(\))@=/
"syn match hlms_templatePreprocessor /\v\@%(property|end|foreach|counter|value|set|add|sub|mul|div|mod|min|max|piece|insertpiece|pset|padd|psub|pmul|pdiv|pmod|pmin|pmax)%(\s*\([^()]*\))?/
    "\ contains=hlms_templateStatement
exec 'syn match hlms_templateStatement /\v(\@\w+\s*\()@<='.s:parenLvl3.'(\))@=/'
exec 'syn match hlms_templatePreprocessor /\v\@%(property|end|foreach|counter|value|set|add|sub|mul|div|mod|min|max|piece|insertpiece|pset|padd|psub|pmul|pdiv|pmod|pmin|pmax)%(\s*\('.s:parenLvl3.'\))?/ contains=hlms_templateStatement'

highlight link hlms_templateFactor Identifier
highlight link hlms_templateStatement Statement
highlight link hlms_templatePreprocessor PreProc
