#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Make sure we are in the right directory
cd $POP_SETUP

# install flatpak packages
flatpak install flathub $(cat ./flatpak.packages)

if confirm "Continue?"; then
  ./14-*.sh
fi

# vim:foldmethod=indent
