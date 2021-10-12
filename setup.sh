#!/usr/bin/env sh

# Use variables for everything.
SETUP_HOME=$HOME/setup
POP_SETUP=$SETUP_HOME/pop-setup


# Clone/update repo if $HOME/setup/pop-setup exists or not.
if [ -d "$POP_SETUP" ]; then
	cd $POP_SETUP
	git pull
else
	mkdir $SETUP_HOME
	git clone https://github.com/jhessin/pop-setup $POP_SETUP
fi

cd $POP_SETUP

# Setup proper programmer dvorak keymap.
localectl set-x11-keymap us pc105 dvp compose:102,numpad:shift3,kpdl:semi,keypad:atm,caps:escape
localectl set-keymap --no-convert dvp

# Copy sources to /etc/apt/sources.list.d/
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
cp ./sources/*.list /etc/apt/sources.list.d/

# Update everything
sudo apt update
sudo apt upgrade -y

# Install everything in the apt.packages file
sudo apt install $(cat apt.packages) -y

# Install all packages in the packages directory
sudo apt install ./packages/*.deb

# Install kitty terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# TODO: clone basic repositories

