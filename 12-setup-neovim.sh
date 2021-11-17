#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

if confirm "Get the appimage of Neovim?"; then
  browse https://github.com/neovim/neovim/releases
fi

# setup neovim
$CONFIGS/nvim/install.sh

# Make sure we are in the right directory
cd $POP_SETUP

if confirm "Continue?"; then
  ./13-*.sh
fi

# vim:foldmethod=indent
