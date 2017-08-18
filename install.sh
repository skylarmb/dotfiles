#! /bin/bash

# run from ~/dotfiles directory, not from ~/

# link files
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zprofile ~/.zprofile
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.itermprofile ~/.itermprofile
ln -s ~/dotfiles/.gvimrc ~/.gvimrc

# set up vim folders
mkdir ~/.vim
mkdir ~/.vim/tmp
mkdir ~/.vim/tmp/swap
mkdir ~/.vim/tmp/backup
