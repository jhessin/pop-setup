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

if confirm "Do you need to set up virtualenv?"; then
  pyenv install 3.10.0
  pyenv virtualenv 3.10.0 pyx
  pyenv global pyx
fi


# install pip.packages
python3 -m pip install --upgrade pip
pip install $(cat ./pip.packages)

if confirm "Continue?"; then
  ./10-*.sh
fi

# vim:foldmethod=indent
