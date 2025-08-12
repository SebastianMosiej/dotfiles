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

setupLoging() {
  local logDir="$DIR/log"
  local logFile="install_$(date +'%Y-%m-%d_%H%M%S').log"


  # Log dir exists
  if test -d $logDir
    then
        # Remove old log file
        echo -e "$YELLOW[NOTE] Removing old log file$DEFAULT"
        rm -r $logDir/* 

        # Create new log FILE
        echo -e "$YELLOW[NOTE] Creating log file '$logDir/$logFile'$DEFAULT"
        touch $logDir/$logFile
  else
        # Create log dir and log FILE
        echo -e "$YELLOW[NOTE] Creating log file '$logDir/$logFile'$DEFAULT"
        mkdir $logDir
        touch $logDir/$logFile
  fi

  # Write header
  echo -e "########################\n## [LOG-FILE] ##\n########################" > $logDir/$logFile

  # Redirect stderr to log FILE
  exec > >(tee -a $logDir/$logFile)
  exec 2>&1
}

processScripts() {
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
}

# if it isn't sourced by other script
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    setupLoging 
    processScripts
fi

