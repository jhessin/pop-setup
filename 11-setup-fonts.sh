#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# Make sure we are in the right directory
cd $POP_SETUP

# Install fonts
if [ ! -d $FONT_PATH ]; then
  mkdir -p $FONT_PATH
fi
cp ./fonts/ttf/*.* $FONT_PATH

if confirm "Continue to ./12-setup-neovim.sh"; then
  ./12-setup-neovim.sh
fi

# vim:foldmethod=indent
