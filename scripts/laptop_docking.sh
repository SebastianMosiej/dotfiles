#!/bin/bash 
#-vx

function toogle_monitors()
{
  connected_output=(`xrandr -d :0 | grep -w connected | cut -d' ' -f1 | grep -v eDP1`)
  #remove modes for disconnected displays
  disconnected=(`xrandr -d :0 | egrep 'disconnected [0-9].*' | cut -d' ' -f1`)
  logger -t laptop_docking "Detected ${#disconnected[@]} disconnected but still present monitors "
  if [[ ${#disconnected[@]} -eq 1 ]]; then
    logger -t laptop_docking "Disconnecting ${disconnected[0]} display"
    xrandr -d :0 --output ${disconnected[0]} --off
  fi
  if [[ ${#connected_output[@]} -eq 1 ]]; then
    echo "One monitor - beside laptop - found"
    logger -t laptop_docking "One monitor - beside laptop - found"
    case "${connected_output[0]}" in 
      "HDMI2" ) #laptop is in docking station
        xrandr -d :0 --output HDMI2 --auto --primary --pos 0x0
        xrandr -d :0 --output eDP1 --auto --left-of HDMI2
        ;;
      *) 
        xrandr --output eDP1 --auto --primary --pos 0x0
        xrandr --output ${connected_output[0]} --auto --right-of eDP1
        ;;
    esac
  elif [[ ${#connected_output[@]} -eq 0 ]]; then
    logger -t laptop_docking "Only laptop monitor found"
    echo "Only laptop monitor found"
    xrandr -d :0 --output HDMI2 --off
    xrandr -d :0 --output eDP1 --primary
  fi
}

function restart_i3()
{
  killall -SIGSTOP i3
  toogle_monitors
  killall -SIGCONT i3
  i3-msg restart
  feh --bg-fill /usr/share/images/wallpapers/forest/Lush_Mossy_Forest.jpg
}

# if DISPLAY variable isn't set
if [ -z ${DISPLAY:+x} ]; then 
  echo "DISPLAY is unset";
  export DISPLAY=":0"
fi

if [ -z ${XAUTHORITY:+x} ]; then 
  export XAUTHORITY=/home/user/.Xauthority
fi

#if [[ uid -eq 0 ]];
#then
#  xauth remove :0
#  xauth merge /home/mosiej/.Xauthority
#fi


restart_i3
