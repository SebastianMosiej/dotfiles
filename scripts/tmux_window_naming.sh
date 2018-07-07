#!/bin/bash -vx

CODE_DIR="rf_code"
TITLE_PREFIX=""

if [[ -n ${SSH_CONNECTION+x} ]]; then
  TITLE_PREFIX=`echo $HOSTNAME | sed -e 's|\([^\.]*\).*|\1 |'`
fi

if [[ $# -eq 0 ]]; then
  path=`pwd`
else
  path=$1
fi

extract_project_name()
{
  local window_name=${path##*projects\/}
  if [[ $window_name == $path ]]; then 
    window_name=${path##*projekty\/}
  fi
  if [[ $window_name == $path ]]; then 
    window_name=${path##*python\/}
  fi
  window_name=${window_name%%\/*}
  logger "Renaming window to '$window_name'"
  tmux rename-window "$window_name"
}

extract_pr_id()
{
  local window_name=""
  if [[ $path =~ PR[[:digit:]]{6} ]]; then
    window_name=${BASH_REMATCH[0]}
  fi
  if [[ $path =~ NA[[:digit:]]{6,9} ]]; then
    window_name=${BASH_REMATCH[0]}
  fi
  if [[ $path =~ RF[[:digit:]]{1,2} ]]; then
    window_name=$window_name" "${BASH_REMATCH[0]}
  elif [[ $path =~ SM ]]; then
    window_name=$window_name" "${BASH_REMATCH[0]}
  fi
  logger "Renaming window to '$window_name'"
  tmux rename-window "$TITLE_PREFIX$window_name"
}

extract_code_id()
{
  local window_name=""
  pos=`echo $path | grep -bo "rf_code\|work\|fpword" | cut -d':' -f1`
  if [[ -z $pos ]]; then 
    return
  fi
  path=${path:pos:200}
  IFS='/' read a code_dir b <<< $path
  tmux rename-window "$TITLE_PREFIX$code_dir"
}

logger "Executing rename-window on path '$path'"
case "$path" in 
  *PR[0-9][0-9][0-9][0-9][0-9][0-9]*) extract_pr_id ;;
  *NA[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]*) extract_pr_id ;;
  *rf_code*) extract_code_id;;
  *fpwork*) extract_code_id;;
  *work*) extract_code_id;;
  *proje[kc]t[ys]*) extract_project_name;;
  #*projects*) extract_project_name;;
  *project/python*) extract_project_name;;
esac
#process it
