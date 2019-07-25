autocmd!

" ------------------------------------------------------------------------------
" basic setting
" ------------------------------------------------------------------------------
scriptencoding utf-8
set list listchars=trail:┄,tab:†·,extends:>,precedes:<,nbsp:+
scriptencoding
set ttimeout ttimeoutlen=5 timeoutlen=1000
set number ruler novisualbell showmode showcmd hidden mouse=a background=dark
set incsearch  ignorecase smartcase
set concealcursor=vn conceallevel=0
set autoindent smartindent expandtab smarttab
set shiftwidth=4 tabstop=8 softtabstop=4
set showmatch matchtime=3
set laststatus=2 cmdheight=2 scrolloff=1
set spell spelllang=en_us dictionary+=spell
set nrformats=octal,hex,bin
set path+=/usr/local/include
set backspace=indent,eol,start
let &backup = !has('vms')
set wildmenu history=200
set shellslash
set backupdir=$HOME/.vimbak directory=$HOME/.vimswap//
set sessionoptions+=unix,slash                     " use unix /
" search tag in dir of current file upward until root, use current dir tags if
" nothing found
set tags=./tags;,tags
set wildmode=longest,list " set wildmode to unix glob
set wildignore=*.o,*.a,*.so,tags,TAGS,*/.git/*,.git,*/build/*,build
set matchpairs+=<:>                                " add match pair for < and >
set fileencodings=ucs-bom,utf-8,default,gb18030,utf-16,latin1
let &grepprg = 'grep -n $* /dev/null --exclude-dir={.git,.hg} -I'
" set grepprg=ag\ --vimgrep\ $* grepformat=%f:%l:%c:%m
if executable('zsh')
  let &shell = '/bin/zsh -o extendedglob'
endif

filetype plugin indent on
syntax enable
packadd cfilter
runtime! ftplugin/man.vim

if has('nvim')
  set rtp^=$HOME/.vim,$HOME/.vim/after
  let g:python3_host_prog = '/usr/bin/python3'
  let &shada="'200,<50,s10,h"
  tnoremap <expr> <m-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
  " map to <c-f#> and <s-f#>
  for i in range(1,12)
    exec printf('map <f%d> <s-f%d>', i+12, i)
    exec printf('map <f%d> <c-f%d>', i+24, i)
  endfor
else
  set viminfo='500,<50,s10,h
  " viminfo= doesn't expand environment variable, check n of viminfo for detail
  let &viminfo .= ',r'.$VIMRUNTIME.'/doc'
  packadd termdebug
endif

call misc#terminal#setup()

" ------------------------------------------------------------------------------
" auto commands
" ------------------------------------------------------------------------------
augroup zxd_misc
  au!
  autocmd DirChanged * if filereadable('.vim/init.vim') | source .vim/init.vim | endif
  autocmd BufWritePost *.l if &filetype ==# 'lpfg' | call myl#runLpfg() | endif
  autocmd InsertEnter,InsertLeave * set cursorline!
  autocmd FileType * try | call call('abbre#'.expand('<amatch>'), [])
              \ | catch /.*/ | endtry
              \ | setlocal formatoptions-=o formatoptions+=j
augroup end

" ------------------------------------------------------------------------------
" plugin
" ------------------------------------------------------------------------------

" ale
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
\   'glsl' : ['glslang'],
\   'cpp'  : []
\}

let g:ale_glsl_glslang_executable = '/usr/local/bin/glslangValidator'

" ultisnips
let g:UltiSnipsSnippetsDir=$HOME.'/.config/nvim/plugged/misc/UltiSnips'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'

" ycm
let g:ycm_confirm_extra_conf = 0
" let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_trigger = 0
nnoremap <a-i> :let g:ycm_auto_trigger = !g:ycm_auto_trigger<cr>
inoremap <a-i> <c-r>=<sid>ycm_trigger_identifier()<cr>

function! s:ycm_trigger_identifier()
  let g:ycm_auto_trigger = 1
  augroup ycm_trigger_identifier
    au!
    autocmd InsertLeave * ++once let g:ycm_auto_trigger = 0
  augroup end
  do TextChangedI
  return ''
endfunction
" following semantic triggers will break ultisnips suggestion
" let g:ycm_semantic_triggers = {'c':['re!\w{4}'], 'cpp':['re!\w{4}']}
let g:ycm_server_python_interpreter = '/usr/bin/python3'
" default ycm cfg file
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1
" remove tab from select_completion, it's used in ultisnips
let g:ycm_key_list_select_completion = ['<Down>']
" compile_command.json exists?
let g:ycm_autoclose_preview_window_after_insertion = 1

" easyalign

" fugitive
command! -nargs=* Glg Git! lg --color=never <args>
command! -nargs=* Glg Git! log --graph --pretty=format:'%h - <%an> (%ad)%d %s' --abbrev-commit --date=local <args>

" lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \ },
      \ 'component':
      \ {
      \     'test':'hello tabline'
      \ },
      \ }
if &t_Co == 256
  let g:lightline.colorscheme = 'gruvbox'
endif

" pymode
let g:pymode_rope_completion = 0

