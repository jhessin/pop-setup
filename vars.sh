#!/usr/bin/env zsh

# Use variables for everything.
export REPO_HOME=https://github.com/jhessin
export SETUP_HOME=$HOME/setup

if [ -d $HOME/Projects/pop-setup ]; then
  export POP_SETUP=$HOME/Projects/pop-setup
else
  export POP_SETUP=$SETUP_HOME/pop-setup
fi
export USER_BIN=$HOME/.local/bin
export PROJECTS=$HOME/Projects
export CONFIGS=$HOME/.config
export FLUTTER_REPO=https://github.com/flutter/flutter.git
export FLUTTER_HOME=$HOME/flutter
export HOMEBREW_PATH=/home/linuxbrew/.linuxbrew
export FONT_PATH=$HOME/.local/share/fonts

