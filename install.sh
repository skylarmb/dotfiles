#! /bin/bash

# run from ~/dotfiles directory, not from ~/

# touch private files
echo "# private stuff not for github">.private
echo "[user]
  name = Skylar Brown
  email =
">.gitconfig_private

# link files
ln -s ~/dotfiles/.gitconfig_private ~/.gitconfig_private
ln -s ~/dotfiles/.private ~/.private
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zprofile ~/.zprofile
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/.vimrc ~/.vimrc
# ln -s ~/dotfiles/.itermprofile ~/.itermprofile
ln -s ~/dotfiles/.hyper.js ~/.hyper.js
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

# .config
if [ -d "~/.config/nvim" ]
then
  echo "~/.config/nvim exists, skipping"
else
  ln -s ~/dotfiles/.config/nvim ~/.config/nvim
fi
if [ -d "~/.config/alacritty" ]
then
  echo "~/.config/alacritty exists, skipping"
else
  ln -s ~/dotfiles/.config/alacritty ~/.config/alacritty
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  ln -s ~/dotfiles/.fzf.zsh ~/.fzf.zsh
else
  ln -s ~/dotfiles/linux/.fzf.zsh ~/.fzf.zsh
fi
