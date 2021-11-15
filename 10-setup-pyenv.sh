#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Make sure we are in the right directory
cd $POP_SETUP

# install pip
if confirm "Do you need to install pyenv?"; then
  curl https://pyenv.run | bash
fi

source ~/.zprofile
pyenv install 3.10.0
pyenv global 3.10.0
pyenv virtualenv 3.10.0 pyx

# install pip.packages
pip3 install $(cat ./pip.packages) --user

if confirm "Continue to ./11-setup-fonts.sh"; then
  ./11-setup-fonts.sh
fi

# vim:foldmethod=indent
