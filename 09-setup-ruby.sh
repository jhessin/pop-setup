#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Make sure we are in the right directory
cd $POP_SETUP

# install ruby and gems
if confirm "Install ruby and gems?"; then
  gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable
  rvm install ruby-3
  sudo gem install $(cat ./gem.packages)
fi

if confirm "Continue to ./10-setup-pip.sh"; then
  ./10-setup-pip.sh
fi

# vim:foldmethod=indent
