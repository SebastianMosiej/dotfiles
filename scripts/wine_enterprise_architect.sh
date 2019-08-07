TESTING_RELEASE="testing"
#test architecture
#sudo dpkg --add-architecture i386
#sudo wget -qq https://dl.winehq.org/wine-builds/Release.key 
#sudo apt-key add Release.key
#sudo add-apt-repository -r "deb http://dl.winehq.org/wine-builds/debian/ $TESTING_RELEASE main"
#sudo add-apt-repository "deb http://dl.winehq.org/wine-builds/debian/ $TESTING_RELEASE main"
#sudo apt-get update -qq
#sudo apt-get install --install-recommends winehq-devel cabextract winbind -qq
#sudo apt-get install fonts-crosextra-carlito -qq
#wget -nv -N https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -P ~/bin
#chmod a+x ~/bin/winetricks
#suod rm Release.key


WINEARCH='win32'
WINEPREFIX=$HOME'/.wineprefix/ea_sparx'
#remove old wineprefix
grep -lr 'Exec.*sparx' $HOME/.local/share/applications/ | xargs rm
if [ -e $WINEPREFIX ]; then
  echo 'Remove old WINEPREFIX'
  rm -rf $WINEPREFIX
fi

#set those variable inside and only inside script
export WINEARCH='win64'
export WINEPREFIX=$HOME'/.wineprefix/sketchup_2017'

echo 'Initialize WINEPREFIX'
wine 'wineboot'

echo 'Download Enterprise Architect'
wget -nv -N http://www.sparxsystems.com/bin/easetup.msi -P $WINEPREFIX

echo 'Install packages'
winetricks msxml3
winetricks msxml4
winetricks mdac28

echo 'Install EA'
wine msiexec /i $WINEPREFIX/easetup.msi

