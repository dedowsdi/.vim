" vim:set foldmethod=marker :

" Always remember that your goal is to build your own Editor.
"
" This vimrc should also work for 8.0(default version on ubuntu18.04).
"
" about map and command position in this file :
"     put it in map fold if:
"        1. it doesn't rely on plugin at all
"        2. it relies on plugin, but it's a common operation. e.g. <c-f7> is
"        bound to lint current file, both coc and ale implement this function.
"
"     Otherwise put it the plugin fold that it relies on.


                                   " options {{{1

" show tab and trailing space
scriptencoding utf-8
set list listchars=trail:┄,tab:†·,extends:>,precedes:<,nbsp:+
scriptencoding

" add all child dir to path
set path+=/usr/local/include,**

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

" bash style wild menu
set wildmenu
set wildmode=longest,list

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

" add project .vim, .vim/after to rtp, add ~/.vim to rtp from nvim
set rtp+=.vim,.vim/after
if has('nvim')
  set rtp+=~/.vim
endif

" search tag in dir of current file upward until root, use current dir tags if
" nothing found
" set tags=./tags;,tags

set wildignore=*.o,*.a,*.so,tags,TAGS,*/.git/*,*/build/*,*/.clangd/*

" add -I to ignore binary file, exclude some dirs
let &grepprg = 'grep -n $* /dev/null --exclude-dir={.git,.hg,.clangd} -I'
" set grepprg=ag\ --vimgrep\ $* grepformat=%f:%l:%c:%m

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

                                " plugin {{{1

" ale {{{2
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

" ultisnips {{{2
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'

" coc.nvim {{{2
inoremap <silent><expr> <c-space> coc#refresh()
nmap <c-f12> <Plug>(coc-type-definition)
nmap <s-f12> <Plug>(coc-implementation)
nnoremap <c-s> :call CocActionAsync('showSignatureHelp')<cr>
inoremap <c-s> <c-r>=CocActionAsync('showSignatureHelp')<cr>

command CocDiagnosticInfo exec "norm \<plug>(coc-diagnostic-info)"
command CocReference exec "norm \<plug>(coc-references)"
command CocHover call CocActionAsync('doHover')
command CocCodeAction call CocActionAsync('codeAction')

" fugitive {{{2
command! -nargs=* Glg Git! lg --color=never <args>
command! -nargs=* Glg Git! log --graph --pretty=format:'%h - <%an> (%ad)%d %s' --abbrev-commit --date=local <args>

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

" fzf {{{2
set rtp+=~/.fzf
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

" change FZF_DEFAULT_COMMAND, execute cmd, restore FZF_DEFALUT_COMMAND
function! s:fzf(fzf_default_cmd, cmd)
  let oldcmds = $FZF_DEFAULT_COMMAND | try
    let $FZF_DEFAULT_COMMAND = a:fzf_default_cmd
    execute a:cmd
  finally | let $FZF_DEFAULT_COMMAND = oldcmds | endtry
endfunction

function! s:comp_dir()
  let location = matchstr( getline('.'), printf('\v\S+%%%dc', col('.')) )
  if location ==# ''
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

" vimtex {{{2
let g:tex_flavor = 'latex'
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk -layout <q-args> -
:command! -complete=file -nargs=1 Rpdffmt :r !pdftotext
            \ -nopgbrk -layout <q-args> - |fmt -csw78

" vim-json {{{2
let g:vim_json_syntax_conceal = 0

" gutentags {{{2
let g:gutentags_project_root = ['.vim']
let g:gutentags_exclude_project_root = [$HOME]
let g:gutentags_exclude_filetypes = ['cmake', 'sh', 'json', 'md', 'text']
let g:gutentags_define_advanced_commands = 1
let g:gutentags_ctags_options_file = '.vim/.gutctags'

" .vim {{{2
let g:clang_format_py_path = '/usr/local/source/llvm8.0.0/share/clang/clang-format.py'
let g:clang_format_fallback_style = 'LLVM'
let g:hist_use_vim_regex_search = 1

if v:version > 800
  cmap <tab> <Plug>dedowsdi_hist_expand_hist_wild
  set wildchar=<c-z>
endif
cmap <c-a> <Plug>dedowsdi_readline_beginning_of_line
cmap <a-a> <c-a>
cmap <a-f> <Plug>dedowsdi_readline_forward_word
cmap <a-b> <Plug>dedowsdi_readline_backward_word
" cmap <c-f> <Plug>dedowsdi_readline_forward_char
" cmap <c-b> <Plug>dedowsdi_readline_backward_char
cmap <a-u> <Plug>dedowsdi_readline_uppercase_word
cmap <a-l> <Plug>dedowsdi_readline_lowercase_word
cmap <a-d> <Plug>dedowsdi_readline_forward_delete
cmap <a-k> <Plug>dedowsdi_readline_kill

nmap <leader>tt <plug>dedowsdi_term_toggle_gterm
tmap <leader>tt <plug>dedowsdi_term_toggle_gterm

" install plugins {{{2
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd! vim_plug_init VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" common
Plug 'mbbill/undotree'
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

" fuzzy
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" lint
Plug 'w0rp/ale'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" tags
if executable('ctags')
  Plug 'ludovicchabant/vim-gutentags'
endif
Plug 'majutsushi/tagbar'

" auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ftplugin
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'tikhomirov/vim-glsl'
Plug 'lervag/vimtex'
if executable('ctags')
  Plug 'dedowsdi/cdef'
endif

call plug#end()

                                  " misc {{{1

runtime! ftplugin/man.vim
set keywordprg=:Man

call misc#terminal#setup()

" plug#end() already call these commented commands
" filetype plugin indent on
" syntax enable

let g:gruvbox_number_column='bg1'
colorscheme gruvbox

" must be applied after colorscheme, avoid highlight overwrite.
if v:version > 800
  packadd cfilter
  packadd termdebug
endif

augroup zxd_misc
  au!

  if v:version > 800

    " too dangerious?
    " autocmd DirChanged * if filereadable('.vim/init.vim') | source .vim/init.vim | endif
    if !has('nvim')
      autocmd TerminalOpen * setl nonumber norelativenumber
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
function! s:omap(to)
  return printf(":normal v%s\"%s\<cr>", a:to, v:register)
endfunction

vnoremap aa :<C-U>silent! call misc#to#sel_cur_arg({})<cr>
onoremap <expr> aa <sid>omap('aa')
vnoremap ia :<C-U>silent! call misc#to#sel_cur_arg({'exclude_space':1})<cr>
onoremap <expr> ia <sid>omap('ia')
vnoremap ie :<C-U>call misc#to#sel_expr()<cr>
onoremap <expr> ie <sid>omap('ie')
vnoremap al :<C-U>silent! call misc#to#sel_letter()<cr>
onoremap <expr> al <sid>omap('al')
vnoremap il :<C-U>silent! call misc#to#sel_letter()<cr>
onoremap <expr> il <sid>omap('il')
vnoremap ic :<c-u>call misc#to#column()<cr>
onoremap <expr> ic <sid>omap('ic')

" motion and operator {{{2

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

call s:add_op(',h', 'misc#ahl#op')
com -nargs=0 AhlRemoveWindowHighlights call misc#ahl#remove_wnd_highlights()
com -nargs=0 AhlRemoveCursorHighlights call misc#ahl#remove_cursor_highlights()
nnoremap ,hh :AhlRemoveCursorHighlights<cr>

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

" common maps {{{2
nnoremap yoc :exe 'set colorcolumn='. (empty(&colorcolumn) ? '+1' : '')<cr>
nnoremap Y  y$
nnoremap K  :exec 'norm! K' <bar> wincmd p<cr>
nnoremap gc :SelectLastPaste<cr>

nnoremap <c-w><space> :tab split<cr>
tnoremap <c-w><space> <c-w>:tab split<cr>

inoremap <c-x><c-p> <c-r>=misc#complete_expresson(1)<cr>
inoremap <c-x><c-n> <c-r>=misc#complete_expresson(0)<cr>

nmap <f2> <Plug>(coc-rename)
nnoremap <f3>    :set hlsearch!<cr>
nnoremap <f4>    :CocHover<cr>
nnoremap <c-f7>  :ALELint<cr>
nmap <s-f10> <Plug>(coc-references)
nmap <f12> <Plug>(coc-definition)

if !has('nvim')
  nnoremap <expr> <c-y> misc#popup#scroll_cursor_popup(1) ? '<esc>' : '<c-y>'
  nnoremap <expr> <c-e> misc#popup#scroll_cursor_popup(0) ? '<esc>' : '<c-e>'
  nnoremap <expr> <c-f> misc#popup#rotate_cursor_popup(0) ? '<esc>' : '<c-f>'
endif

nnoremap <c-l> :nohlsearch<Bar>diffupdate<CR><C-L>
nnoremap <c-j> :BTags<cr>
nnoremap <a-j> :Ctags<cr>
nnoremap <c-h> :History<cr>
nnoremap <c-b> :Buffers<cr>
let g:fzf_file_project = 'find . \( -name ".hg" -o -name ".git" -o
            \ -name "build" -o -name ".vscode" -o -name ".clangd" \) -prune -o -type f -print'
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

" cnoremap <expr> %%  getcmdtype() == ":" ? expand("%:h")."/" : "%%"
" cnoremap <expr> %t  getcmdtype() == ":" ? expand("%:t") : "%t"

                                  " command {{{1

com Scratch new | setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
command! HiTest source $VIMRUNTIME/syntax/hitest.vim
command! TrimTrailingWhitespace :keepp %s/\v\s+$//g
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
  \ | diffthis | wincmd p | diffthis
command! SelectLastPaste exec 'normal! `[' . getregtype() . '`]'
command! ReverseQuickFixList call setqflist(reverse(getqflist()))
command! SuperWrite :w !sudo tee % > /dev/null
command! Terminal exe 'terminal' |
            \ call term_sendkeys("", printf("cd %s \<cr>",
            \ fnamemodify(bufname(winbufnr(winnr('#'))), ':h') ) )
command! -bang CfilterCoreHelp Cfilter<bang> '\v/vim/vim\d+/doc/[^/]+\.txt'
command -nargs=1 DoRevert <args> e!
command -nargs=1 DoSave <args> up
command! Synstack echo map( synstack(line('.'), col('.')), 'synIDattr(v:val, "name")' )
command! SynID echo synIDtrans(synID(line('.'), col('.'), 1))
command! -nargs=+ SynIDattr echo synIDattr(
            \ synIDtrans(synID(line('.'), col('.'), 1)), <f-args>)
com EditVimrc e `echo $MYVIMRC`

" Expand {{{2
function s:expand_filepath(...)
  if a:0 == 0
    let reg = '+'
    let expr = '%:p'
  elseif a:0 == 1
    if a:1 =~# '\v^[a-zA-Z"*+]$'
      let reg = a:1
      let expr = '%:p'
    else
      let reg = '+'
      let expr = a:1
    endif
  else
    let reg = a:1
    let expr = a:2
  endif

  call setreg(reg, expand(expr))
  call setreg('"', expand(expr))
endfunction

" Expand [x=+] [mods=%:p], " is always set
command -nargs=* Expand call s:expand_filepath(<f-args>)

" Browse {{{2
function s:browse(...)
  let path = expand(get(a:000, 0, '%:p'))
  call system(printf('google-chrome %s&', path))
endfunction
command -nargs=? Browse call s:browse(<f-args>)

" Less {{{2
function! s:less(cmd)
  new
  setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
  f [one-off]
  exec printf("put! =execute('%s')", a:cmd)
endfunction

command! -nargs=+ -complete=command Less call <sid>less(<q-args>)

" Tapi_cd {{{2
" arglist : [ cwd ]
" change window local working directory
function! Tapi_lcd(bufnum, arglist)
  let winid = bufwinid(a:bufnum)
  let cwd = get(a:arglist, 0, '')
  if winid == -1 || empty(cwd)
    return
  endif
  call win_execute(winid, 'lcd ' . cwd)
endfunction

" folds {{{2
function s:folds() abort
  let lines = map(getline(1, '$'), {i,v -> (i+1) . ' : ' . v})
  call filter(lines, {i,v -> v =~# '\v.*\{\{\{\d*$'})
  call fzf#run({'source' : lines, 'sink' : function('s:fold_sink')})
endfunction

function s:fold_sink(item) abort
  let lnum = matchstr(a:item, '\v^\s*\d+')
  exe lnum
  norm! zOzz
endfunction

com Folds call s:folds()

" Ctags {{{2
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

" FF {{{2
" copy into @@, ignore leading index
function! s:ff_sink(item)
  let text = substitute(a:item, '\v^\>?\s*\d+\:?\s*', '', '')
  let @@ = empty(text) ? a:item : text
endfunction

" there are garbage new line in mes, don't know how to reproduce it. Filter
" blank lines as temporary solution.
command! -nargs=+ -bang -complete=command FF call fzf#run(fzf#wrap({
            \ 'source' : filter(split(execute(<q-args>), "\n"), {i,v->!empty(v)}),
            \ 'sink': function('s:ff_sink'),
            \ 'options' : <bang>0 ? '--tac' : '',
            \ 'up':'~40%'
            \ }))

" ExternalFiles {{{2
let g:external_files = get(g:, 'external_files', [])

function! s:fzf_external_files()
  if empty(g:external_files)
    return
  endif

  let source = 'find "' . join(g:external_files, '" "') . '" \( -name ".hg" -o -name ".git" -o
            \ -name "build" -o -name ".vscode" -o -name ".clangd" \) -prune -o -type f -print'
  call fzf#run(fzf#wrap({'source' : source}))
endfunction
com P call <sid>fzf_external_files()

" CloseFinishedTerminal{{{2
function s:close_finished_terminal() abort
  let bufs = map(split( execute('ls F'), "\n" ), {i,v -> matchstr(v, '\v^\s*\zs\d+')})
  for buf in bufs
    call win_execute(bufwinid(str2nr( buf )), 'close')
  endfor
endfunction
com -nargs=0 CloseFinishedTerminal call s:close_finished_terminal()

" Job{{{2
function s:job(cmd) abort
  call job_start( a:cmd, { "exit_cb":function('s:job_exit_cb'),
              \ "err_cb": function('s:job_err_cb') } )
endfunction

function s:job_exit_cb(job, exit_status)
  if a:exit_status != 0
    echohl WarningMsg
    echomsg printf('%s exit with %d', a:job, a:exit_status)
    echohl None
  endif
endfunction

function s:job_err_cb(ch, msg)
  echohl WarningMsg
  echomsg printf('%s : %s', a:ch, a:msg)
  echohl None
endfunction
com -nargs=+ -complete=shellcmd Job call s:job(<q-args>)
