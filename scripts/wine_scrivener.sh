#!/bin/bash
#-vxe
WINEPREFIX_DIR=$HOME'/.wineprefix'
WINEPREFIX=$WINEPREFIX_DIR'/scrivener'
WINEARCH=win64
#cleanup wine desktop files
if [ -e $WINEPREFIX ]; then
  grep -lr 'Exec.*scrivener' $HOME/.local/share/applications/ | xargs rm 2> /dev/null
  rm -rf $WINEPREFIX
fi

if [ ! -f ~/bin/winetricks ]; then
  wget -nv -N https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -P ~/bin
  chmod a+x ~/bin/winetricks
fi

WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine64 'wineboot'

echo 'Set wine to WIN7'
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks settings win10

echo 'Install dotnet45'
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks dotnet48

#echo 'Install VCRUN'
#WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks vcrun6
#probably below is not needed
#WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks vcrun2015
echo 'Install corefonts'
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks corefonts

echo 'Install speechsdk'
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks speechsdk
#echo 'Install sapi'
#WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks sapi

echo 'Install Scrivener'
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine64 Scrivener-installer.exe

echo 'Rename texttospeech folder inside Scrivener'
mv "$WINEPREFIX/drive_c/Program\ Files/Scrivener3/texttospeech" "$WINEPREFIX/drive_c/Program\ Files/Scrivener3/texttospeech_old" 
