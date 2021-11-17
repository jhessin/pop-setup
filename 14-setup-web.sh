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
if confirm "Would you like to install jetbrains toolbox?"; then
  echo
  echo Opening browser - please wait...
  echo
  browse "https://www.jetbrains.com/toolbox-app/"
  echo
fi

if confirm "Would you like to install lf(file manager)?"; then
  echo
  echo Opening browser - please wait...
  echo
  browse "https://github.com/gokcehan/lf/releases"
fi

if confirm "Continue?"; then
  ./15-*.sh
fi

# vim:foldmethod=indent
