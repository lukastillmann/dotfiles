### START-Keychain ###
# Let  re-use ssh-agent and/or gpg-agent between logins
/usr/bin/keychain $HOME/.ssh/lukas
source $HOME/.keychain/$HOSTNAME-sh
### End-Keychain ###

# node 18 is default currently
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM
nvm use 18

export PATH=$PATH:~/ringojs/bin/
export RINGO_HOME=~/ringojs/
# deno
export DENO_INSTALL="/home/lukas/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

if [ -f $HOME/.bashrc ]; then
	source $HOME/.bashrc
fi
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
