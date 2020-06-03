" vim:set foldmethod=marker:

" This vimrc should also work for 8.0(default version on ubuntu18.04).
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

" options {{{1

" basic {{{2
" show tab and trailing space
scriptencoding utf-8
set list listchars=trail:…,tab:†·,extends:>,precedes:<,nbsp:+
scriptencoding

" for convenience, add all children to path.
set path+=**

" ignore tool and build
set wildignore=*/build/*,*/.git/*,*/.hg/*,*/.vscode/*,*/.clangd/*,*.o,*.a,*.so,*.dll,tags
set wildignorecase

" reduce esc delay to a acceptable number
set ttimeout ttimeoutlen=5 timeoutlen=1000

" copy indent of current line to newline
set autoindent

" smart indent for {, }, 'cinwords', #
set smartindent

" no tab, use shiftwidth in front of a line. use 4 for <tab> or <bs>
set expandtab smarttab shiftwidth=4 tabstop=8 softtabstop=4

" traditional backspace
set backspace=indent,eol,start

" turn on \C if uppercase letter appears in the pattern for /,?,:g,:s,n,N., not
" for *,# (unless you use / after them)
set ignorecase smartcase

" trigger CursorHold more frequently, required by coc
set updatetime=300

" make <c-a>, <c-x> work on decimal, hex, binary
set nrformats=octal,hex,bin

" mv swp, bak, undo out of file directory, use %usr%home%.vimswap%... style name
let &backup = !has('vms')
set backupdir=$HOME/.vimbak//
set directory=$HOME/.vimswap//
set undofile undodir=$HOME/.vimundo//

" hide buffer when it's abandoned
set hidden

" turn on wild menu, complete 1st match
set wildmenu
set wildmode=full

" use unix / and 0a as new line in session file
set sessionoptions+=unix,slash

" use unix / in expand()
set shellslash

" scan current and included files might cause problem if lots file are
" included, restrict pop up menu height,
set complete-=i pumheight=16

" enable mouse for all modes. Sometimes you need it to copy something.
set mouse=a

" conceal only in visual and normal mode
set concealcursor=vn conceallevel=0

" display search count
set shortmess-=S

" hide gui menu, toolbar
if has('gui_running')
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set lines=100 columns=999
endif

set exrc secure

if has('nvim')
  set rtp+=~/.vim
endif

" search tag in dir of current file upward until root, use current dir tags if
" nothing found
" set tags=./tags;,tags

" add -I to ignore binary file, -D to ignore device files, exclude some dirs
let &grepprg = 'grep -n -I -D skip --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.clangd} $* /dev/null'

" if executable('zsh')
"   let &shell = '/bin/zsh -o extendedglob'
" endif

" some common fileencoding, the less general encoding must appear before the
" more general one
set fileencodings=ucs-bom,utf-8,default,gb18030,utf-16,latin1

" add spell to i_ctrl-x_ctrl-k
set nospell spelllang=en_us dictionary+=spell

" save mark for 500files, limit saved register to 50 lines, exclude register
" greater than 10kbytes, no hlsearch during loading of viminfo.
set viminfo='500,<50,s10,h

" supress redraw during map, macro
set lazyredraw

" use Man as keywordprg
runtime! ftplugin/man.vim
set keywordprg=:Man

" statusline has higher precedence, ruler only works if status line is
" invisible.
set ruler

" viminfo= doesn't expand environment variable, check n of viminfo for detail.
" don't save anything for help files.
let &viminfo .= ',r'.$VIMRUNTIME.'/doc'

" trivial options
set incsearch
set background=dark
set history=4096
set undolevels=4096
set number
set laststatus=2 cmdheight=2
set scrolloff=5
set showmode showcmd novisualbell
set noshowmatch matchtime=3 matchpairs+=<:>
set belloff=esc
set nofoldenable
set signcolumn=number

" statusline {{{2
let g:ddd_status_exprs = ['ddd#status#git_head', 'coc#status', 'ddd#make#progress']
set statusline=

" left item, starts with space
let &statusline .= '%( %f%)'                         " file tail
let &statusline .= '%( %{ddd#status#eval_exprs()}%)' " expressions
let &statusline .= '%( %r%)'                         " readonly
let &statusline .= '%( %m%)'                         " modified
let &statusline .= '%='                              " separation point

" right items, ends with space
let &statusline .= '%-14.(%l,%c%V%) %P | '           " ruler
let &statusline .= '%(%{&ff} %)'                     " file format
let &statusline .= '| %{empty(&fenc)?&enc:&fenc} '   " file encoding
let &statusline .= '| %{&ft} '    " file filetype

" cursor {{{2
" use underscore for insert, replace mode, use black on white full block for other mode
if stridx($TERM, 'linux') == -1
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

" truecolor {{{2
if exists('VIM_TRUECOLOR')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
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
let g:UltiSnipsJumpForwardTrigger='<c-l>'
let g:UltiSnipsJumpBackwardTrigger='<c-h>'

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
nmap <c-w><cr> <plug>ddd_gterm_toggle
tmap <c-w><cr> <plug>ddd_gterm_toggle
nmap g<cr>  <plug>ddd_gterm_repeat_cmd
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

" .vim {{{2
let g:ddd_clang_format_py_path = '/usr/share/clang/clang-format-8/clang-format.py'
" let g:ddd_clang_format_fallback_style = 'LLVM'

let g:ddd_hist_use_vim_regex_search = 1
let g:ddd_popup_scroll_keys = ['<c-y>', '<c-e>', '<c-f>']
let g:ddd_connect_ctag_server = 1

" install plugins {{{2

if v:version > 800
  packadd! cfilter
  packadd! termdebug
endif
packadd! matchit

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https:/ githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd! vim_plug_init VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" common
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
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

" plug#end() already call these commented commands
" filetype plugin indent on
" syntax enable

colorscheme solarized

" autocmd {{{1

augroup ag_ddd_init | au!

  " no auto comment leader after o or O, remove comment leader when join comment lines
  autocmd FileType * setlocal formatoptions-=o formatoptions+=j

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

nnoremap Y  y$
nnoremap gc :SelectLastChange<cr>
nnoremap yoc :exe 'set colorcolumn='. (empty(&colorcolumn) ? '+1' : '')<cr>
nnoremap <c-l> :nohlsearch<Bar>diffupdate<CR><C-L>

nnoremap <c-w><space> :tab split<cr>
nnoremap <c-w><nul> :tab split<cr>
tnoremap <c-w><space> <c-w>:tab split<cr>
tnoremap <c-w><nul> <c-w>:tab split<cr>
nnoremap <c-w>O :CloseFinishedTerminal<cr>
nnoremap <expr> <c-w>0 printf(':<c-u>%dWinFitBuf<cr>', v:count)

" go to normal mode, scroll to last command start
tnoremap <expr> <c-w>u printf('<c-\><c-n>2?%s<cr>zt',
      \ exists('PS1_VIM_PATTERN') ? $PS1_VIM_PATTERN : '^([ic])-->')

" termwinkey is special, there is a mapping delay for <c-w>,c-w> if you create
" any tmap that starts with <c-w>
tnoremap <c-w><c-w> <c-w><c-w>

if v:version > 800
  cmap <tab> <Plug>ddd_hist_expand_hist_wild
  set wildchar=<c-z>
endif

nmap ys<space> <plug>ddd_pair_add_space
nmap ds<space> <plug>ddd_pair_minus_space

" command {{{1

com SelectLastChange exec 'normal! `[' . getregtype() . '`]'

com ReverseQuickFixList call setqflist(reverse(getqflist()))

com SuperWrite :w !sudo tee % > /dev/null

com -bang CfilterCoreHelp Cfilter<bang> '\v/vim/vim\d+/doc/[^/]+\.txt'

com ReloadDotVimFtplugin unlet b:loaded_{&filetype}_cfg | e

" Less {{{2
com -nargs=+ -complete=command Less call <sid>less(<q-args>, <q-mods>)
com NewOneOff call <sid>new_oneoff(<q-mods>)

function s:new_oneoff(mods) abort
  exe a:mods 'new'
  setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted modifiable
endfunction

function s:less(cmd, mods)
  let winid = win_getid()
  NewOneOff
  exe printf('put! =win_execute(%d, %s)', winid, string(a:cmd))
  1
endfunction
