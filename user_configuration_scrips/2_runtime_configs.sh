#!/bin/bash

echo " Processing runtime configurations"
if [ -e ~/.tmux.conf ]; then
 rm ~/.tmux.conf
fi

if [ ! -e ~/.tmux.conf ]; then
  echo "   Creating link to tmux configuration"
  ln $DIR/conf_files/tmux.conf ~/.tmux.conf
fi
if [ ! -e ~/.ctags ]; then
  echo "   Creating link to ctags configuration"
  ln $DIR/conf_files/ctags $HOME/.ctags 
fi
if [ ! -e ~/.Xresources ]; then
  echo "   Creating link to Xresources configuration"
  ln $DIR/conf_files/Xresources $HOME/.Xresources
fi
xrdb -merge ~/.Xresources

install_package tmux
install_package xterm
install_package x11-xserver-utils

echo " Processing runtime configurations DONE"

