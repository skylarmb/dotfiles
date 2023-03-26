#!/usr/bin/env zsh
# set up vim folders
cd ~/dotfiles
mkdir -p ~/.vim/tmp/backup
mkdir ~/.vim/tmp/swap

mkdir -p ~/.config/nvim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after">>~/.config/nvim/init.vim
echo "source ~/.vimrc">>~/.config/nvim/init.vim
ln -s ~/dotfiles/.config/nvim/UltiSnips ~/.config/nvim/UltiSnips
ln -s ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim

# random packages to install
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
pnpm install -g diff-so-fancy prettier lebab npm-why

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
go install github.com/arl/gitmux@latest
python3 -m pip install --user libtmux==0.16.1
