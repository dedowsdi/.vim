" vim:set foldmethod=marker:

" This vimrc require vim8.2 on unix system to work properly, otherwise it's
" finished after statusline setting.
"
" Map and command are public interface, plugin settings and functions are
" private implementation, interface must appear before implementation.
"
" Only include frequently used command and function here, others belong
" to ddd.vim.
"
" ddd comes from 3 d of dedowsdi
"
" Put simple plugins in ddd.vim, others in ddd/...
" Put simple utils in dddu.vim, others in dddu/...
" All plugin map starts with <plug>ddd_
" All global variables starts with g:ddd_
"
" Don't create things that's might be useful, it's useless most of time.

let g:tinyrc_is_partof_vimrc = 1
source <sfile>:h/tinyrc

let $VIM_HOST_TERM = $TERM

" statusline {{{2
set statusline=%<                                    " trancate at start

" left item, starts with space
let &statusline .= ' %f'                             " file tail
if has('unix') && exists('*fugitive#head')           " expressions
  let g:ddd_status_exprs =  ['ddd#status#git_head', 'coc#status', 'ddd#make#progress']
  let &statusline .= '%( %{ddd#status#eval_exprs()}%)'
endif
let &statusline .= '%( %r%)'                         " readonly
let &statusline .= '%( %m%)'                         " modified
" let &statusline .= ' %#StatusLineNC#'                " dark middle
let &statusline .= '%='                              " separation point

" right items, ends with space
" let &statusline .= '%0* '                            " restore color
let &statusline .= '%-14.(%l,%c%V%) %P '             " ruler
let &statusline .= '| %{&ff} '                       " file format
let &statusline .= '| %{&fenc} '                     " file encoding
let &statusline .= '| %Y '                           " file filetype

" finish if it's non unix
if v:version < 802 || ( has('win32') && !executable('wsl') )
  if globpath(&rtp, 'colors/solarized.vim') !=# ''
    colorscheme solarized
  endif

  filetype plugin indent on
  syntax enable

  finish
endif

" cursor {{{2
if stridx($TERM, 'linux') != -1
  let &t_ve = "\e[?25h"
  let &t_vi = "\e[?25l"
  let &t_SI = "\e[?0c"
  let &t_EI = "\e[?16;143;255c"
  set t_ti& t_te&
  let &t_ti .= "\e[?16;143;255c"
  let &t_te .= "\e[?0c"
else
  if exists('$TMUX')
    let &t_SI = "\ePtmux;\e\e[5 q\e\\"
    let &t_SR = "\ePtmux;\e\e[3 q\e\\"
    let &t_EI = "\ePtmux;\e\e[2 q\e\\"
  else
    let &t_SI = "\e[5 q"
    let &t_SR = "\e[3 q"
    let &t_EI = "\e[2 q"
  endif
endif

" plugin {{{1

" ale {{{2
nnoremap <c-f7>  :ALELint<cr>

let g:ale_vim_vint_show_style_issues = 0
let g:ale_linters_explicit = 1

" you can not disable lint while enable language server, so i turn off auto
" lint.
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_insert_leave = 0

let g:ale_linters = {
\   'vim': ['vint'],
\   'sh': ['shellcheck'],
\   'glsl' : [],
\   'python' : [],
\   'cpp'  : []
\}

" ultisnips {{{2
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" split your window for :UltiSnipsEdit
let g:UltiSnipsEditSplit='vertical'

" coc.nvim {{{2
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <c-s> :call CocActionAsync('showSignatureHelp')<cr>
inoremap <c-s> <c-r>=CocActionAsync('showSignatureHelp')<cr>

nmap <f2> <Plug>(coc-rename)
nnoremap <f3> :CocHover<cr>
nmap <f12> <Plug>(coc-definition)

com CocDiagnosticInfo exec "norm \<plug>(coc-diagnostic-info)"
com CocReference exec "norm \<plug>(coc-references)"
com CocDefinition exec "norm \<plug>(coc-definition)"
com CocTypeDefinition exec "norm \<plug>(coc-type-definition)"
com CoImplementation exec "norm \<plug>(coc-implementation)"
com CocHover call CocActionAsync('doHover')
com CocCodeAction call CocActionAsync('codeAction')
com CocSymbols CocList symbols

let g:coc_global_extensions = ['coc-json', 'coc-syntax', 'coc-ultisnips']

" fugitive {{{2
com -nargs=* Glg Git! log --graph --pretty=format:'%h - <%an> (%ad)%d %s' --abbrev-commit --date=local <args>

" hare {{{2
nnoremap <c-p> :Src<cr>
nnoremap <c-h> :History<cr>
nnoremap <c-b> :Ls<cr>
nnoremap <c-k> :Btag<cr>

" make {{{2
nnoremap <f7> :Make<up><cr>
let g:ddd_make_success_cb = 'GtermRepeat'

" proj {{{2
com -nargs=1 Proj call ddd#proj#load_map(<f-args>)

" gterm {{{2
nnoremap <c-w><cr> :<c-u>GtermToggle<cr>
if exists(':tmap')
  tnoremap <c-w><cr> <c-w>:<c-u>GtermToggle<cr>
endif
nnoremap g<cr>  :<c-u>GtermRepeat<cr>
if stridx($TERM, '16color') != -1
  let g:ddd_gterm_init_cmd = [ 'TERM=xterm-16color' ]
