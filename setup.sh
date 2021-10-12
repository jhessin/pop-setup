#!/usr/bin/env bash

# Use variables for everything.
REPO_HOME=https://github.com/jhessin
SETUP_HOME=$HOME/setup
POP_SETUP=$SETUP_HOME/pop-setup
POP_REPO=$REPO_HOME/pop-setup.git
USER_BIN=$HOME/.local/bin
PROJECTS=$HOME/Projects
CONFIGS=$HOME/.config
FLUTTER_REPO=https://github.com/flutter/flutter.git
FLUTTER_HOME=$HOME/flutter
HOMEBREW_PATH=/home/linuxbrew/.linuxbrew
FONT_PATH=$HOME/.local/share/fonts

# setup confirmation prompt
function confirm {
  read -r -p "$1 [y/N]" response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    return 0
  else
    return 1
  fi
}

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

# Setup proper programmer dvorak keymap.
if confirm "Setup Programmer DVORAK?"; then
  localectl set-x11-keymap us pc105 dvp compose:102,numpad:shift3,kpdl:semi,keypad:atm,caps:escape
  localectl set-keymap --no-convert dvp
fi

# setup gpg keys
if confirm "Do you need gpg keys?"; then
  wget -O - https://apt.enpass.io/keys/enpass-linux.key | sudo tee /etc/apt/trusted.gpg.d/enpass.asc
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
fi

# Copy sources to /etc/apt/sources.list.d/
sudo cp ./sources/*.list /etc/apt/sources.list.d/

# Update everything
sudo apt update
sudo apt upgrade -y

# Install everything in the apt.packages file
sudo apt install $(cat apt.packages) -y

# Install Homebrew
if [ ! -d $HOMEBREW_PATH ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install brew packages
if confirm "Install brew packages?"; then
  brew install $(cat ./brew.packages)
fi

# Install kitty terminal
if confirm "Install kitty terminal?"; then
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  # Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
  # your PATH)
  sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin/
  # Place the kitty.desktop file somewhere it can be found by the OS
  cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
  # Update the path to the kitty icon in the kitty.desktop file
  sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
fi

# Install nvm and node
if confirm "Install NVM and Node?"; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
  export NVM_DIR="$HOME/.config/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm install --lts
  nvm use --lts
fi

npm i -g npm
npm i -g $(cat ./npm.packages)

# Install rustup and cargo
if [ ! -d $HOME/.cargo ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  export PATH=$HOME/.cargo/bin:$PATH
fi
cargo install $(cat ./cargo.packages)

# install ruby and gems
if confirm "Install ruby and gems?"; then
  gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable
  rvm install ruby-3
  sudo gem install $(cat ./gem.packages)
fi

# setup zsh
if confirm "Would you like to setup zsh?"; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # setup zinit
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi

# install pip
if confirm "Do you need to install pip?"; then
  sudo python3 get-pip.py
fi

# install pip.packages
pip install $(cat ./pip.packages) --user

# Install fonts
if [ ! -d $FONT_PATH ]; then
  mkdir -p $FONT_PATH
fi
cp ./fonts/ttf/*.* $FONT_PATH

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

# LAST STEP: setup neovim
$CONFIGS/nvim/install.sh
