#!/bin/bash

#get current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIGS_DIR=$(realpath ./conf_files)
SCRIPTS_DIR=$(realpath ./scripts)

install_package()
{
  if [ `dpkg-query -W --showformat='${Status}\n' $1 2> /dev/null | grep 'installed' | wc -l` -eq 0 ];then
    echo "Install $1"
    sudo apt-get install $1 -qq 2> /dev/null
  else
    echo "$1 is already installed"
  fi 
}

CONFIG_FILES=$(run-parts --list ./user_configuration_scrips)
if [ -n "$CONFIG_FILES" ]; then
  set +e
  for CONFIG_FILE in $CONFIG_FILES; do
    echo " - sourcing file $CONFIG_FILE"
    . $CONFIG_FILE
  done
  set -e
fi

source vim_link_script.sh

