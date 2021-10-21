#!/usr/bin/env bash

export SETUP_HOME=$HOME/setup
export POP_SETUP=$SETUP_HOME/pop-setup
export POP_REPO=$REPO_HOME/pop-setup.git

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

# setup zsh
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# setup zinit
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# setup zimfw
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

# run setup using zsh
if confirm "Continue to ./01-setup-gh.sh?"; then
  ./01-setup-gh.sh
fi

# vim:foldmethod=indent
