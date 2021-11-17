#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Make sure we are in the right directory
cd $POP_SETUP

# setup gpg keys
if confirm "Do you need gpg keys?"; then
  wget -O - https://apt.enpass.io/keys/enpass-linux.key | sudo tee /etc/apt/trusted.gpg.d/enpass.asc
fi

# Copy sources to /etc/apt/sources.list.d/
echo Copying sources for updates
sudo cp ./sources/*.list /etc/apt/sources.list.d/

if confirm "Continue to ./05-setup-apt.sh"; then
  ./05-setup-apt.sh
fi

# vim:foldmethod=indent
