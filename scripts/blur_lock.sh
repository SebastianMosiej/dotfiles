#!/bin/bash
set -eu

CONVERT=$(which "convert" &2> /dev/null)
if [ -z "$CONVERT" ]; then
  echo "Install imagemagick package"
  logger -t blur_lock "Missing convert command. Install imagemagick package"
  exit 1
fi

RESOLUTION=$(xrandr -q|sed -n 's/.*current[ ]\([0-9]*\) x \([0-9]*\),.*/\1x\2/p')

# lock the screen
import -silent -window root jpeg:- | convert - -scale 20% -blur 0x2.5 -resize 500% RGB:- | \
    i3lock --raw $RESOLUTION:rgb -i /dev/stdin -e $@
    
# sleep 1 adds a small delay to prevent possible race conditions with suspend
#sleep 1

exit 0
