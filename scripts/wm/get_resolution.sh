#!/bin/bash

resolutions=$('xrandr' | awk '
BEGIN {
CURRENT_DISPLAY = ""
RESOLUTION = ""
}

/ connected / {
if (CURRENT_DISPLAY!="") {
    print CURRENT_DISPLAY ":" RESOLUTION
    RESOLUTION=""
  }
  CURRENT_DISPLAY = $1
}

/   .*/ {
  if (RESOLUTION=="") {
    RESOLUTION=$1
  }
}
END {
if (CURRENT_DISPLAY!="") {
    print CURRENT_DISPLAY":"RESOLUTION
    RESOLUTION=""
  }
}')

for dis in $resolutions; do
  IFS=':' read display resolution <<< "$dis"
  `xrandr --output $display --mode $resolution`
  echo $display has resolution $resolution
done