endif

" vimtex {{{2
com -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk -layout <q-args> -
com -complete=file -nargs=1 Rpdffmt :r !pdftotext
            \ -nopgbrk -layout <q-args> - |fmt -csw78

let g:tex_flavor = 'latex'

" vim-json {{{2
let g:vim_json_syntax_conceal = 0

" easyalign {{{2
nmap     ,a  <Plug>(EasyAlign)
xmap     ,a  <Plug>(EasyAlign)

" commentary {{{2
map      ,c  <Plug>Commentary
sunmap   ,c
nmap     ,cc <Plug>CommentaryLine
nmap     ,cu <Plug>Commentary<Plug>Commentary

" .vim {{{
if has('win32')
  let g:ddd_clang_format_py_path = 'c:/Program Files/LLVM/share/clang/clang-format.py'
else
  let g:ddd_clang_format_py_path = '/usr/share/clang/clang-format/clang-format.py'
endif
" let g:ddd_clang_format_fallback_style = 'LLVM'

let g:ddd_hist_use_vim_regex_search = 1
let g:ddd_popup_scroll_keys = ['<c-y>', '<c-e>', '<c-f>']
let g:ddd_connect_ctag_server = 1

" install plugins {{{2

" require https:/ githubusercontent.com/junegunn/vim-plug/master/plug.vim
set noshellslash
call plug#begin(expand('~/.vim/plugged'))

" common
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tommcdo/vim-exchange'

" colorscheme
Plug 'dedowsdi/vim-colors-solarized'

" comment
Plug 'tpope/vim-commentary'

" lint
Plug 'w0rp/ale'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ftplugin
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'tikhomirov/vim-glsl'
Plug 'lervag/vimtex'
Plug 'dedowsdi/cdef'

call plug#end()
set shellslash

" plug#end() already call these commented commands
" filetype plugin indent on
" syntax enable

colorscheme solarized

" autocmd {{{1

augroup ag_ddd_init | au!

  " no auto comment leader after o or O, remove comment leader when join comment lines
  autocmd FileType * setlocal formatoptions-=o formatoptions+=j

  if exists('#TerminalWinOpen')
    autocmd TerminalWinOpen * setlocal nonumber norelativenumber
  endif

  " clear TextChanged, TextChangedI, TextChangedP. You can use DoMatchParen if
  " you want to turn it on later
  autocmd VimEnter * exe 'NoMatchParen' | au! UltiSnips_AutoTrigger
augroup end

" all kinds of maps {{{1

call ddd#terminal#setup()

" text object {{{2
function s:add_to(lhs, rhs) abort
  exe printf('xmap %s %s', a:lhs, a:rhs)
  exe printf('omap %s %s', a:lhs, a:rhs)
endfunction

call s:add_to('il', '<plug>ddd_to_il')
call s:add_to('al', '<plug>ddd_to_al')
call s:add_to('in', '<plug>ddd_to_in')
call s:add_to('an', '<plug>ddd_to_an')
call s:add_to('ic', '<plug>ddd_to_ic')

" motion and operator {{{2
map ,e <plug>ddd_mo_vertical_E
sunmap ,e
map ,w <plug>ddd_mo_vertical_W
sunmap ,w
map ,b <plug>ddd_mo_vertical_B
sunmap ,b
nnoremap ,,  ,

function s:add_op(key, rhs)
  exe printf('nmap %s %s', a:key, a:rhs)
  exe printf('xmap %s %s', a:key, a:rhs)
endfunction

call s:add_op(',l',     '<plug>ddd_op_search_literal')
call s:add_op(',L',     '<plug>ddd_op_substitute_literal')
call s:add_op(',<bar>', '<plug>ddd_op_get_column')
call s:add_op(',g',     '<plug>ddd_op_search_in_browser')

nmap co  <plug>ddd_op_co
nmap dO  <plug>ddd_op_do
nmap guo <plug>ddd_op_guo
nmap gUo <plug>ddd_op_gUo
nmap g~o <plug>ddd_op_g~o
nmap ,f  <plug>ddd_op_clang_format
nmap <expr> ,ff ',f' . v:count1 . '_'

" common maps {{{2
nnoremap gc :SelectLastChange<cr>

nnoremap <c-w>O :CloseFinishedTerminal<cr>
nnoremap <expr> <c-w>0 printf(':<c-u>%dWinFitBuf<cr>', v:count)

" go to normal mode, scroll to last command start
if exists(':tmap')
  tnoremap <expr> <c-w>u <sid>goto_cmd_start()

  function s:goto_cmd_start() abort
    if has('win32')
      let pattern = &shell =~? 'cmd\.exe$' ? '^[c-z]:\\' : '^PS '
    else
      let pattern = '^([ic])-->'
    endif

    return printf("\<c-\>\<c-n>2?%s\<cr>zt",
                \ exists('PS1_VIM_PATTERN') ? $PS1_VIM_PATTERN :pattern)
  endfunction
endif

cmap <tab> <Plug>ddd_hist_expand_hist_wild
set wildchar=<c-z>

nmap ys<space> <plug>ddd_pair_add_space
nmap ds<space> <plug>ddd_pair_minus_space

" commands {{{1
