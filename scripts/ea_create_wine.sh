TESTING_RELEASE="testing"
sudo dpkg --add-architecture i386
sudo wget -qq https://dl.winehq.org/wine-builds/Release.key 
sudo apt-key add Release.key
sudo add-apt-repository -r "deb http://dl.winehq.org/wine-builds/debian/ $TESTING_RELEASE main"
sudo add-apt-repository "deb http://dl.winehq.org/wine-builds/debian/ $TESTING_RELEASE main"
sudo apt-get update -qq
sudo apt-get install --install-recommends winehq-devel cabextract winbind -qq
sudo apt-get install fonts-crosextra-carlito -qq
wget -nv -N https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -P ~/bin
chmod a+x ~/bin/winetricks

wget -nv -N http://www.sparxsystems.com/bin/easetup.msi
WINEARCH='win32'
WINEPREFIX=$HOME'/.wineprefix/ea_sparx'

if [[ ! -e $WINEPREFIX ]]; then
  WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine 'wineboot'
fi

  WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks msxml3
  WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks msxml4
  WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX winetricks mdac28

  WINEARCH=$WINEARCH WINEPREFIX=$WINEPREFIX wine msiexec /i easetup.msi

