#!/bin/bash
#-vx
#current testing name
TESTING_RELEASE="buster"
#logging macro
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>sketchup_install.log 2>&1

#wget -nv -N http://dl.trimble.com/sketchup/2016/en/SketchUpPro-2016-1-1450-80430-en-x86.exe 

export WINEARCH='win64'
export WINEPREFIX=$HOME'/.wineprefix/sketchup_2017'
WINE_SKETCHUP_DIR=$WINEPREFIX/drive_c/Program\ Files\ \(x86\)\SketchUp\Sketchup\ 2017
WINE_WINDOWS_DIR=$WINEPREFIX/drive_c/windows
#cleanup wine desktop files
grep -lr 'Exec.*sketchup' $HOME/.local/share/applications/ | xargs rm
if [ -e $WINEPREFIX ]; then
  rm -rf $WINEPREFIX
fi

wine64 'wineboot'

echo 'Install VCRUN'
winetricks vcrun2015
winetricks vcrun2013
winetricks corefonts

echo 'Set wine to WIN7'
winetricks settings win7

echo 'Install .NET 4.5.2'
#https://www.microsoft.com/en-us/download/details.aspx?id=42642
wine64 NDP452-KB2901907-x86-x64-AllOS-ENU.exe

echo 'Install Sketchup'
#wine64 start Sketchup2017-x64.msi 
WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine64 SketchUpMake-2017-pl-x64.exe
#now prerequisite should be unpacked
#echo 'Expecting prerequisites in user Temp dir'
#ls -al $WINEPREFIX/drive_c/users/$LOGNAME/Temp/sketchup_install/

#echo 'Second attempt to install sketchup'
#WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine64 sketchupmake-2017-2-2555-90782-en-x64.exe
#cp $WINE_WINDOWS_DIR/syswow64/mfc140u.dll $WINE_WINDOWS_DIR/system32/mfc140u.dll
#echo 'Copy mfc140 libraries to system32'
#cp mfc140u.dll $WINE_WINDOWS_DIR/system32/
#cp mfc140.dll $WINE_WINDOWS_DIR/system32/
#cp $WINE_SKETCHUP_DIR\sketchup_webhelper.exe $WINE_SKETCHUP_DIR\sketchup_webhelper.exe_bak
