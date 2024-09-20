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

alias todo='vim $LOGBOOK_DIR/todo.md'

# Open my dev logbook file for the day
function log() {
    DATE=$(date "+%Y-%m-%d")
    FILE="$LOGBOOK_DIR/${DATE}.md"

    # replaced by nvim snippet
    # if [ ! -f "$FILE" ]; then
    #     echo "# $DATE" > "$FILE"
    # fi

    vim "$FILE"
}

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
