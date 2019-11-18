#! /bin/bash
# setup
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo add-apt-repository ppa:neovim-ppa/stable
sudp apt update
# node, neovim, zsh
sudo apt-get install -y nodejs neovim zsh
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
apt-get install silversearcher-ag
