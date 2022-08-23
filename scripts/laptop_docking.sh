#!/bin/bash 
#-vx

BUILTIN_DISPLAY=eDP-1
LEFT_DISPLAY=HDMI-1
RIGHT_DISPLAY=DP-2

function toogle_monitors()
{
  connected_output=(`xrandr -d :0 | grep -w connected | cut -d' ' -f1 | grep -v $BUILTIN_DISPLAY`)
  #remove modes for disconnected displays
  disconnected1=(`xrandr -d :0 | grep -w disconnected | cut -d' ' -f1-2`)
  disconnected=(`xrandr -d :0 | egrep 'disconnected [0-9].*' | cut -d' ' -f1`)
  logger -t laptop_docking "Detected ${#connected_output[@]} connected and  ${#disconnected[@]} disconnected displays, but still present monitors"
  logger -t laptop_docking "Connected '${connected_output[@]}' and disconected '${disconnected[@]}'"
  logger -t laptop_docking "Disconected '${disconnected1[@]}'"
  if [[ ${#disconnected[@]} -eq 1 ]]; then
    logger -t laptop_docking "Disconnecting ${disconnected[0]} display"
    xrandr -d :0 --output ${disconnected[0]} --off
  fi
  if [[ ${#connected_output[@]} -eq 1 ]]; then
    logger -t laptop_docking "One monitor - beside laptop - found"
    case "${connected_output[0]}" in 
      "$LEFT_DISPLAY" ) #laptop is in docking station
        xrandr -d :0 --output $LEFT_DISPLAY --auto --primary --pos 0x0
        xrandr -d :0 --output $BUILTIN_DISPLAY --auto --left-of $LEFT_DISPLAY
        ;;
      *) 
        xrandr --output $BUILTIN_DISPLAY --auto --primary --pos 0x0
        xrandr --output ${connected_output[0]} --auto --right-of $BUILTIN_DISPLAY
        ;;
    esac
  elif [[ ${#connected_output[@]} -eq 2 ]]; then
        xrandr -d :0 --output $RIGHT_DISPLAY --auto --primary --pos 0x0
        xrandr -d :0 --output $LEFT_DISPLAY --auto --left-of $RIGHT_DISPLAY
        xrandr -d :0 --output $BUILTIN_DISPLAY --auto --right-of $RIGHT_DISPLAY
  elif [[ ${#connected_output[@]} -eq 0 ]]; then
    logger -t laptop_docking "Only laptop monitor found"
    xrandr -d :0 --output $LEFT_DISPLAY --off
    xrandr -d :0 --output $RIGHT_DISPLAY --off
    xrandr -d :0 --output $BUILTIN_DISPLAY --auto --primary --pos 0x0
  fi
  logger -t laptop_docking "Monitor toggling completed"
}

function restart_i3()
{
  killall -SIGSTOP i3
  toogle_monitors
  killall -SIGCONT i3
  i3-msg restart
  feh -r $HOME/.wallpaper --bg-max -z -D 300 &
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
