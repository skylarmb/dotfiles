#!/usr/bin/env zsh
# create private files that are not committed to github
cd ~/dotfiles
mkdir .private
touch .private/.gitconfig
touch .private/.zshrc
echo "# private shell config, not for github
export GITHUB_TOKEN=fake
export WORKSPACE= # TODO
export TMUX_DEFAULT_PATH= # TODO
export GITHUB_EMAIL= # TODO
alias workspace='echo TODO'
" >>.private/.zshrc
echo "# private git config, not for github
[user]
  name = Skylar Brown
  email =
" >>.private/.gitconfig
