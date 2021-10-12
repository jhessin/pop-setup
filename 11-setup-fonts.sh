#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

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
