#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Make sure we are in the right directory
cd $POP_SETUP

# Add other repos
sudo add-apt-repository ppa:smoser/bluetooth

# Update everything
echo Updating your system please wait...
sudo apt update
sudo apt upgrade -y

# Install everything in the apt.packages file
echo Installing APT.PACKAGES
sudo apt install $(cat apt.packages) -y

# Install all snaps
echo Installing snap.packages
sudo snap install $(cat snap.packages)

if confirm "Continue?"; then
  ./06-*.sh
fi

# vim:foldmethod=indent