" fzf
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vertical rightbelow split',
      \ 'ctrl-a': 'argadd',
      \ 'ctrl-o': '!gvfs-open',
      \ 'ctrl-q': '!qapitrace'
      \ }
let g:fzf_layout = {'up':'~40%'}

function! s:fzf_cpp_tags(...)
  let query = get(a:000, 0, '')
  " there exists an extra field which i don't know how to control in
  " fzf#vim#tags, that's why it use 1,4..-2
  let tags_options = { 'options' : '--no-reverse -m -d "\t" --tiebreak=begin
              \ --with-nth 1,4..-2 -n .. --prompt "Ctags> "'}
  call fzf#vim#tags(
        \ query,
        \ extend(copy(g:fzf_layout), tags_options))
endfunction

command! -nargs=* Ctags :call <SID>fzf_cpp_tags(<q-args>)

" change FZF_DEFAULT_COMMAND, execute cmd, restore FZF_DEFALUT_COMMAND
function! s:fzf(fzf_default_cmd, cmd)
  let oldcmds = $FZF_DEFAULT_COMMAND | try
    let $FZF_DEFAULT_COMMAND = a:fzf_default_cmd
    execute a:cmd
  finally | let $FZF_DEFAULT_COMMAND = oldcmds | endtry
endfunction

let g:fzf_file_project = 'find . \( -name ".hg" -o -name ".git" -o
            \ -name "build" -o -name ".vscode" \) -prune -o -type f -print'

" tex
let g:tex_flavor = 'latex'
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk -layout <q-args> -
:command! -complete=file -nargs=1 Rpdffmt :r !pdftotext
            \ -nopgbrk -layout <q-args> - |fmt -csw78

" vim-json
let g:vim_json_syntax_conceal = 0

" markdown
let g:vim_markdown_conceal = 0

" indentLine
let g:indentLine_setConceal = 0

" auto-pairs
let g:AutoPairsShortcutToggle = '<a-a>'
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''

" gutentags
let g:gutentags_project_root = ['.vim']
let g:gutentags_exclude_project_root = [$HOME]
let g:gutentags_exclude_filetypes = ['cmake', 'sh', 'json', 'md']
let g:gutentags_define_advanced_commands = 1

" maps
function! s:omap(to)
  return printf(":normal v%s\"%s\<cr>", a:to, v:register)
endfunction

" text object
vnoremap aa :<C-U>silent! call misc#to#selCurArg({})<cr>
vnoremap ia :<C-U>silent! call misc#to#selCurArg({'excludeSpace':1})<cr>
onoremap <expr> ia <sid>omap('ia')
onoremap <expr> aa <sid>omap('aa')
vnoremap al :<C-U>silent! call misc#to#selLetter()<cr>
onoremap <expr> al <sid>omap('al')
vnoremap il :<C-U>silent! call misc#to#selLetter()<cr>
onoremap <expr> il <sid>omap('il')
vnoremap ic :<c-u>call misc#to#column()<cr>
onoremap <expr> ic <sid>omap('ic')

" circumvent count, register changes
function! s:setupOpfunc(func)
  let &opfunc = a:func
  return 'g@'
endfunction

function! s:addOp(key, func)
  exe printf('nnoremap <expr> %s <sid>setupOpfunc("%s")', a:key, a:func)
  exe printf('vnoremap %s :<c-u>call %s(visualmode(), 1)<cr>', a:key, a:func)
endfunction

" motion and operator
nmap     ,a  <Plug>(EasyAlign)
vmap     ,a  <Plug>(EasyAlign)
map      ,c  <Plug>Commentary
nmap     ,cc <Plug>CommentaryLine
nmap     ,cu <Plug>Commentary<Plug>Commentary
nmap     ,cs <plug>NERDCommenterSexy
vmap     ,cs <Plug>NERDCommenterSexy
nnoremap ,e  :call misc#mo#vertical_motion('E')<cr>
nnoremap ,w  :call misc#mo#vertical_motion('W')<cr>
nnoremap ,b  :call misc#mo#vertical_motion('B')<cr>
vnoremap ,e  :<c-u>exec 'norm! gv' <bar> call misc#mo#vertical_motion('E')<cr>
vnoremap ,w  :<c-u>exec 'norm! gv' <bar> call misc#mo#vertical_motion('W')<cr>
vnoremap ,b  :<c-u>exec 'norm! gv' <bar> call misc#mo#vertical_motion('B')<cr>
onoremap ,e  :normal v,e<cr>
onoremap ,w  :normal v,w<cr>
onoremap ,b  :normal v,b<cr>
nnoremap ,,  ,

call s:addOp(',l', 'misc#op#searchLiteral')
call s:addOp(',s', 'misc#op#substitude')
call s:addOp(',S', 'misc#op#system')
call s:addOp(',<bar>', 'misc#op#column')
nmap     ,sl :let @/="\\v<".expand("<cword>").">"<cr>vif:s/<c-r><c-/>/
nmap     ,s} :let @/="\\v<".expand("<cword>").">"<cr>vi}:s/<c-r><c-/>/
nmap     ,s{ ,s}
call s:addOp(',G', 'misc#op#literalGrep')
call s:addOp(',g', 'misc#op#searchInBrowser')

