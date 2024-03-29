#!/bin/bash
# Get the coordinates of the active window's
#    top-left corner, and the window's size.
#    This excludes the window decoration.

unset x y w h
#eval $(xwininfo -id $(xdotool getactivewindow) |
eval $(xwininfo -name "$1" |
  sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p" \
         -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p" \
         -e "s/^ \+Width: \+\([0-9]\+\).*/w=\1/p" \
         -e "s/^ \+Height: \+\([0-9]\+\).*/h=\1/p" )
echo -n "$x $y $w $h"
ffmpeg -f x11grab -framerate 30 -video_size "$w"x"$h" -show_region 1 -i :0.0+$x,$y $2
