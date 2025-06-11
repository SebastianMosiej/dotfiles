#!/bin/bash
# Get the coordinates of the active window's
#    top-left corner, and the window's size.
#    This excludes the window decoration.
set -eu

XDOTOOL_=$(which "xdotool" &2> /dev/null)
FFMPEG_CMD_PREFIX="ffmpeg -f x11grab -framerate 30"

logger -t record_window "start with params[$#]: $@"

echo "Stopping already running recorder"
ffmpeg_pid=$(ps -ax | grep ffmpeg | grep -v grep | cut -d' ' -f 3)
if [ -n "$ffmpeg_pid" ]; then
  logger -t record_window "Stopping already running recorder"
  pkill -9 ffmpeg
  exit 0
fi

function print_help() {
  echo "Usage: $0 <window_title> <output_file>"
  echo ""
  echo "Arguments:"
  echo "  <output_file> - path where to output will be created. Provided extension will impact result format."
  echo "  <window_title> - [optional] title of a window to record. Can be checked with xprop or xwininfo"
  echo "                   if not provided and xdotool is installed - use active window"
}

WIN_INFO_=""
unset x y w h
if [ -n "$XDOTOOL_" ] && [ $# -eq 1 ]; then
  WIN_INFO_=$(xwininfo -id $(xdotool getactivewindow))
elif [ $# -eq 2 ]; then
  WIN_INFO_=$(xwininfo -name "$2")
else
  logger -t record_window "No window found, exiting"
  print_help
  exit 1
fi

eval $(printf "$WIN_INFO_" |
    sed -n -e "s/Absolute upper-left X: \+\([0-9]\+\)/x=\1/p" \
        -e "s/Absolute upper-left Y: \+\([0-9]\+\)/y=\1/p" \
        -e "s/Width: \+\([0-9]\+\)/w=\1/p" \
        -e "s/Height: \+\([0-9]\+\)/h=\1/p" )

logger -t record_window "Start ffmpeg at ($x,$y) with size ($w,$h)"
ffmpeg -f x11grab -framerate 30 -video_size "$w"x"$h" -show_region 1 -i :0.0+$x,$y $1
logger -t record_window "End"
