set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}
lua require'lualine'.setup {options={theme='gruvbox-material',icons_enabled=false}}

" -- disable netrw at the very start of your init.lua (strongly advised)
" vim.g.loaded_netrw = 1
" vim.g.loaded_netrwPlugin = 1

" -- set termguicolors to enable highlight groups
" vim.opt.termguicolors = true

" -- empty setup using defaults
" require("nvim-tree").setup()

" -- OR setup with some options
" require("nvim-tree").setup({
"   sort_by = "case_sensitive",
"   view = {
"     width = 30,
"     mappings = {
"       list = {
"         { key = "u", action = "dir_up" },
"       },
"     },
"   },
"   renderer = {
"     group_empty = true,
"   },
"   filters = {
"     dotfiles = true,
"   },
" })

