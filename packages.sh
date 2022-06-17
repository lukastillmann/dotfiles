#!/bin/bash

echo 'updating, upgrading...'
sudo apt-get update && sudo apt-get upgrade

echo 'installing essential tools'
sudo apt install -y build-essential cmake git-all python python-dev python3 python3-dev python3-pip apache2 postgresql

echo 'installing useful tools'
sudo apt install -y unzip keychain

echo 'installing nvm'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
# load nvm immediately
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}"  ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
echo 'installing node'
nvm install node

echo 'installing global npm packages: prettier, gulp-cli'
sudo npm install -g prettier gulp-cli

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

echo 'installing coc extensions'
nvim -E -c "CocInstall coc-rome coc-sh coc-yaml coc-svg coc-html coc-css coc-prettier" -c q


# see https://github.com/neoclide/coc-snippets/issues/196#issuecomment-781231190
echo 'fixing python issues with coc and nvim'
python3 -m pip install --user --upgrade pynvim

echo 'installing ripgrep'
sudo apt-get install -y ripgrep

# install ctags - needed for some vim plugins
echo 'installing universal ctags'
cd ~/ && git clone https://github.com/universal-ctags/ctags
cd ctags && ./autogen.sh && ./configure && make && sudo make install && cd ~/

# watchman, makes coc-volar faster (TODO update url occasionally)
echo 'installing watchman'
cd -p /tmp/ && wget https://github.com/facebook/watchman/releases/download/v2022.06.13.00/watchman-v2022.06.13.00-linux.zip
unzip watchman-v2022.06.13.00-linux.zip && cd watchman-v2022.06.13.00-linux
sudo mkdir -p /usr/local/{bin,lib} /usr/local/var/run/watchman
sudo cp bin/* /usr/local/bin
sudo cp lib/* /usr/local/lib
sudo chmod 755 /usr/local/bin/watchman
sudo chmod 2777 /usr/local/var/run/watchman


echo 'git configs'
sudo git config --global user.email "home@lukastillmann.eu"
#sudo git config --global user.email "lukas.tillmann@orf.at"
sudo git config --global user.name "Lukas Tillmann" && sudo git config --global core.editor "vim"
