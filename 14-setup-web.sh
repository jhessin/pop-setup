#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# Make sure we are in the right directory
cd $POP_SETUP

# install chrome browser?
if confirm "Would you like to install Chrome?"; then
  echo
  echo Opening browser - please wait...
  echo
  browse "http://google.com/chrome"
  echo
fi

# install Xtreme Download Manager
if confirm "Would you like to install Xtreme Download Manager?"; then
  echo
  echo Opening browser - please wait...
  echo
  browse "https://xtremedownloadmanager.com/#downloads"
fi

# install android studio
if confirm "Would you like to install Android Studio?"; then
  echo
  echo Extract the android studio package into your home folder under $HOME/android-studio
  echo Opening browser - please wait...
  echo
  browse "http://developer.android.com/studio"
  echo
fi

if confirm "Continue to ./15-setup-bluetooth.sh"; then
  ./15-setup-bluetooth.sh
fi

# vim:foldmethod=indent
