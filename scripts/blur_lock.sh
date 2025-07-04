#!/bin/bash
set -eu

CONVERT=$(which "convert" &2> /dev/null)
if [ -z "$CONVERT" ]; then
  echo "Install imagemagick package"
  logger -t blur_lock "Missing convert command. Install imagemagick package"
  exit 1
fi

RESOLUTION=$(xrandr -q|sed -n 's/.*current[ ]\([0-9]*\) x \([0-9]*\),.*/\1x\2/p')
OS_VERSION=$(grep VERSION_ID /etc/os-release| cut -d '"' -f 2)
if [ "$OS_VERSION" == "20.04" ]; then 
  import -silent -window root /tmp/screenshot_blur_raw.png
  convert /tmp/screenshot_blur_raw.png -blur 0x15 /tmp/screenshot_blur.png
  rm /tmp/screenshot_blur_raw.png
  i3lock -i /tmp/screenshot_blur.png -e $@
  rm /tmp/screenshot_blur.pngs
else
  # lock the screen                                                                                                                                                                                                                     
  import -silent -window root jpeg:- | convert - -scale 20% -blur 0x2.5 -resize 500% RGB:- | \                                                                                                                                          
    i3lock --raw $RESOLUTION:rgb -i /dev/stdin -e $@                                                                                                                                                                                  
fi

# sleep 1 adds a small delay to prevent possible race conditions with suspend
#sleep 1

exit 0
