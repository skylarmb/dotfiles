" -------------------------------------
" -------------- PLUGINS --------------
" -------------------------------------
" vim-plug auto install
set shell=/bin/zsh

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC | TSInstallSync
endif

call plug#begin('~/.vim/plugged')

" ------------ Colorschemes ------------
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'less', 'sass', 'stylus'] }
Plug 'sainnhe/gruvbox-material'

" ------------ Utilties ------------
" airline
Plug 'hoob3rt/lualine.nvim'
" git integration
Plug 'tpope/vim-fugitive'
" show git diff in gutter
Plug 'airblade/vim-gitgutter'
" control tab naming
Plug 'gcmt/taboo.vim'
" show indentation visually
Plug 'Yggdroot/indentLine'
" file browsing
Plug 'scrooloose/nerdtree'
" make native netrw better
Plug 'tpope/vim-vinegar'
" snippets
Plug 'SirVer/ultisnips'
" yank history
" Plug 'vim-scripts/YankRing.vim'
" seamless vim/tmux navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'github/copilot.vim', { 'branch': 'release' }

" ------------ Search ------------
" Ag integration
Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'

" fzf integration
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'antoinemadec/coc-fzf'

" ------------ Formatting ------------
" context and indentation aware pasting
Plug 'sickill/vim-pasta'
" powerful commenting
Plug 'tpope/vim-commentary'
" manage and replace quotes, brackets, parens, etc
Plug 'tpope/vim-surround'
" nuke whitespace
Plug 'ntpeters/vim-better-whitespace'
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" sorting as a motion
Plug 'christoomey/vim-sort-motion'

" ------------ Writing / note taking ------------
Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'text'] }
Plug 'junegunn/limelight.vim', { 'for': ['markdown', 'text'] }
" Plug 'vim-scripts/loremipsum'

" ------------ Languages ------------
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" git conflicts
Plug 'samoshkin/vim-mergetool'
" " go
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'windwp/nvim-autopairs'

" ------------ Temporary / Experimental ------------
" Plug 'dstein64/vim-startuptime'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'dpayne/CodeGPT.nvim'
Plug 'yegappan/mru', { 'on': 'MRU', 'do': ':MRU' }


call plug#end()

" -------------------------------------
" ------------ BASE CONFIG ------------
" -------------------------------------

" ------------ General ------------
set mouse=

" text encoding and file format
set encoding=utf-8
set nocompatible
set colorcolumn=80
let g:vim_json_conceal=0
filetype plugin indent on
" quickly reload vimrc
nnoremap <silent> <leader>s :source ~/.vimrc<CR>
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
set clipboard+=unnamed
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
" optimize ssh performance
set ttyfast
hi NonText cterm=NONE ctermfg=NONE
" set lazyredraw
" show matching brackets.
set showmatch
" set font
set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h14
" backups / undo history
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
set termguicolors
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_better_performance = 1
" let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox-material

"end dark theme

" light theme
" set t_Co=256
" set background=light
" colorscheme solarized8_light_high
" let g:solarized_termcolors=256
" end light theme

" airline theme
let g:airline_theme='gruvbox'

" whitespace
set shiftwidth=2
set wrap
" set showbreak=╰─
" exp
let &showbreak = '↳ '
" set cpo=n
set list listchars=tab:▸\ ,trail:·,extends:»,precedes:«,nbsp:␣
" set list listchars=tab:▸\ ,trail:·
" endexp
set smarttab
set expandtab
set whichwrap+=<,>,h,l,[,]
" show title
set title
" search
set hlsearch
" case insensitive
set ignorecase
" incremental search (searches as you type)
set incsearch
" netrw config
let g:netrw_preview = 1
let g:netrw_liststyle=3
let g:netrw_chgwin=1
" indentation
let g:indentLine_char_list = ['⎸']
" let g:indentLine_concealcursor = "nc"
set tabstop=2
set autoindent
set smartindent
let g:taboo_tab_format = ' %f '

" yankring bindings
let g:yankring_replace_n_pkey = '<C-M>'

