autocmd!

" ------------------------------------------------------------------------------
" basic setting
" ------------------------------------------------------------------------------
scriptencoding utf-8
set list listchars=trail:┄,tab:†·,extends:>,precedes:<,nbsp:+
scriptencoding
" set signcolumn=yes
set updatetime=300
set ttimeout ttimeoutlen=5 timeoutlen=1000
set number ruler novisualbell showmode showcmd hidden mouse=a background=dark
set incsearch ignorecase smartcase
set concealcursor=vn conceallevel=0
set autoindent smartindent expandtab smarttab
set shiftwidth=4 tabstop=8 softtabstop=4
set noshowmatch matchtime=3
set laststatus=2 cmdheight=2 scrolloff=1
set spell spelllang=en_us dictionary+=spell
set nrformats=octal,hex,bin
set path+=/usr/local/include
set complete-=i pumheight=16
set backspace=indent,eol,start
let &backup = !has('vms')
set wildmenu history=1000
set shellslash
set backupdir=$HOME/.vimbak directory=$HOME/.vimswap//
set sessionoptions+=unix,slash                     " use unix /
" search tag in dir of current file upward until root, use current dir tags if
" nothing found
" set tags=./tags;,tags
set wildmode=longest,list " set wildmode to unix glob
set wildignore=*.o,*.a,*.so,tags,TAGS,*/.git/*,*/build/*,*/.clangd/*
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
set keywordprg=:Man

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
  autocmd TerminalOpen * setl nonumber norelativenumber
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
\   'python' : [],
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
" let g:ycm_log_level = 'debug'
" let g:ycm_use_clangd = 0

let g:ycm_confirm_extra_conf = 0

" set this option will change completer to clangd ? Must be a bug.
" let g:ycm_clangd_binary_path='/usr/local/source/llvm8.0.0/bin/clangd'
" let g:ycm_clangd_args = '-background-index'

" following semantic triggers will break ultisnips suggestion
" let g:ycm_semantic_triggers = {'c':['re!\w{4}'], 'cpp':['re!\w{4}']}
let g:ycm_server_python_interpreter = '/usr/bin/python3'

" global conf is only used when no compilation database and local ( until root)
" .ycm_extra_conf.py exists
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1

" remove tab from select_completion, it's used in ultisnips
let g:ycm_key_list_select_completion = ['<Down>']

let g:ycm_auto_trigger = 0
nnoremap <a-n> :let g:ycm_auto_trigger = !g:ycm_auto_trigger<cr>
inoremap <a-n> <c-r>=<sid>ycm_trigger_identifier()<cr>

" let g:ycm_key_invoke_completion = '<Plug>YcmInvoke'
" imap <c-space> <Plug>YcmInvoke<c-r>=<sid>ycm_next()<cr>

function! s:ycm_trigger_identifier()
  let g:ycm_auto_trigger = 1
  augroup ycm_trigger_identifier
    au!
    autocmd InsertLeave <buffer> ++once let g:ycm_auto_trigger = 0
  augroup end

  doautocmd ycmcompletemecursormove TextChangedI
  call s:ycm_next()
  return ''
endfunction

function! s:ycm_next()

  " ycm use timer_start to check completion result in s:PollCompletion, i have
  " to do the same to apply <c-n>
  call timer_start(5, function('s:ycm_next_callback'), {'repeat' : 100})
  let s:ycm_id_trigger_pos = [bufnr(''), getcurpos()]
  return ''
endfunction

function! s:ycm_next_callback(timer)

  " stop listening if cursor position changed
  if [bufnr(''), getcurpos()] != s:ycm_id_trigger_pos
    call timer_stop(a:timer)
    return
  endif

  if pumvisible()
    call feedkeys("\<c-n>", 'n')
    call timer_stop(a:timer)

    " close pum cause blink, that's not good
    " if len(complete_info(['items']).items) == 1
    "   ycm remap <c-y> to stop completion
    "   call feedkeys("\<c-y>", '')
    " endif
    return
  endif

endfunction

" clang_complete
let g:clang_library_path='/home/pntandcnt/plugged/YouCompleteMe/third_party/ycmd/third_party/clang/lib/libclang.so.8'
let g:clang_complete_macros=1

" coc.nvim
inoremap <silent><expr> <c-space> coc#refresh()
nmap <f12> <Plug>(coc-definition)
nmap <c-f12> <Plug>(coc-type-definition)
nmap <s-f12> <Plug>(coc-implementation)
nmap <s-f10> <Plug>(coc-references)
nmap <f2> <Plug>(coc-rename)
nnoremap <c-s> :call CocActionAsync('showSignatureHelp')<cr>
inoremap <c-s> <c-r>=CocActionAsync('showSignatureHelp')<cr>
nnoremap <expr> <c-d> coc#util#has_float() ? coc#util#float_scroll(1) : "\<c-d>"
nnoremap <expr> <c-u> coc#util#has_float() ? coc#util#float_scroll(0) : "\<c-u>"
command CocDiagnosticInfo exec "norm \<plug>(coc-diagnostic-info)"
command CocReference exec "norm \<plug>(coc-references)"
command CocHover call CocActionAsync('doHover')
command CocCodeAction call CocActionAsync('codeAction')

" fugitive
command! -nargs=* Glg Git! lg --color=never <args>
command! -nargs=* Glg Git! log --graph --pretty=format:'%h - <%an> (%ad)%d %s' --abbrev-commit --date=local <args>

" lightline
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

" pymode
let g:pymode_rope_completion = 0

" fzf
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen | cc
endfunction
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vertical rightbelow split',
      \ 'ctrl-a': 'argadd',
      \ 'ctrl-o': '!gvfs-open',
      \ 'ctrl-q': function('s:build_quickfix_list')
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
" there are garbage new line in mes, don't know how to reproduce it. Filter
" blank lines as temporary solution.
command! -nargs=+ -bang -complete=command FF call fzf#run({
            \ 'source' : filter(split(execute(<q-args>), "\n"), {i,v->!empty(v)}),
            \ 'sink': function('s:ff_sink'),
            \ 'options' : <bang>0 ? '--tac' : ''})

" copy into @@, ignore leading index
function! s:ff_sink(item)
  let text = substitute(a:item, '\v^\>?\s*\d+\:?\s*', '', '')
  let @@ = empty(text) ? a:item : text
endfunction

" change FZF_DEFAULT_COMMAND, execute cmd, restore FZF_DEFALUT_COMMAND
function! s:fzf(fzf_default_cmd, cmd)
  let oldcmds = $FZF_DEFAULT_COMMAND | try
    let $FZF_DEFAULT_COMMAND = a:fzf_default_cmd
    execute a:cmd
  finally | let $FZF_DEFAULT_COMMAND = oldcmds | endtry
endfunction

let g:external_files = get(g:, 'external_files', [])

function! s:fzf_external_files()
  if empty(g:external_files)
    return
  endif
 
  let source = 'find "' . join(g:external_files, '" "') . '" \( -name ".hg" -o -name ".git" -o
            \ -name "build" -o -name ".vscode" -o -name ".clangd" \) -prune -o -type f -print'
  call fzf#run(fzf#wrap({'source' : source}))
endfunction
nnoremap <leader>p :call <sid>fzf_external_files()<cr>

let g:fzf_file_project = 'find . \( -name ".hg" -o -name ".git" -o
            \ -name "build" -o -name ".vscode" -o -name ".clangd" \) -prune -o -type f -print'

function! s:comp_dir()
  let location = matchstr( getline('.'), printf('\v\S+%%%dc', col('.')) )
  if location == ''
    let location = '.'
  endif
  return fzf#vim#complete#word(
    \ {'source': printf('find "%s" -type d', location)} )
endfunction

imap <a-x><a-k> <plug>(fzf-complete-word)
imap <a-x><a-f> <plug>(fzf-complete-path)
imap <a-x><a-j> <plug>(fzf-complete-file-ag)
imap <a-x><a-l> <plug>(fzf-complete-line)
inoremap <expr> <a-x><a-d> <sid>comp_dir()

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

" mine
let g:clang_format_py_path = '/usr/local/source/llvm8.0.0/share/clang/clang-format.py'
let g:clang_format_fallback_style = 'LLVM'

" maps
function! s:omap(to)
  return printf(":normal v%s\"%s\<cr>", a:to, v:register)
endfunction

" text object
vnoremap aa :<C-U>silent! call misc#to#sel_cur_arg({})<cr>
vnoremap ia :<C-U>silent! call misc#to#sel_cur_arg({'exclude_space':1})<cr>
onoremap <expr> ia <sid>omap('ia')
vnoremap ie :<C-U>call misc#to#sel_expr()<cr>
onoremap <expr> ie <sid>omap('ie')
onoremap <expr> aa <sid>omap('aa')
vnoremap al :<C-U>silent! call misc#to#sel_letter()<cr>
onoremap <expr> al <sid>omap('al')
vnoremap il :<C-U>silent! call misc#to#sel_letter()<cr>
onoremap <expr> il <sid>omap('il')
vnoremap ic :<c-u>call misc#to#column()<cr>
onoremap <expr> ic <sid>omap('ic')

" circumvent count, register changes
function! s:setup_opfunc(func)
  let &opfunc = a:func
  return 'g@'
endfunction

function! s:add_op(key, func)
  exe printf('nnoremap <expr> %s <sid>setup_opfunc("%s")', a:key, a:func)
  exe printf('vnoremap %s :<c-u>call %s(visualmode(), 1)<cr>', a:key, a:func)
endfunction

" motion and operator
function! s:add_mo(keys, func)
    exec printf('nnoremap %s :call %s<cr>', a:keys, a:func)
    exec printf('vnoremap %s :<c-u>exec "norm! gv" <bar> call %s<cr>', a:keys, a:func)
    exec printf('onoremap <expr> %s printf(":normal %%s%s<cr>",
                \ mode(1) ==# "no" ? "v" : mode(1)[2])', a:keys, a:keys)
endfunction
nmap     ,a  <Plug>(EasyAlign)
vmap     ,a  <Plug>(EasyAlign)
map      ,c  <Plug>Commentary
nmap     ,cc <Plug>CommentaryLine
nmap     ,cu <Plug>Commentary<Plug>Commentary
nmap     ,cs <plug>NERDCommenterSexy
vmap     ,cs <Plug>NERDCommenterSexy
call s:add_mo(',e', 'misc#mo#vertical_motion("E")')
call s:add_mo(',w', 'misc#mo#vertical_motion("W")')
call s:add_mo(',b', 'misc#mo#vertical_motion("B")')
call s:add_mo(',E', 'misc#mo#expr()')
nnoremap ,,  ,

call s:add_op(',l', 'misc#op#search_literal')
call s:add_op(',s', 'misc#op#substitude')
call s:add_op(',S', 'misc#op#system')
call s:add_op(',<bar>', 'misc#op#column')
nmap     ,sl :let @/="\\v<".expand("<cword>").">"<cr>vif:s/<c-r><c-/>/
nmap     ,s} :let @/="\\v<".expand("<cword>").">"<cr>vi}:s/<c-r><c-/>/
nmap     ,s{ ,s}
call s:add_op(',G', 'misc#op#literal_grep')
call s:add_op(',g', 'misc#op#search_in_browser')
nnoremap co :call misc#op#omo('co')<cr>
nnoremap do :call misc#op#omo('do')<cr>
nnoremap guo :call misc#op#omo('guo')<cr>
nnoremap gUo :call misc#op#omo('gUo')<cr>
nnoremap g~o :call misc#op#omo('gso')<cr>

nnoremap yoc :exe 'set colorcolumn='. (empty(&colorcolumn) ? '+1' : '')<cr>
nnoremap -- :edit $MYVIMRC<cr>
nnoremap Y  y$
nnoremap K  :exec 'norm! K' <bar> wincmd p<cr>
nnoremap gc :SelectLastPaste<cr>

inoremap <c-x><c-p> <c-r>=misc#complete_expresson(1)<cr>
inoremap <c-x><c-n> <c-r>=misc#complete_expresson(0)<cr>

nnoremap <f3>    :set hlsearch!<cr>
" nnoremap <f4>    :ALEHover<cr>
nnoremap <f4>    :CocHover<cr>
nnoremap <c-f7>  :ALELint<cr>
" nnoremap <f12>   :YcmCompleter GoToDefinition<cr>
" nnoremap <c-f12> :YcmCompleter GoToDeclaration<cr>

nnoremap <c-l> :nohlsearch<Bar>diffupdate<CR><C-L>
nnoremap <c-j> :BTags<cr>
nnoremap <a-j> :Ctags<cr>
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

nnoremap <leader>tt :call misc#term#toggle_gterm()<cr>
tnoremap <leader>tt <c-\><c-n>:call misc#term#toggle_gterm()<cr>
nnoremap <leader>th :call misc#term#hideall()<cr>
tnoremap <leader>th <c-\><c-n>:call misc#term#hideall()<cr>
nnoremap <leader>yd :YcmShowDetailedDiagnostic<cr>

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'rhysd/vim-clang-format'         "clang c/c++ format
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'tikhomirov/vim-glsl'
Plug 'dedowsdi/cdef'
" Plug 'plasticboy/vim-markdown'
" Plug 'klen/python-mode'
" Plug 'pangloss/vim-javascript'
Plug 'lervag/vimtex'                   " latex
" Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py --clang-completer' }
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
" Plug 'xavierd/clang_complete'
" Plug 'rhysd/vim-grammarous'
call plug#end()

let g:gruvbox_number_column='bg1'
colorscheme gruvbox
packadd termdebug

function! s:less(cmd)
  exec 'vsplit ' . tempname()
  setlocal buftype=nofile nobuflisted noswapfile bufhidden=hide
  exec printf("put! =execute('%s')", a:cmd)
endfunction

" some tiny util
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
