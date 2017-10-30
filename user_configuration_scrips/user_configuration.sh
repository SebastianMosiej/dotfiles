#!/bin/bash
# $1 - user name
STABLE_RELEASE='jessie'
TESTING_RELEASE='stretch'
SCRIPTS_DIR='~/vim_developer_enviroment/user_configuration_scrips'

user_name=$1


if [[ -z $1 ]]; then
  echo "Lack of first parameter - user name"
  exit
fi
getent passwd $1  > /dev/null
if [[ $? -ne 0 ]]; then
  echo "No, the user '"$1"' does not exist"
  exit
fi
HOME_DIR='/home/'$1

function run_script_as_user()
{
  # $1 user name
  # $2 script name
  chmod a+x $SCRIPTS_DIR/$2
  #command="cd "$SCRIPTS_DIR"; ./"$2";"
  runuser -l $1 -c 'cd $SCRIPTS_DIR; ./$2'
}

sed -i -e 's/\b'$STABLE_RELEASE'\b/'$TESTING_RELEASE'/g' /etc/apt/sources.list
#shorten grub startup OS selection delay to 0 and run it in console
sed -i -e 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sed -i -e 's/#GRUB_TERMINAL=console/GRUB_TERMINAL=console/g' /etc/default/grub
update-grub

apt-get update -qq
apt-get upgrade -yq
apt-get install sudo vim vim-gnome icedove i3 iceweasel tilda -yqq
apt-get install software-properties-common psi-plus -yqq

runuser -l $1 -c 'cp $SCRIPTS_DIR/bashrc_home ~/.bashrc_home'
[ 0 -eq `grep bashrc_home $HOME_DIR/.bashrc | wc -l` ] && echo "source ~/.bashrc_home" >> $HOME_DIR/.bashrc
run_script_as_user $1 'mozilla_plugins.sh'
[ 0 -eq `grep TERMINAL $HOME_DIR/.bashrc | wc -l` ] && echo "export TERMINAL='tilda'" >> $HOME_DIR/.bashrc

source development_tools.sh $1

source wine_configuration.sh $1

#Spotify
source spotify.sh

#TeamViz
source teamviz.sh $1

source insync.sh