" base language versions
" let g:node_bin = $NVM_BIN . "/node"
" " let g:prettier_bin = $PNPM_HOME . "/prettier"

" plugin language providers
let g:python_host_prog='~/.pyenv/shims/python2'
let g:python3_host_prog='~/.pyenv/shims/python3'
let g:node_host_prog = $NVM_BIN . '/neovim-node-host'
let g:coc_node_path = $NVM_BIN . '/node'
" let g:coc_config_home = '~/.config/coc'

let g:coc_global_extensions = [
  \'coc-browser',
  \'coc-css',
  \'coc-css',
  \'coc-cssmodules',
  \'coc-dash-complete',
  \'coc-diagnostic',
  \'coc-docker',
  \'coc-eslint',
  \'coc-fzf-preview',
  \'coc-git',
  \'coc-go',
  \'coc-highlight',
  \'coc-html',
  \'coc-json',
  \'coc-lua',
  \'coc-prettier',
  \'coc-python',
  \'coc-python',
  \'coc-react-refactor',
  \'coc-scssmodules',
  \'coc-tsserver',
  \'coc-vimlsp',
  \'coc-yaml',
  \'coc-sh',
  \]
" \'coc-tsdetect',
"

" -------------------------------------
" ------------- autocmds --------------
" -------------------------------------

" hide command line when entering insert mode
autocmd InsertEnter * set cmdheight=0
" enabled spell checking in git commit
autocmd FileType gitcommit,txt setlocal spell

" Goyo / Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1

autocmd! User GoyoEnter call OnGoyoEnter()
autocmd! User GoyoLeave call OnGoyoLeave()

" text editing settings: limelight, text width, word wrap, and spell check
function OnGoyoEnter()
  Limelight
  " setlocal tw=80
  " setlocal fo+=a
  setlocal spell
  setlocal scrolloff
endfunction

" disable text editing settings
function OnGoyoLeave()
  Limelight!
  " setlocal tw&
  " setlocal fo-=a
  setlocal nospell
  setlocal scroll
endfunction

" fix known issue in Neovim #7994
au InsertLeave * set nopaste
" consistent treesitter highlighting for all js-like languages
autocmd BufNewFile,BufRead *.mdx set filetype=markdown.mdx
autocmd BufNewFile,BufRead .env,.env.* set filetype=sh

autocmd InsertEnter * set conceallevel=0
autocmd InsertLeave * set conceallevel=1

autocmd BufWritePost *.mdx call HandleMDXFormat()

" " mega hack because reasons
" function HandleMDXFormat()
"   exe ':silent !' . g:prettier_bin  . ' --parser mdx --write %'
"   exe ':e'
" endfunction

" organize Go imports
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" -------------------------------------
" ------------- KEYBINDS --------------
" -------------------------------------

noremap <leader>q q
noremap q <nop>


" ------------ Cursor movement ------------

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

" ------------ Shortcuts ------------

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
nnoremap qq m':q<CR>
nnoremap qa m':close<cr> :call Wipeout()<CR> :qa<CR>
" ww to write from normal mode
nnoremap ww :w<CR>

" yank current file name and line number
nnoremap yl :let @*=expand("%") . ':' . line(".")<CR>
" yank current file name
nnoremap yn :let @*=expand("%")<CR>
" show current yank rink
nnoremap <C-y> :YRShow<CR>

" dupe line
nnoremap <C-d> yyp
" join line
nnoremap <leader>j :join<CR>
vnoremap <leader>j :join<CR>
" browse source of current file
nnoremap <leader>cs :silent !/bin/zsh -i -c 'browsesource "$(basename `git rev-parse --show-toplevel`)" %'<CR>

" bounce between brackets
nmap t %
vmap t %
runtime! macros/matchit.vim

" move lines up and down
" nnoremap <c-n> :m +1<CR>
" nnoremap <c-m> :m -2<CR>
" vmap <c-n> :m '>+1<CR>gv=gv
" vmap <c-m> :m '<-2<CR>gv=gv

" sudo write
cmap w!! w !sudo tee % >/dev/null
" quit all
nnoremap qa :conf qa<CR>

" ------------ Search ------------

