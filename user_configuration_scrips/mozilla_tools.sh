#!/bin/bash 
#-vx

PREFS_FILE="user.js"
export DISPLAY=:0


#return path to prefs.js file with user preference values 
# 1 param - name of application (icedove, firefox, iceweasel)
function get_profile_dir()
{
  local path=""
  case "$1" in
    "icedove") if [[ -e "$HOME/.icedove" ]]; then
      path=".icedove"
    else
      echo "Icedove folder ~/.icedove not exists"
      return 1
    fi
      ;;
    "firefox"|"iceweasel")
      if [[ -e "$HOME/.mozilla/firefox" ]]; then
        path=".mozilla/firefox"
      else
        echo "Firefox folder ~/.mozilla/firefox folder doesn't exists"
        return 1
      fi
      ;;
    *) echo "$1 isn't supported";  return 1
      ;;
  esac
  result=`grep -m 1 Path $HOME/$path/profiles.ini | sed s/Path=//`
  result="$HOME/$path/$result/"
}

function get_prefs_file()
{
  get_profile_dir $1
  result="$HOME/$path/$result/$PREFS_FILE"
}


# Retrieve the extension id for an addon from its install.rdf
get_extension_id() {
    unzip -qc $1 install.rdf | grep -m 1 "<em:id>" | sed 's/^.*>\(.*\)<.*$/\1/g'
}


# 1 mozilla add-on in xpi file format
get_extension_unpack() {
    unzip -qc $1 install.rdf | grep -m 1 "<em:unpack>"  | sed 's/^.*>\(.*\)<.*$/\1/g'
}

# 1 URL to add-on
function install_single_addon()
{
  wget -qq -N $1
  file_name=${1##*/}
  EXT_UID=$(get_extension_id $file_name)
  UNPACK=$(get_extension_unpack $file_name)
  DEST_DIR=$2/$EXT_UID
  #Create folder for extension in user home dir
  if [[ $UNPACK = "true" ]]; then
    [ ! -d $DEST_DIR ] && unzip -q $file_name -d $DEST_DIR
    rm $file_name
  else
    DEST_DIR=$DEST_DIR".xpi"
    if [[ ! -e $DEST_DIR ]]; then
      echo "Copying addon to "$DEST_DIR
      mv $file_name $DEST_DIR
    else
      #echo "File allready exists "$EXT_UID".xpi"
      rm $file_name
    fi
  fi 
}

# $1 path to user extension dir
# $2 addons URL list
function install_addons()
{
  if [[ ! -d $1 ]]; then 
    mkdir -p $1
  fi


  addons=("${!2}")
  for i in "${addons[@]}"
  do
    install_single_addon $i $1
  done
}
