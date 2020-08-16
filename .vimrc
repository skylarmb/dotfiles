" -------------------------------------
" ------------ PLUGINS ----------------
" -------------------------------------

" vim-plug auto install

if argc() == 0
  echomsg "vimrc: Refusing to open vim without file argument"
  quit
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" ~~ Eye candy ~~

Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'morhetz/gruvbox'

" ~~ Tools ~~

" start screen
Plug 'mhinz/vim-startify'
" airline
Plug 'vim-airline/vim-airline'
" git integration
Plug 'tpope/vim-fugitive'
" wrap args to many lines
Plug 'FooSoft/vim-argwrap'
" tab management
Plug 'vim-scripts/Tabmerge'
" show indentation visually
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/syntastic'
" file browsing
Plug 'scrooloose/nerdtree'
" ~~ Search ~~

" open files
Plug 'tpope/vim-vinegar'
Plug 'ctrlpvim/ctrlp.vim'
" Ag integration
Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'
" fzf integration
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" ~~ Formatting ~~

" respect editorconfig files
Plug 'editorconfig/editorconfig-vim'
" automatic bracket and quote matching, etc
Plug 'Raimondi/delimitMate'
" context and indentation aware pasting
Plug 'sickill/vim-pasta'
" powerful commenting
Plug 'tpope/vim-commentary'
" manage and replace quotes, brackets, parens, etc
Plug 'tpope/vim-surround'
" nuke whitespace
Plug 'ntpeters/vim-better-whitespace'
" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" snippets
Plug 'SirVer/ultisnips'

" ~~ Writing / note taking ~~

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-scripts/loremipsum'

" ~~ Languages ~~

" syntax highlighting for git files (.gitconfig, etc)
Plug 'tpope/vim-git'
" git gutter
" Plug 'airblade/vim-gitgutter'
" git conflicts
Plug 'samoshkin/vim-mergetool'
" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" javascript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" web
Plug 'mattn/emmet-vim/'

" TODO: try to figure out why these plugins fight with each other
" polyglot syntax checking
" Plug 'sheerun/vim-polyglot'
" MDX
Plug 'jxnblk/vim-mdx-js'

call plug#end()

" -------------------------------------
" ------------ BASE CONFIG ------------
" -------------------------------------

" ~~ General ~~
set encoding=utf-8
set nocompatible
filetype plugin indent on

" enable syntax
syntax on

" reload files automatically
set autoread
" highlight current line
set cursorline
" relative line numbers
set number
" show cursor column
set ruler

" leader character
let mapleader = " "

" use system clipboard
set clipboard=unnamed
" disable compatibility mode (enables meta key)
set nocp
" always show the status bar
set laststatus=2
" set backspace behavior
set backspace=start,eol,indent
" go one char past end of line
set virtualedit=onemore
" always show sign column (prevents flicker)
set signcolumn=yes
" dont allow mouse clicks
set mouse-=a
" show matching brackets.
set showmatch

" set font
set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h14

" backups
set undodir=~/.vim/tmp/backup/
set undofile
set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/swap/
set backup

" files to ignore
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,*.rbc,*.class,vendor/gems/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png
set wildignore+=*.zip,*.apk,*.gz

" dark theme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=dark
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox

hi tsxTagName guifg=#83a598
hi tsxCloseTag guifg=#83a598
hi tsxCloseTagName guifg=#83a598
" end dark theme

" light theme
" set t_Co=256
" set background=light
" colorscheme solarized8_dark_low
" let g:solarized_termcolors=256
" end light theme

" airline theme
let g:airline_theme='gruvbox'

" whitespace
set shiftwidth=2
set wrap
set showbreak=↪>\
set smarttab
set expandtab
set list listchars=tab:▸\ ,trail:·
set whichwrap+=<,>,h,l,[,]

" show title
set title

" search
set hlsearch
" case insensitive
set ignorecase
" incremental search (searches as you type)
set incsearch

" indentation
let g:indentLine_char_list = ['⎸']
set tabstop=2
set autoindent
set smartindent

" -------------------------------------
" ------------- autocmds --------------
" -------------------------------------

" fix known issue in Neovim #7994
au InsertLeave * set nopaste
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.mdx set filetype=markdown.mdx

" prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1
let g:prettier#exec_cmd_path = "~/.nvm/versions/node/v12.16.2/bin/prettier"
let g:prettier#quickfix_auto_focus = 0

" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml PrettierAsync
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
autocmd BufWritePost *.mdx call HandleMDXFormat()

" mega hack because reasons
function HandleMDXFormat()
  exe ':silent !prettier --write %'
  exe ':e'
endfunction

" enabled spell checking in git commit
autocmd FileType gitcommit setlocal spell

" Goyo / Limelight
let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" -------------------------------------
" ------------- KEYBINDS --------------
" -------------------------------------

" ~~ Cursor movement ~~

" always move by display lines when wrapping
map k gk
map j gj

" move by beginning of word instead of end of word
nnoremap E b
vnoremap E b
nnoremap e w
vnoremap e w

" beginning / end of line
map H ^
map L $l

" jump 10 lines
map K 10k
map J 10j

