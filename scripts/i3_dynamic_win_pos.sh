#!/bin/bash
# Get workspace/screen dimensions
SCREEN_WIDTH=$(xrandr --current | grep '*' | head -1 | awk '{print $1}' | cut -d 'x' -f1)
SCREEN_HEIGHT=$(xrandr --current | grep '*' | head -1 | awk '{print $1}' | cut -d 'x' -f2)
WINDOW_CLASS=$3

# Calculate 60% from left and 5% from top
POS_X=$((SCREEN_WIDTH * ${1:-60} / 100))
POS_Y=$((SCREEN_HEIGHT * ${2:-5} / 100))

# Move the window
MESSAGE="move position ${POS_X}px ${POS_Y}px"
if [ -n $WINDOW_CLASS ]; then
  MESSAGE="[class=\"$WINDOW_CLASS\"] $MESSAGE"
fi
i3-msg "$MESSAGE"
