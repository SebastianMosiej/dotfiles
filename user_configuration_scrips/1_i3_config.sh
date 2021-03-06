#!/bin/bash

PREFIX_SPACE="   "
#creating i3 configuration
echo " Processing i3"
if [ ! -d ~/.config/i3 ]; then
  mkdir ~/.config/i3 -p
fi
if [ ! -e ~/.config/i3/config ]; then
  echo "   Creating link to i3 configuration"
  ln $DIR/conf_files/i3/i3_config ~/.config/i3/config
else
  echo "   i3 configuration exist"
fi

if [ -d ~/.i3 ]; then
  echo "   Removing old i3 configuration folder"
  rm -rf ~/.i3
fi

if [ ! -e /usr/bin/i3exit ]; then
  echo "   Creating link to i3exit"
  sudo ln $DIR/conf_files/i3/i3exit.sh /usr/bin/i3exit
  sudo chmod a+x /usr/bin/i3exit
fi

if [ ! -e /usr/bin/laptop_docking.sh ]; then
  echo "   Creating link to laptop_docking.sh"
  sudo ln -s $DIR/scripts/laptop_docking.sh /usr/bin/laptop_docking.sh
  sudo chmod a+x /usr/bin/laptop_docking.sh
fi

install_package nitrogen
install_package feh
install_package i3

if [ ! -e $HOME/.xsession ]; then
  echo "   Copying xsession"
  cp $DIR/conf_files/xsession $HOME/.xsession
fi

echo " Processing i3 DONE"
