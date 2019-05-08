" vim-plug auto install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Colors
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
Plug 'flazz/vim-colorschemes'

" Tools
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'FooSoft/vim-argwrap'

" Plug 'skammer/vim-css-color'
Plug 'Yggdroot/indentLine'
" Plug 'tpope/vim-rbenv'
" Plug 'vim-scripts/Rename2'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/YankRing.vim'

" Tools - Search
Plug 'tpope/vim-vinegar'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'corntrace/bufexplorer'
Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Tools - Tab Completion
" Plug 'ervandew/supertab'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" Tools - Formatting
Plug 'editorconfig/editorconfig-vim'
Plug 'Raimondi/delimitMate'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'

" Languages
" Plug 'chrisbra/csv.vim'
Plug 'tpope/vim-git'
" Plug 'tpope/vim-markdown'
" Plug 'gre/play2vim'

" Languages - Yavascript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" Plug 'pangloss/vim-javascript'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'mxw/vim-jsx'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Languages - Web
Plug 'mattn/emmet-vim/'
" Plug 'othree/html5.vim'
" Plug 'cakebaker/scss-syntax.vim'

call plug#end()

" basic config
set cursorline
set number
set ruler
set encoding=utf-8
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

" enable syntax
syntax on
" set font
set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h14

" leader character
let mapleader = "\\"

" backups
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup

" files to ignore
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,*.rbc,*.class,vendor/gems/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png
set wildignore+=*.zip,*.apk

" allow mouse clicks
set mouse=a

" show matching brackets.
set showmatch

" bounce between brackets
nmap <tab> %
vmap <tab> %
runtime! macros/matchit.vim

" show in title bar
set title

" search
set hlsearch
set ignorecase
set smartcase
set incsearch
" unhighlight search results
nnoremap <leader><space> :noh<cr>
let g:ag_working_path_mode="r"
" search word under cursor
nmap f *N
" use Coc to global search word under cursor
nmap F gagiw
" ag global search
nmap <c-f> :Ag!<space>
" fzf lines in open buffers
nmap <leader>l :Lines<CR>

" colorscheme
set background=dark
colorscheme gruvbox

" whitespace
set shiftwidth=2
set nowrap
set smarttab
set expandtab
set list listchars=tab:▸\ ,trail:·
set whichwrap+=<,>,h,l,[,]

" indentation
let g:indentLine_char_list = ['⎸']
set tabstop=2
set autoindent
set smartindent
vnoremap < <gv
vnoremap > >gv

" cursor movement
" always move by display lines when wrapping
map k gk
map j gj
" move by beginning of word instead of end of word
nnoremap E b
nnoremap e w
" beginning / end of line
map H ^
map L $l
" jump 10 lines
map K 10k
map J 10j

" shortcuts
" exit insert mode with jj
inoremap jj <ESC>l
" enter insert mode when pressing backspace from normal mode
nnoremap <bs> i<bs>
" qq to quit from normal mode
nnoremap qq :q<CR>
" ww to write from normal mode
nnoremap ww :w<CR>
" \e to trigger emmet
imap <leader>e <C-y>,<CR><esc>O
" redo with U
nnoremap U <C-r>
" quit all
nnoremap qa :conf qa<CR>
" save when focus lost
au FocusLost * :wa

" tabs
map <leader>t <Esc>:tabnew<CR>

" new split
nnoremap <leader>s<space> <C-w>v<C-w>l
nnoremap <leader>vs <C-w><C-v>
nnoremap <leader>hs <C-w><C-s>

" navigate splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" navigate buffers
map <M-h> :bp<CR>
map <M-l> :bn<CR>

" move lines up and down
map <M-j> :m +1 <CR>
map <M-k> :m -2 <CR>

" clean whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" sudo write
cmap w!! w !sudo tee % >/dev/null

" netrw
map <leader>n :e.<cr>
map <leader>N :Explore<cr>

" copy to clipboard
vmap <leader>y "+y
" copy current line to clipboard
nmap <leader>Y "+yy
" paste from clipboard
nmap <leader>p "+gP

" show yankring contents
nmap <leader>p :YRShow<CR>

" enabled spell checking in git commit
autocmd FileType gitcommit setlocal spell

" ~~ PLUGINS ~~

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

" tagbar
map <leader>rt :TagbarToggle<cr>

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

" yankring
let g:yankring_history_dir = '~/.vim/tmp'
let g:yankring_history_file = 'yankring_history'

" airline (status line)
let g:airline_left_sep=''
let g:airline_right_sep=''

" javascript-libraries-syntax
let g:used_javascript_libs = 'jquery,underscore,angularjs,angularui,jasmine'
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

let g:syntastic_html_tidy_ignore_errors = [
    \"trimming empty <i>",
    \"<input> proprietary attribute \"autocomplete\"",
    \"proprietary attribute \"role\"",
    \"proprietary attribute \"hidden\"",
    \"proprietary attribute \"ng-",
    \"proprietary attribute \"data-",
\]

