#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Make sure we are in the right directory
cd $POP_SETUP

# Install rustup and cargo
if [ ! -d $HOME/.cargo ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  export PATH=$HOME/.cargo/bin:$PATH
fi
cargo install $(cat ./cargo.packages)

if confirm "Continue to ./09-setup-ruby.sh"; then
  ./09-setup-ruby.sh
fi

# vim:foldmethod=indent
