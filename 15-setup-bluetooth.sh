#!/usr/bin/env zsh

sudo sed -i 's/load-module module-bluetooth-discover$/load-module module-bluetooth-discover headset=ofono' /etc/pulse/default.pa

sudo sed '/<\/busconfig>/i <policy user="pulse">\n<allow send_destination="org.ofono"\/>\n<\/policy>' /etc/dbus-1/system.d/ofono.conf

sudo echo [phonesim] >> /etc/ofono/phonesim.conf
sudo echo Driver=phonesim >> /etc/ofono/phonesim.conf
sudo echo Address=127.0.0.1 >> /etc/ofono/phonesim.conf
sudo echo Port=12345 >> /etc/ofono/phonesim.conf

# Add functions and vars
source ./functions.sh
source ./vars.sh

# Make sure we are in the right directory
cd $POP_SETUP


if confirm "Continue to ./20-setup-brew.sh"; then
  ./20-setup-brew.sh
fi

# TODO TEST THIS!

# vim:foldmethod=indent
