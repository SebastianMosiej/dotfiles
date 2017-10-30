#!/bin/bash

WINEARCH='win32'
WINEPREFIX=$HOME'/.wineprefix/evernote'
mkdir -p ~/bin
# App Version ID => http://filehippo.com/download_evernote/comments/62063/
wget -nv -O Evernote_5.8.13.8152.exe http://filehippo.com/download/file/f1674a8abf503147b3abd6afea9b33ec07fe0fedd3f9870fcaf2af18b072e895/
wget -nv -N https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -P ~/bin
chmod a+x ~/bin/winetricks

mkdir -p ~/.wineprefix/
if [[ ! -e ~/.wineprefix/evernote/ ]]; then
  WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine 'wineboot'
fi
if [[ ! -e ~/.wineprefix/evernote/drive_c/Program\ Files/Evernote ]]; then
  WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine Evernote_5.8.13.8152.exe
  WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks corefonts
  WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks fontsmooth=rgb fontsmooth-rgb
fi

[ 0 -eq `grep WINEARCH ~/.bashrc | wc -l` ] && echo "export WINEARCH='win32'" >> ~/.bashrc
[ 0 -eq `grep WINEPREFIX ~/.bashrc | wc -l` ] && echo "export WINEPREFIX='"$HOME"/.wineprefix/evernote'" >> ~/.bashrc
[ 0 -eq `grep EVERNOTE_PATH ~/.bashrc | wc -l` ] && echo "export EVERNOTE_PATH='/drive_c/Program\ Files/Evernote/Evernote'" >> ~/.bashrc
[ 0 -eq `grep 'alias evernote' ~/.bashrc | wc -l` ] && echo "alias evernote='(cd '$WINEPREFIX$EVERNOTE_PATH'; wine Evernote.exe &> '$WINEPREFIX'/log &)'" >> ~/.bashrc
