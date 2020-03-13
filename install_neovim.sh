#!/bin/bash

if [ "$EUID" -ne 0 ]
   then echo "Please run as root"
   exit
fi

echo 'installing neovim'
cd ~
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
cp squashfs-root/usr/bin/nvim /usr/bin/nvim
cp -r squashfs-root/usr/share/nvim /usr/share/nvim
chmod -R 755 /usr/share/nvim
rm -rf nvim.appimage
rm -rf squashfs-root 
