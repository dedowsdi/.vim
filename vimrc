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

" show tab and trailing space
scriptencoding utf-8
set list listchars=trail:┄,tab:†·,extends:>,precedes:<,nbsp:+
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

" scan current and included files(might cause problem if lots file are
" included), restrict pop up menu height,
set complete-=i pumheight=16

" enable mouse for all modes. Sometimes you need it to copy something.
set mouse=a

" conceal only in visual and normal mode
set concealcursor=vn conceallevel=0

" add per project setting
set rtp+=.dedowsdi,.dedowsdi/after

" display search count
set shortmess-=S

if has('nvim')
  set rtp+=~/.vim
endif

" search tag in dir of current file upward until root, use current dir tags if
" nothing found
" set tags=./tags;,tags

" add -I to ignore binary file, exclude some dirs
let &grepprg = 'grep -n -I -D skip --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.clangd} $* /dev/null'

if executable('zsh')
  let &shell = '/bin/zsh -o extendedglob'
endif

" some common fileencoding, the less general encoding must appear before the
" more general one
set fileencodings=ucs-bom,utf-8,default,gb18030,utf-16,latin1

" add spell to i_ctrl-x_ctrl-k
set spell spelllang=en_us dictionary+=spell

" save mark for 500files, limit saved register to 50 lines, exclude register
" greater than 10kbytes, no hlsearch during loading of viminfo.
set viminfo='500,<50,s10,h

" viminfo= doesn't expand environment variable, check n of viminfo for detail.
" don't save anything for help files.
let &viminfo .= ',r'.$VIMRUNTIME.'/doc'

" trivial options
set incsearch
set background=dark
set history=1000
set undolevels=5000
set number ruler
set laststatus=2 cmdheight=2
set scrolloff=1
set showmode showcmd novisualbell
set noshowmatch matchtime=3 matchpairs+=<:>
set belloff=esc
set nofoldenable
set signcolumn=number

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
nnoremap <f4> :CocHover<cr>
nmap <s-f10> <Plug>(coc-references)
nmap <f12> <Plug>(coc-definition)
nmap <c-f12> <Plug>(coc-type-definition)
nmap <s-f12> <Plug>(coc-implementation)

com CocDiagnosticInfo exec "norm \<plug>(coc-diagnostic-info)"
com CocReference exec "norm \<plug>(coc-references)"
com CocHover call CocActionAsync('doHover')
com CocCodeAction call CocActionAsync('codeAction')

" fugitive {{{2
com -nargs=* Glg Git! log --graph --pretty=format:'%h - <%an> (%ad)%d %s' --abbrev-commit --date=local <args>

" lightline {{{2
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \ },
      \ 'component':
      \ {
      \     'test':'hello tabline'
      \ },
      \ }
augroup au_coc_status
  au!
  " it's annoying, it pollutes message and input prompt
  " autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup end

if &t_Co == 256
  let g:lightline.colorscheme = 'gruvbox'
endif

" hare {{{2
nnoremap <c-p> :Src<cr>
nnoremap <c-h> :History<cr>
nnoremap <c-b> :Ls<cr>
nnoremap <c-k> :Btag<cr>

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
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
Plug 'morhetz/gruvbox'

" comment
Plug 'tpope/vim-commentary'

" status line
Plug 'itchyny/lightline.vim'

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
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'tikhomirov/vim-glsl'
Plug 'lervag/vimtex'
Plug 'dedowsdi/cdef'

call plug#end()

" misc {{{1

runtime! ftplugin/man.vim
set keywordprg=:Man

call ddd#terminal#setup()

" plug#end() already call these commented commands
" filetype plugin indent on
" syntax enable

let g:gruvbox_number_column='bg1'
colorscheme gruvbox

" must be applied after colorscheme, avoid highlight overwrite.
if v:version > 800
  packadd! cfilter
  packadd! termdebug
endif
packadd! matchit

augroup ddd_default
  au!

  if v:version > 800

    " too dangerious?
    " autocmd DirChanged * if filereadable('.vim/init.vim') | source .vim/init.vim | endif
    if !has('nvim')
      autocmd TerminalWinOpen * setl nonumber norelativenumber
    endif
  endif

  autocmd InsertEnter,InsertLeave * set cursorline!

  " place cursor to the position when last existing
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " no auto comment leader after o or O, remove comment leader when join comment lines
  autocmd FileType * setlocal formatoptions-=o formatoptions+=j
augroup end

" all kinds of maps {{{1

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
map ,E <plug>ddd_mo_vertical_E
sunmap ,E
map ,W <plug>ddd_mo_vertical_W
sunmap ,W
map ,B <plug>ddd_mo_vertical_B
sunmap ,B
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
nmap do  <plug>ddd_op_do
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
tnoremap <c-w><space> <c-w>:tab split<cr>
nnoremap <c-w>O :CloseFinishedTerminal<cr>
nnoremap <expr> <c-w>0 printf(':<c-u>%dWinFitBuf<cr>', v:count)

if v:version > 800
  cmap <tab> <Plug>ddd_hist_expand_hist_wild
  set wildchar=<c-z>
endif

nmap ys<space> <plug>ddd_pair_add_space
nmap ds<space> <plug>ddd_pair_minus_space

nmap <c-n> <plug>ddd_term_toggle_gterm
tmap <c-n> <plug>ddd_term_toggle_gterm

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

" Tapi_cd {{{2
" arglist : [ cwd ]
" change window local working directory
function Tapi_lcd(bufnum, arglist)
  let winid = bufwinid(a:bufnum)
  let cwd = get(a:arglist, 0, '')
  if winid == -1 || empty(cwd)
    return
  endif
  call win_execute(winid, 'lcd ' . cwd)
endfunction
