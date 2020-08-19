#!/bin/bash

#get current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#was run 

install_package()
{
  if [ `dpkg-query -W --showformat='${Status}\n' $1 2> /dev/null | grep 'installed' | wc -l` -eq 0 ];then
    echo "Install $1"
    sudo apt-get install $1 -qq 2> /dev/null
  fi 
}


source user_configuration_scrips/1_i3_config.sh
source user_configuration_scrips/2_runtime_configs.sh
source vim_link_script.sh
source user_configuration_scrips/3_development_tools.sh

