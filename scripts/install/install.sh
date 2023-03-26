#!/usr/bin/env zsh
# link dotfiles to home directory
cd ~/dotfiles

universal=(
  .gitconfig_private
  .private
  .zshrc
  .zprofile
  .gitconfig
  .gitignore_global
  .vimrc
  .ideavimrc
  nvim_daemon.sh
  # .itermprofile
  .hyper.js
  .tmux.conf
  .config/alacritty
  .config/nvim
  .fzf.zsh
  Brewfile
)

darwin=(
  .fzf.zsh
)

linux=(
  linux/.fzf.zsh
)

link_files() {
  for file in "${$1[@]}"
  do
    if [ -f "~/$file" ]
    then
      echo "~/$file exists, skipping"
    else
      ln -s ~/dotfiles/$file ~/$file
    fi
  done
}

link_files universal

kernel_name=$(uname -s)
if [[ "${kernel_name}" == "Linux" ]]; then
  link_files linux
elif [[ "${kernel_name}" == "Darwin" ]]; then
  link_files darwin
else
  echo "Unknown operating system: ${kernel_name}"
  exit 1
fi