nnoremap yoc :exe 'set colorcolumn='. (empty(&colorcolumn) ? '+1' : '')<cr>
nnoremap -- :edit $MYVIMRC<cr>
nnoremap Y  y$
nnoremap K  :exec 'norm! K' <bar> wincmd p<cr>
nnoremap gc :SelectLastPaste<cr>

nnoremap <f3>    :set hlsearch!<cr>
nnoremap <f4>    :ALEHover<cr>
nnoremap <c-f7>  :ALELint<cr>
nnoremap <f12>   :YcmCompleter GoToDefinition<cr>
nnoremap <c-f12> :YcmCompleter GoToDeclaration<cr>

nnoremap <c-l> :nohlsearch<Bar>diffupdate<CR><C-L>
nnoremap <c-j> :BTags<cr>
nnoremap <c-h> :History<cr>
nnoremap <c-b> :Buffers<cr>
nnoremap <c-p> :call <sid>fzf(g:fzf_file_project, ":Files")<cr>
nnoremap <a-p> :FZF<cr>

" stop cursor movement from breaking undo in insert mode
inoremap <Left>  <c-g>U<Left>
inoremap <Right> <c-g>U<Right>
inoremap <C-Left>  <c-g>U<c-Left>
inoremap <C-Right> <c-g>U<c-Right>
inoremap <expr> <Home> repeat('<c-g>U<Left>', col('.') - 1)
inoremap <expr> <End> repeat('<c-g>U<Right>', col('$') - col('.'))
imap <a-l> <Right>
imap <a-h> <Left>

cnoremap <expr> %%  getcmdtype() == ":" ? expand("%:h")."/" : "%%"
cnoremap <expr> %t  getcmdtype() == ":" ? expand("%:t") : "%t"

nnoremap <leader>tt :call misc#term#toggleGterm()<cr>
tnoremap <leader>tt <c-\><c-n>:call misc#term#toggleGterm()<cr>
nnoremap <leader>th :call misc#term#hideall()<cr>
tnoremap <leader>th <c-\><c-n>:call misc#term#hideall()<cr>
nnoremap <leader>yd :YcmShowDetailedDiagnostic<cr>
nnoremap <leader>yf :YcmCompleter FixIt<cr>
nnoremap <leader>yt :YcmCompleter GetType<cr>

set rtp+=~/.fzf,.vim,.vim/after
call plug#begin('~/.config/nvim/plugged')
"Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' | Plug 'junegunn/vim-easy-align'
" Plug 'Yggdroot/indentLine'
" Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
" Plug 'jiangmiao/auto-pairs'
Plug 'ludovicchabant/vim-gutentags'
"Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rhubarb'
" Plug 'tpope/vim-scriptease'
" Plug 'alx741/vinfo'
Plug 'tommcdo/vim-exchange'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'             " snippets used in ultisnips
Plug 'itchyny/lightline.vim'
Plug 'Valloric/YouCompleteMe'         " auto complete
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'rhysd/vim-clang-format'         "clang c/c++ format
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'tikhomirov/vim-glsl'
Plug 'dedowsdi/cdef'
" Plug 'plasticboy/vim-markdown'
" Plug 'klen/python-mode'
" Plug 'pangloss/vim-javascript'
" Plug 'lervag/vimtex'                   " latex
call plug#end()

let g:gruvbox_number_column='bg1'
colorscheme gruvbox

function! s:less(cmd)
  exec 'e ' . tempname()
  setlocal buftype=nofile nobuflisted noswapfile
  exec printf('put! =execute(''%s'')', substitute(a:cmd, "'", "''", 'g'))
endfunction

" some tiny util
command! -nargs=+ LinkVimHelp let @+ = misc#createVimhelpLink(<q-args>)
command! -nargs=+ LinkNvimHelp let @+ = misc#createNvimhelpLink(<q-args>)
command! UpdateVimHelpLink call misc#updateLink(0)
command! UpdateNvimHelpLink call misc#updateLink(1)
command! -nargs=* EditTemp e `=tempname().'_'.<q-args>`
command! Synstack echo misc#synstack()
command! SynID echo synIDtrans(synID(line('.'), col('.'), 1))
command! -nargs=+ SynIDattr echo synIDattr(
            \ synIDtrans(synID(line('.'), col('.'), 1)), <f-args>)
command! HiTest source $VIMRUNTIME/syntax/hitest.vim
command! TrimTrailingWhitespace :keepp %s/\v\s+$//g
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
  \ | diffthis | wincmd p | diffthis
command! SelectLastPaste exec 'normal! `[' . getregtype() . '`]'
command! -nargs=+ -complete=command Less call <sid>less(<q-args>)
command! ReverseQuickFixList call setqflist(reverse(getqflist()))
command! SuperWrite :w !sudo tee % > /dev/null
command! ToggleAutoPairs :call AutoPairsToggle()
command! Terminal exe 'terminal' |
            \ call term_sendkeys("", printf("cd %s \<cr>",
            \ fnamemodify(bufname(winbufnr(winnr('#'))), ':h') ) )
