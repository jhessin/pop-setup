#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Make sure we are in the right directory
cd $POP_SETUP

# Setup proper programmer dvorak keymap.
if confirm "Setup Programmer DVORAK?"; then
  localectl set-x11-keymap us pc105 dvp compose:102,numpad:shift3,kpdl:semi,keypad:atm,caps:escape
  localectl set-keymap --no-convert dvp
fi

if confirm "Do you want to continue to ./04-setup-gpg.sh"; then
  ./04-setup-gpg.sh
fi

# vim:foldmethod=indent
