#!/bin/bash
WINDOW_CLASS=$3

WINDOW_ID=$(xdotool search --class "$WINDOW_CLASS" | tail -1)
WIN_X=$(xwininfo -id $WINDOW_ID | awk '/Absolute upper-left X:/ {print $4}' )

#set +x
#logger -t i3_pos "Window $3 X pos =  $WIN_X"
mapfile -t DISPLAYS < <(xrandr --current | sed -n "s:^.* connected.* \([0-9]\{3,4\}\)x\([0-9]\{3,4\}\)+\([0-9]*\)+.*$:\1 \2 \3:p")

# Get workspace/screen dimensions
for entry in "${DISPLAYS[@]}"; do
  read -r width height offset <<<"$entry"
  if (( $WIN_X >= $offset && $WIN_X < $offset + $width )); then
    SCREEN_WIDTH=$width
    SCREEN_HEIGHT=$height
  fi
done

if [ ! -v SCREEN_WIDTH ]; then
  logger -t i3_pos "Display not found with calculating resolutions. Using fallback method"
  SCREEN_WIDTH=$(xrandr --current | grep '*' | head -1 | awk '{print $1}' | cut -d 'x' -f1)
  SCREEN_HEIGHT=$(xrandr --current | grep '*' | head -1 | awk '{print $1}' | cut -d 'x' -f2)
fi

# Calculate 60% from left and 5% from top
POS_X=$((SCREEN_WIDTH * ${1:-60} / 100))
POS_Y=$((SCREEN_HEIGHT * ${2:-5} / 100))

# Move the window
MESSAGE="move position ${POS_X}px ${POS_Y}px"
if [ -n $WINDOW_CLASS ]; then
  MESSAGE="[class=\"$WINDOW_CLASS\"] $MESSAGE"
fi

logger -t i3_pos "On screen size ($SCREEN_WIDTH, $SCREEN_HEIGHT) for pos ($1%, $2%) window $3 moved to ($POS_X, $POS_Y)"
i3-msg "$MESSAGE"
