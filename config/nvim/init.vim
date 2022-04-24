set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

lua << EOF
--  require('debuggers');
--  require('mappings');
--  require('plugins');
  require('lualine').setup();
EOF
" require('testing');

