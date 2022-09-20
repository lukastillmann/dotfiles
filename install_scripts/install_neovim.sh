#!/bin/bash

if [ "$EUID" -ne 0 ]
   then echo "Please run as root"
   exit
fi

# build prerequisites for neovom
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

cd ~
rm -rf neovim
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
# for the latest stable release uncomment the next line
#git checkout stable
sudo make install
cd ~


#echo 'installing neovim'
#cd ~
#curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
#chmod u+x nvim.appimage
#./nvim.appimage --appimage-extract
#cp squashfs-root/usr/bin/nvim /usr/bin/nvim
#cp -r squashfs-root/usr/share/nvim /usr/share/nvim
#chmod -R 755 /usr/share/nvim
#rm -rf nvim.appimage
#rm -rf squashfs-root 
