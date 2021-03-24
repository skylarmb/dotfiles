# set up vim folders
mkdir --parents ~/.vim/tmp/backup
mkdir ~/.vim/tmp/swap

mkdir --parents ~/.config/nvim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after">>~/.config/nvim/init.vim
echo "let &packpath=&runtimepath">>~/.config/nvim/init.vim
echo "source ~/.vimrc">>~/.config/nvim/init.vim

# random packages to install
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
npm install -g diff-so-fancy

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
