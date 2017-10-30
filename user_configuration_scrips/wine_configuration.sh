#!/bin/bash

echo "Installing WINE"
#install WINE
dpkg --add-architecture i386
wget -qq https://dl.winehq.org/wine-builds/Release.key 
apt-key add Release.key
rm Release.key
add-apt-repository -r "deb http://dl.winehq.org/wine-builds/debian/ $TESTING_RELEASE main"
add-apt-repository "deb http://dl.winehq.org/wine-builds/debian/ $TESTING_RELEASE main"
apt-get update -qq
apt-get install winehq-devel cabextract winbind -qq
#configure WINE
run_script_as_user $1 "wine_configuration_user.sh"
# runuser -l $1 -c "cd ~/vim_developer_enviroment/;chmod a+x wine_configuration.sh; ./wine_configuration.sh"

