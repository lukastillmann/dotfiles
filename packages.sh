#!/bin/bash

echo 'updating, upgrading...'
sudo apt-get update && sudo apt-get upgrade

echo 'installing essential tools'
sudo apt install build-essential cmake python3-dev apache2 keychain

echo 'installing vim vundle and Plugins'
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh

echo "installing node"
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt install nodejs
echo 'installing global npm packages: prettier, gulp-cli'
sudo npm install -g prettier gulp-cli

echo 'git configs'
sudo git config --global user.email "home@lukastillmann.eu"
sudo git config --global user.name "Lukas Tillmann" && sudo git config --global core.editor "vim"
