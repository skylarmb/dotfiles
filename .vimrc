" -------------------------------------
" ------------ PLUGINS ----------------
" -------------------------------------

" vim-plug auto install
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
" polyglot syntax checking
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

" ~~ Writing / note taking ~~

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" ~~ Languages ~~

" automagic polyglot syntax highlighting
Plug 'sheerun/vim-polyglot'
" syntax highlighting for git files (.gitconfig, etc)
Plug 'tpope/vim-git'
" git conflicts
Plug 'samoshkin/vim-mergetool'
" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" javascript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" web
Plug 'mattn/emmet-vim/'

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
set number relativenumber
" show cursor column
set ruler

" leader character
let mapleader = "\\"

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
" allow mouse clicks
set mouse=a
" show matching brackets.
set showmatch

" set font
set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h14

" backups
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup

" files to ignore
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,*.rbc,*.class,vendor/gems/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png
set wildignore+=*.zip,*.apk,*.gz

" colorscheme
set background=dark
colorscheme gruvbox
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

" fix known issue in Neovim #7994
au InsertLeave * set nopaste

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
" jj for term mode
tnoremap jj <C-\><C-n>
" enter insert mode when pressing backspace from normal mode
nnoremap <bs> i<bs>
" qq to quit from normal mode
nnoremap qq :q<CR>
" ww to write from normal mode
nnoremap ww :w<CR>

" bounce between brackets
nmap <tab> %
vmap <tab> %
runtime! macros/matchit.vim

" move lines up and down
map <M-j> :m +1 <CR>
map <M-k> :m -2 <CR>

" sudo write
cmap w!! w !sudo tee % >/dev/null
" quit all
nnoremap qa :conf qa<CR>
" save when focus lost
au FocusLost * :wa

" ~~ Search ~~

" unhighlight search results
nnoremap <leader><space> :noh<cr>
" search word under cursor
nmap f *N

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
map <leader>t <Esc>:tabnew<CR>
" new split
nnoremap <leader>s<space> <C-w>v<C-w>l
" new vertical split
nnoremap <leader>vs <C-w><C-v>
" new horizontal split
nnoremap <leader>hs <C-w><C-s>
" resize splits by 10 lines
nnoremap <leader>, <c-w>10><cr>
nnoremap <leader>. <c-w>10<<cr>
" navigate splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" -------------------------------------
" -------------- PLUGINS --------------
" -------------------------------------

" ag
let g:ag_working_path_mode="r"
" ag global search
nmap <c-f> :Ag!<space>
" fzf lines in open buffers
nmap <leader>l :Lines<CR>

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

" enabled spell checking in git commit
autocmd FileType gitcommit setlocal spell

" \e to trigger Emmet
imap <leader>e <C-y>,<CR><esc>O

" go
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mode = 'godef'

" Polyglot
let g:polyglot_disabled = ['markdown']

" Goyo / Limelight
let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" Coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gf :CocCommand tslint.fixAllProblems<CR>
imap <C-e> <Plug>(coc-snippets-expand)

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

" Always show the current file when opening NERDTree
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction
nnoremap ` :call NERDTreeToggleInCurDir()<CR>
