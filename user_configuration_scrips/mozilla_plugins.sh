#!/bin/bash -vx
# to debug append -vx to above line
#USER_PROFILE_DIR=`cat $HOME/.mozilla/firefox/profiles.ini | grep Path | sed s/Path=//`
#USER_EXT_DIR=$HOME'/.mozilla/firefox/'$USER_PROFILE_DIR'/extensions'
INSTALLED_FILE=~/.config/firefox_plugins_installed


FF_EXT_DIR=''
TB_EXT_DIR=''

if [[ -e $INSTALLED_FILE ]]; then
  echo "Firefox plugins already installed. Exit"
  exit
fi

. mozilla_tools.sh


ff_addons=(
  https://lastpass.com/download/cdn/lp_linux.xpi
  #Xmarks \
  https://addons.mozilla.org/firefox/downloads/latest/2410/addon-2410-latest.xpi 
  #Vimperator \
  https://addons.mozilla.org/firefox/downloads/file/341888/vimperator-3.10.1-fx.xpi 
  #Ghostery \
  https://addons.mozilla.org/firefox/downloads/latest/9609/addon-9609-latest.xpi 
  #SendToKindle \
  https://addons.mozilla.org/firefox/downloads/latest/399764/addon-399764-latest.xpi 
  #Evernote Web Clipper \
  https://addons.mozilla.org/firefox/downloads/latest/8381/addon-8381-latest.xpi 
  #Adblock \
  https://addons.mozilla.org/firefox/downloads/latest/1865/addon-1865-latest.xpi
  #DownThemAll \
  https://addons.mozilla.org/firefox/downloads/latest/201/addon-201-latest.xpi 
  #Video DownloadHelper \
  https://addons.mozilla.org/firefox/downloads/latest/3006/addon-3006-latest.xpi
  # Inoreader Companion
  https://addons.mozilla.org/firefox/downloads/latest/499050/addon-499050-latest.xpi
  # Menu Wizard
  https://addons.mozilla.org/firefox/downloads/latest/508352/addon-508352-latest.xpi
  )

get_user_profile '.mozilla/firefox'
FF_EXT_DIR=$HOME'/.mozilla/firefox/'$result'/extensions'
echo "Firefox addons installation STARTED"
#install_addons $FF_EXT_DIR ff_addons[@]
echo "Firefox addons installation FINISHED"

