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
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Update everything
echo Updating your system please wait...
sudo apt update
sudo apt upgrade -y

# Install everything in the apt.packages file
echo Installing gh cli
sudo apt install gh -y

if confirm "Continue to setup repos?"; then
  ./02-setup-repos.sh
fi

# vim:foldmethod=indent
