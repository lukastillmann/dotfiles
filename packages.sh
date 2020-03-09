#!/bin/bash

echo 'updating, upgrading...'
sudo apt-get update && sudo apt-get upgrade

echo 'installing essential tools'
sudo apt install build-essential cmake python3-dev apache2 keychain

echo 'installing neovim'
cd ~
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
cp squashfs-root/usr/bin/nvim /usr/bin/nvim
cp -r squashfs-root/usr/share/nvim /usr/share/nvim
rm -rf nvim.appimage
rm -rf squashfs-root

echo 'installing vim-plug'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'installing vim-plug plugins'
nvim -E -c PlugInstall -c q

#echo 'installing vim vundle and Plugins'
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#vim +PluginInstall +qall
#git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
#~/.tmux/plugins/tpm/scripts/install_plugins.sh

echo "installing node 10.x"
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt install nodejs
echo 'installing global npm packages: prettier, gulp-cli'
sudo npm install -g prettier gulp-cli

echo 'git configs'
sudo git config --global user.email "home@lukastillmann.eu"
sudo git config --global user.name "Lukas Tillmann" && sudo git config --global core.editor "vim"