" unhighlight search results
nnoremap <leader><space> :noh<cr>
nnoremap <leader>e :Explore<cr>
" search word under cursor
nmap f *N
" vim-action-ag
nmap F gagiw
" fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_buffers_jump = 1
" nmap <leader>f :call fzf#vim#ag('', g:fzf_layout)<CR>
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

" ------------ Whitespace ------------

" toggle wrap
nnoremap <leader>w :noa w<CR>

" automatic bracket formatting on newlines
" inoremap {<CR> {<CR>}<ESC>O
" inoremap (<CR> (<CR>)<ESC>O
" inoremap [<CR> [<CR>]<ESC>O
" indentation
vnoremap < <gv
vnoremap > >gv

" ------------ Tabs and Splits ------------

" new blank tab
" nnoremap <leader>t <Esc>:tabnew<CR>
" new vertical split
nnoremap <leader>vs <C-w><C-v>
" new horizontal split
nnoremap <leader>hs <C-w><C-s>
" resize splits by 10 columns
nnoremap <leader>, <c-w>10><CR>
nnoremap <leader>. <c-w>10<<CR>
" navigate splits: replaced by vim-tmux-navigator
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

" files
nnoremap <leader>n :n<CR>
nnoremap - :Explore<CR>
" expand %% to current dir name
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" change vim working dir to current buffer dir
nnoremap <leader>cdf :cd %:h<CR>
" change vim working dir to current buffer parent dir
nnoremap <leader>cdu :cd %:p<CR>
" change vim working dir to current git root
nnoremap <leader>cdg :Gcd <CR>
" nnoremap <leader>cdg :cd %:h | cd `git rev-parse --show-toplevel` <CR>

" -------------------------------------
" -------------- PLUGINS --------------
" -------------------------------------

" git blamer
let g:blamer_enabled = 1
let g:blamer_template = '<author>, <committer-time> • <summary>'

" clean whitespace
nnoremap <leader>W :StripWhitespace<CR>
let g:strip_whitespace_on_save = 1
let g:strip_only_modified_lines=0
let g:strip_whitespace_confirm=0

" git mergetool
let g:mergetool_layout = 'bmr'
let g:mergetool_prefer_revision = 'local'
nmap mt <plug>(MergetoolToggle)
nmap mgr :MergetoolDiffExchangeLeft<CR>
nmap mgl :MergetoolDiffExchangeRight<CR>
" nmap <leader>gd :Gdiff<CR>

" go
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_fmt_command = 'goimports'

" Argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" Coc
" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)
" nnoremap <leader>f <Plug>(coc-fix-current)<CR>
nnoremap <leader>f <Plug>(coc-fix-current)
" autocmd User CocNvimInit call CocAction('runCommand', 'tsserver.watchBuild')

nnoremap <leader>a <Plug>(coc-codeaction-line)
nnoremap <silent><nowait><expr> <C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
nnoremap <silent><nowait><expr> <C-m> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-m>"

