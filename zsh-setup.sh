#!/usr/bin/env bash

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Clone/update repo if $HOME/setup/pop-setup exists or not.
if [ -d $POP_SETUP ]; then
  echo Repo downloaded updating...
  cd $POP_SETUP
  git pull
  echo Repo updated
else
  echo Downloading repo...
  mkdir $SETUP_HOME
  git clone $POP_REPO $POP_SETUP
  echo Repo downloaded!
fi

# Make sure we are in the right directory
cd $POP_SETUP

# Install zsh
sudo apt install zsh -y

# run setup using zsh
./setup.sh

# vim:foldmethod=indent
