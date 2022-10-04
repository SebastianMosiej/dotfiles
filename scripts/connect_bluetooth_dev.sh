#!/bin/bash
#-xv
REPEAT=0
MAX_REPEAT_COUNT=5
SLEEP_TIME=0.5
DEV_MAC="38:18:4C:24:FF:E8"

function connect_device() {
  local DEV_MAC=$1
  STATUS=`bluetoothctl info $DEV_MAC | grep -i connect | tr -d ' ' | cut -d ':' -f 2`
  if [ "$STATUS" = "no" ] || [ "$STATUS" = "" ]; 
  then
    bluetoothctl connect $DEV_MAC
    sleep $SLEEP_TIME
    STATUS=`bluetoothctl info $DEV_MAC | grep -i connect | tr -d ' ' | cut -d ':' -f 2`
  fi
  if [ "$STATUS" = "yes" ]; then
    STATUS=`bluetoothctl info $DEV_MAC | grep Name | tr -d ' ' | cut -d ':' -f 2`
    #ensure A2DP Sink profile (based on card, not sink index)
    pacmd  set-card-profile $(pacmd list-sinks | grep "state: RUNNING" -B 4 -A 30 | grep card | cut -d ' ' -f 2) a2dp_sink
    notify-send -t 1 "BT Device \"$STATUS\" connected"
    exit 1
  fi
}


if [ $# -eq 0 ]; then
  connect_device $DEV_MAC
else
  if [ $REPEAT -ne $MAX_REPEAT_COUNT ]; then
    for device_mac in "$@" 
    do
      connect_device $device_mac
    done
    ((REPEAT++))
  fi
fi



