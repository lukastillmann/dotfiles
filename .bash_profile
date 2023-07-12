### START-Keychain ###
# Let  re-use ssh-agent and/or gpg-agent between logins
/usr/bin/keychain $HOME/.ssh/lukas
source $HOME/.keychain/$HOSTNAME-sh
### End-Keychain ###

# node 18 is default currently
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM
nvm use 18

if [ -f $HOME/.bashrc ]; then
	source $HOME/.bashrc
fi

# move secrets, local environment variables and exports into
# .bash_local file
if [ -f $HOME/.bash_local ]; then
	source $HOME/.bash_local
fi

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
