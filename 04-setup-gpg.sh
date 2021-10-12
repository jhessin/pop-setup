#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Make sure we are in the right directory
cd $POP_SETUP

# setup gpg keys
if confirm "Do you need gpg keys?"; then
  wget -O - https://apt.enpass.io/keys/enpass-linux.key | sudo tee /etc/apt/trusted.gpg.d/enpass.asc
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
fi

if confirm "Continue to ./05-apt-install.sh"; then
  ./05-apt-install.sh
fi

# vim:foldmethod=indent
