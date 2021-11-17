#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Make sure we are in the right directory
cd $POP_SETUP

# Clone basic repositories
if confirm "Login to gh?"; then
  gh auth login
fi

if [ ! -d $USER_BIN/.git ]; then
  rm -rf $USER_BIN
  gh repo clone jhessin/bin $USER_BIN
fi

# add the bin to the path for the rest of the repos
PATH=$PATH:$USER_BIN

if [ ! -d $HOME/.git ]; then
  pushd $HOME
  gmerge dotfiles
  popd
fi

if [ ! -d $CONFIGS/.git ]; then
  pushd $CONFIGS
  gmerge .config
  popd
fi

# Clone the flutter repo for flutter development
if [ ! -d $FLUTTER_HOME ]; then
  git clone $FLUTTER_REPO $FLUTTER_HOME
fi

if confirm "Continue?"; then
  ./03-*.sh
fi

# vim:foldmethod=indent