nmap <silent> gh :call ShowDocumentation()<CR>
nmap <silent> ge <Plug>(coc-diagnostic-next-error)
nmap <silent> ] <Plug>(coc-diagnostic-next)
nmap <silent> [ <Plug>(coc-diagnostic-prev)
nmap <silent> gf :silent CocCommand eslint.executeAutofix<CR> :silent CocCommand prettier.formatFile<CR> :silent call CocActionAsync('doQuickfix')<CR>
nmap <silent> ; :call CocActionAsync('doHover')
" nnoremap <silent> K :call ShowDocumentation()<CR>

" Highlight the symbol and its references when holding the cursor
function! ShowDocumentation()
  if coc#float#has_float()
    return
  endif
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  endif
endfunction

set updatetime=1000
autocmd CursorHold * silent call ShowDocumentation()

" Find symbol of current document
nnoremap <silent><nowait> <space>d :CocFzfList diagnostics<cr>

" Search workspace symbols
nnoremap <silent><nowait> <space>o :CocFzfList outline<cr>

" let g:coc_snippet_next = '<c-J>'
" let g:coc_snippet_prev = '<c-K>'

" ctrlp
nmap <C-p> :Files<CR>

" ack
if executable('ack-grep')
  let g:ackprg = 'ack-grep -H --nocolor --nogroup --column'
endif
if executable('ag')
  " https://github.com/ggreer/the_silver_searcher
  let g:ackprg = 'ag --vimgrep'
endif

nmap <silent> gb :Git blame<CR>

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
  exe ":silent NERDTreeRefreshRoot"
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":silent NERDTreeClose"
  else
    exe ":silent NERDTreeFind"
  endif
endfunction
" toggle NERDTree in current dir with `
nnoremap <silent> ` :call NERDTreeToggleInCurDir()<CR>
" show hidden files
let NERDTreeShowHidden=1
let g:NERDTreeQuitOnOpen = 1
" if no filename given on command line, show file tree
" au VimEnter * if argc() == 0 | exe ":NERDTreeCWD" | endif

" nnoremap <silent> ` :NvimTreeFindFile<CR>

" MRU
" fzf MRU files
nnoremap <leader>l :FZFMru<CR>
" dont replace the current buffer
let MRU_Open_File_Use_Tabs = 1

" snippets
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetsDir=system('readlink ~/.config/nvim/UltiSnips')
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" mocha

" map <Leader>s :call RunNearestSpec()<CR>

" DAP
" nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
" nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
" nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
" nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
" nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
" nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
" nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
" nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
" nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>


function! MdnSearch(...)
  silent exec "!open 'https://mdn.io/".shellescape(join(a:000))."'"
endfunction
command! -nargs=+ Mdn call MdnSearch(<f-args>)

" copilot
" imap <script><expr> <C-Y> copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true
" disable quote concealment in json syntax

if has("multi_byte")
  if &encoding !~? '^u'
    if &termencoding == ""
      let &termencoding = &encoding
    endif
    set encoding=utf-8
  endif
  setglobal fileencoding=utf-8
  " Uncomment to have 'bomb' on by default for new files.
  " Note, this will not apply to the first, empty buffer created at Vim startup.
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

" ------------ TMP ------------
nnoremap ;; :%s:::g<Left><Left><Left>
nnoremap ;' :%s:::cg<Left><Left><Left><Left>
nnoremap <leader>cp :Copilot panel<CR>
nnoremap <leader>ch :Copilot hide<CR>
nnoremap <leader>e :tabnew ~/.vimrc<CR>
nnoremap <leader>r :so ~/.vimrc<CR> :noh<CR>
set conceallevel=0

let g:gitgutter_sign_added = '▌'
let g:gitgutter_sign_modified = '▌'
let g:gitgutter_sign_removed = '▌'
let g:gitgutter_sign_removed_first_line = '▌'
let g:gitgutter_sign_removed_above_and_below = '▌'
let g:gitgutter_sign_modified_removed = '▌'
let g:gitgutter_sign_allow_clobber = 0

" pager
" if !exists('g:vimpager')
"   let g:vimpager = {}
" endif
" if !exists('g:less')
"   let g:less     = {}
" endif
" let g:less.enabled = 0

" ------------ LUA ------------
lua << EOF

require('lualine').setup {
  options = {
    theme='gruvbox-material',
    icons_enabled = false
  }
}

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

-- vim.treesitter.language.register('tsx', 'typescriptreact')
-- vim.treesitter.language.register('tsx', 'javascript')
-- vim.treesitter.language.register('tsx', 'typescript')

EOF

" LSP highlights
hi link VirtualTextError Error
hi link VirtualTextWarning Question

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

function ConfirmLeave()
  set noconfirm
  set nomodifiable
  set modified
  echoerr "Press :q! or :qa! to quit" | throw 1
endfunction

function KeepAlive()
  exec ':n /tmp/.KEEPALIVE'
  exec ':w'
  autocmd ExitPre *.KEEPALIVE call ConfirmLeave()
endfunction

command! DisconnectClients
    \  if exists('b:nvr')
    \|   for client in b:nvr
    \|     silent! call rpcnotify(client, 'Exit', 1)
    \|   endfor
    \| endif
