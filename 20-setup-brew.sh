#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Make sure we are in the right directory
cd $POP_SETUP

# Install Homebrew
if [ ! -d $HOMEBREW_PATH ]; then
  echo INSTALLING HOMEBREW
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo HOMBREW FOUND CHECKING PATH
  if [[ ! "$PATH" == *"$HOMEBREW_PATH/bin"* ]]; then
    echo HOMEBREW NOT FOUND IN PATH!!!
    export PATH=$PATH:$HOMEBREW_PATH/bin
  fi
fi

# install brew packages
if confirm "Install brew packages?"; then
  brew install $(cat ./brew.packages)
fi

# vim:foldmethod=indent
