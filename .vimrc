" vim-plug auto install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
set clipboard=unnamed
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
Plug 'mattn/emmet-vim/'
" Colors
Plug 'flazz/vim-colorschemes'
Plug 'curist/vim-angular-template'

" Tools
Plug 'bling/vim-airline'
" Plug 'skammer/vim-css-color'
Plug 'tpope/vim-dispatch'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-rbenv'
Plug 'vim-scripts/Rename2'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/YankRing.vim'

" Tools - Search
Plug 'tpope/vim-vinegar'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'corntrace/bufexplorer'

" Tools - Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Tools - Tab Completion
Plug 'ervandew/supertab'
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

" Languages
Plug 'chrisbra/csv.vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'derekwyatt/vim-scala'
Plug 'gre/play2vim'

" Languages - Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-cucumber'

" Languages - Yavascript
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'burnettk/vim-angular'
Plug 'digitaltoad/vim-jade'
Plug 'mxw/vim-jsx'

" Languages - Web
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'

call plug#end()

set number
set ruler
set encoding=utf-8
set laststatus=2 " always show the status bar
set backspace=start,eol,indent
set virtualedit=onemore

" leader character
let mapleader = "\\"

" whitespace
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set list listchars=tab:▸\ ,trail:·
set whichwrap+=<,>,h,l,[,]

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
nnoremap <leader><space> :noh<cr>
nnoremap f *

" wrap at word
" set linebreak
set nowrap
set background=dark

colorscheme Revolution
" colorscheme atom
" colorscheme Revolution
" colorscheme parsec
" colorscheme onedark
" colorscheme mod8
" colorscheme atom
" colorscheme lilydjwg_dark
" colorscheme itg_flat
" colorscheme iangenzo
" colorscheme hybrid_material
" colorscheme inori
" colorscheme kalisi
" colorscheme solarized
" colorscheme flatui

syntax on
set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h14
let g:indentLine_char="⎸"
let g:indentLine_setConceal = 0
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smartindent

" make cursor move by visual lines instead of file lines (when wrapping)
map k gk
map j gj
map E ge

" start/end of line
map H ^
map L $
map K <C-b>
map J <C-f>

" shortcuts
" exit insert mode with jj
inoremap jj <ESC>
" enter insert mode when pressing backspace from normal mode
nnoremap <bs> i<bs>
" qq to quit from normal mode
nnoremap qq :q<CR>
" ww to write from normal mode
nnoremap ww :w<CR>
" tab to trigger emmet
imap ,, <C-y>,<CR>
" redo with U
nnoremap U <C-r>

" save when focus lost
au FocusLost * :wa

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
map <A-h> :bp<CR>
map <A-l> :bn<CR>

" move lines up and down
map <A-j> :m +1 <CR>
map <A-k> :m -2 <CR>

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

" show the registers from things cut/yanked
nmap <leader>r :registers<CR>

" highlight current line
set cursorline

" enabled spell checking in git commit
autocmd FileType gitcommit setlocal spell

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_javascript_checkers = ['eslint']

" tagbar
map <leader>rt :TagbarToggle<cr>

" ctrlp
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
\ }
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

" ack
if executable('ack-grep')
  let g:ackprg = 'ack-grep -H --nocolor --nogroup --column'
endif
if executable('ag')
  " https://github.com/ggreer/the_silver_searcher
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap <Leader>f :Ack!<Space>

" yankring
let g:yankring_history_dir = '~/.vim/tmp'
let g:yankring_history_file = 'yankring_history'

" airline (status line)
let g:airline_left_sep=''
let g:airline_right_sep=''

" dispatch
let g:rspec_command = "Dispatch rspec {spec}"

" rspec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" global search for word under cursor
nnoremap F :Ack "\b<C-R><C-W>\b"<CR>:cw<CR>

" highlight cap files
au BufRead,BufNewFile *.cap set filetype=ruby

" close hidden buffers
" http://stackoverflow.com/a/1536094
function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction

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
    \"trimming empty <span>",
    \"<input> proprietary attribute \"autocomplete\"",
    \"proprietary attribute \"role\"",
    \"proprietary attribute \"hidden\"",
    \"proprietary attribute \"ng-",
    \"proprietary attribute \"data-",
\]

