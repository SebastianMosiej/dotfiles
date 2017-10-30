#!/bin/bash
#-vx
#current testing name
TESTING_RELEASE="buster"

wget -nv -N http://dl.trimble.com/sketchup/2016/en/SketchUpPro-2016-1-1450-80430-en-x86.exe 

#WINEARCH='win64'
WINEPREFIX_DIR=$HOME'/.wineprefix'
WINEPREFIX=$WINEPREFIX_DIR'/sketchup_2016'
#cleanup wine desktop files
grep -lr 'Exec.*sketchup' $HOME/.local/share/applications/ | xargs rm
if [ -e $WINEPREFI ]; then
  rm -rf $WINEPREFIX
fi

WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine64 'wineboot'
echo 'Install VCRUN'

WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks vcrun2015
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks corefonts

echo 'Set wine to WIN7'
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks settings win7

echo 'Install .NET 4.5.2'
#https://www.microsoft.com/en-us/download/details.aspx?id=42642
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine NDP452-KB2901907-x86-x64-AllOS-ENU.exe

echo 'Install Sketchup'
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine SketchUpPro-2016-1-1450-80430-en-x86.exe

