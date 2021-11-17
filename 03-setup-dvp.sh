#!/usr/bin/env zsh

# Add functions and vars
source ./functions.sh
source ./vars.sh

# presudo so the user isn't surprised later
echo We need sudo to set this stuff up.
sudo echo Thank you we will be responsible!

# Make sure we are in the right directory
cd $POP_SETUP

# Setup proper programmer dvorak keymap.
if confirm "Setup Programmer DVORAK?"; then
  wget http://www.kaufmann.no/downloads/linux/kbddvp-1_2_1-src-linux.tgz
  DVP_DIR=$(mktemp -t -d kbddvp.XXXXXX)
  cat kbddvp-1_2_1-src-linux.tgz | gzip -d | tar xf - -C $DVP_DIR
  pushd $DVP_DIR/kbddvp-1.2
  chmod a+x dvp.install.sh dvp.postinst.sh
  sudo ./dvp.install.sh && sudo ./dvp.postinst.sh

  localectl set-x11-keymap us pc105 dvp compose:102,numpad:shift3,kpdl:semi,keypad:atm,caps:escape
  localectl set-keymap --no-convert dvp
  setxkbmap -layout us -variant dvp -option compose:102 -option keypad:atm -option numpad:shift3 -option kpdl:semi -option caps:escape

  popd
  rm -rf $DVP_DIR
  rm kbddvp-1_2_1-src-linux.tgz
fi

if confirm "Continue?"; then
  ./04-*.sh
fi

# vim:foldmethod=indent
