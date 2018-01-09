#!/bin/bash
#-vx
WINEARCH='win32'
WINEPREFIX=$HOME'/.wineprefix/mockplus'

if [ ! -e Mockplus_Setup*.exe ]; then
  echo 'Execute this script from folder when Mockplus Setup file is'
  exit
fi

grep -lr 'Exec.*mockplus' $HOME/.local/share/applications/ | xargs rm
if [ -e $WINEPREFIX ]; then
  rm -rf $WINEPREFIX
fi

WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine 'wineboot'
echo 'Set wine to WIN7'
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks settings win10

echo 'Install VCRUN'
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks d3dx11_43
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks usp10
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks settings win10
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine Mockplus_Setup_v3.2.10.1.exe
