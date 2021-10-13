#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# Make sure we are in the right directory
cd $POP_SETUP

# install chrome browser?
if confirm "Would you like to install Chrome?"; then
  echo Opening browser - please wait...
  xdg-open http://google.com/chrome
fi

# install android studio
if confirm "Would you like to install Android Studio?"; then
  echo Opening browser - please wait...
  xdg-open http://developer.android.com/studio
fi

if confirm "Continue to ./20-setup-brew.sh"; then
  ./20-setup-brew.sh
fi

# vim:foldmethod=indent
