#! /bin/bash

# run from ~/dotfiles directory, not from ~/

# link files
ln -s ~/dotfiles/.gitconfig_private ~/.gitconfig_private
ln -s ~/dotfiles/.private ~/.private
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zprofile ~/.zprofile
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.itermprofile ~/.itermprofile
ln -s ~/dotfiles/.fzf.zsh ~/.fzf.zsh

# set up vim folders
mkdir --parents ~/.vim/tmp/backup
mkdir ~/.vim/tmp/swap
# run after PlugInstall
mkdir --parents ~/.vim/colors
ln -s ~/.vim/plugged/gruvbox/colors/gruvbox.vim ~/.vim/colors/gruvbox.vim

mkdir --parents ~/.config/nvim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after">>~/.config/nvim/init.vim
echo "let &packpath=&runtimepath">>~/.config/nvim/init.vim
echo "source ~/.vimrc">>~/.config/nvim/init.vim

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
