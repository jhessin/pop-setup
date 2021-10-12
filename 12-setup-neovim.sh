#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# setup neovim
$CONFIGS/nvim/install.sh

# Make sure we are in the right directory
cd $POP_SETUP

if confirm "Continue to ./13-setup-flatpak.sh"; then
  ./13-setup-flatpak.sh
fi

# vim:foldmethod=indent