" ~~ Shortcuts ~~

" redo with U
nnoremap U <C-r>
" exit insert mode with jj
inoremap jj <ESC>l
inoremap jJ <ESC>l
inoremap JJ <ESC>l
inoremap Jj <ESC>l
inoremap JK <ESC>l
inoremap jk <ESC>l
" jj for term mode
tnoremap jj <C-\><C-n>
" enter insert mode when pressing backspace from normal mode
nnoremap <bs> i<bs>
" qq to quit from normal mode
nnoremap qq :q<CR>
" ww to write from normal mode
nnoremap ww :w<CR>

" yank current file name
nnoremap yn :let @*=expand("%") . ':' . line(".")<CR>

" dupe line
nnoremap <C-d> yyp

" browse source of current file
nnoremap <leader>cs :silent !/bin/zsh -i -c 'browsesource "$(basename `git rev-parse --show-toplevel`)" %'<CR>

" bounce between brackets
nmap t %
vmap t %
runtime! macros/matchit.vim

" move lines up and down
nnoremap <c-n> :m +1<CR>
nnoremap <c-m> :m -2<CR>
vmap <c-n> :m '>+1<CR>gv=gv
vmap <c-m> :m '<-2<CR>gv=gv

" sudo write
cmap w!! w !sudo tee % >/dev/null
" quit all
nnoremap qa :conf qa<CR>

" ~~ Search ~~

" unhighlight search results
nnoremap <leader><space> :noh<cr>
" search word under cursor
nmap f *N
" vim-action-ag
nmap F gagiw
" fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'options': '--reverse', 'window': 'belowright 10new' }
nmap <leader>f :call fzf#vim#ag('', g:fzf_layout)<cr>
" fzf colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ag
let g:ag_working_path_mode="r"
" ag global search
nmap <c-f> :Ag! -iQ<space>
" fzf lines in open buffers
nmap <leader>l :Lines<CR>

" ~~ Whitespace ~~

" toggle wrap
nnoremap <leader>w :set wrap!<cr>
" sort lines
vnoremap <leader>s :sort<cr>
" automatic bracket formatting on newlines
inoremap {<CR> {<CR>}<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O
" indentation
vnoremap < <gv
vnoremap > >gv

" ~~ Tabs and Splits ~~

" new blank tab
nnoremap <leader>t <Esc>:tabnew<CR>
" new split
nnoremap <leader>s<space> <C-w>v<C-w>l
" new vertical split
nnoremap <leader>vs <C-w><C-v>
" new horizontal split
nnoremap <leader>hs <C-w><C-s>
" resize splits by 10 columns
nnoremap <leader>, <c-w>10><cr>
nnoremap <leader>. <c-w>10<<cr>
" navigate splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" files
nnoremap <leader>n :n<cr>
" expand %% to current dir name
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" -------------------------------------
" -------------- PLUGINS --------------
" -------------------------------------
" git blamer
let g:blamer_enabled = 1
let g:blamer_template = '<author>, <committer-time> • <summary>'
" prettier
let g:prettier#autoformat = 0
let g:prettier#exec_cmd_path = "~/.nvm/versions/node/v12.16.2/bin/prettier"
let g:prettier#quickfix_auto_focus = 0

" clean whitespace
nnoremap <leader>W :StripWhitespace<cr>
let g:strip_whitespace_on_save = 1
let g:strip_only_modified_lines=0

" git mergetool
let g:mergetool_layout = 'bmr'
let g:mergetool_prefer_revision = 'local'
nmap mt <plug>(MergetoolToggle)
nmap mgr :MergetoolDiffExchangeLeft<CR>
nmap mgl :MergetoolDiffExchangeRight<CR>
nmap <leader>gd :Gdiff<CR>

" \e to trigger Emmet
" imap <leader>e <C-y>,<CR><esc>O

" Polyglot
let g:polyglot_disabled = ['typescript', 'go', 'json']

" go
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_gopls_enabled = 0
let g:go_info_mode = 'gopls'

" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'
" let g:go_doc_keywordprg_enabled = 0
" let g:go_def_mapping_enabled = 0

" let g:go_code_completion_enabled = 0

" Argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" Coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)
nmap <silent> gf :CocCommand tslint.fixAllProblems<CR>
nmap <silent> ; :call CocAction('doHover')<cr>
nmap <silent> ge <Plug>(coc-diagnostic-next-error)

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_javascript_checkers = ['eslint']

" ctrlp
let g:ctrlp_max_files=0
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
\ }
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

" ack
if executable('ack-grep')
  let g:ackprg = 'ack-grep -H --nocolor --nogroup --column'
endif
if executable('ag')
  " https://github.com/ggreer/the_silver_searcher
  let g:ackprg = 'ag --vimgrep'
endif

" airline (status line)
let g:airline_left_sep=''
let g:airline_right_sep=''

" javascript-libraries-syntax
let g:jsx_ext_required = 0

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" NERDTree
" Always show the current file when opening NERDTree
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction
" toggle NERDTree in current dir with `
nnoremap ` :call NERDTreeToggleInCurDir()<CR>
" show hidden files
let NERDTreeShowHidden=1

" snippets
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
