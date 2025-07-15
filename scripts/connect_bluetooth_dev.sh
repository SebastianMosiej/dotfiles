#!/bin/bash
#-xv
REPEAT=0
MAX_REPEAT_COUNT=5
SLEEP_TIME=0.5
DEV_MAC="38:18:4C:24:FF:E8"

function getBTDevConnectState() {
  if [ $# -ne 1 ]; then
    echo "getBTDevConnectState requires ONE parameter with MAC of BT Device"
    exit 1 
  fi
  echo $(bluetoothctl info $1 | grep -i connect | tr -d ' ' | cut -d ':' -f 2)
}

function setA2DPProfile() {
  local profiles_to_set=(a2dp-sink a2dp-sink-aac)
  if [ $# -ne 1 ]; then
    echo "getBTDevConnectState requires ONE parameter with MAC of BT Device"
    exit 1 
  fi
  local dev_name=`bluetoothctl info $1 | grep Name | tr -d ' ' | cut -d ':' -f 2`
  local card_name="bluez_card.${1//\:/_}"
  local profiles=$(pactl list cards | sed -n -e "/Name: $card_name/,/Active Profile:/ p" | sed -n "/Profiles:/,/Active Profile/ p" | grep -v Profile | cut -d':' -f1 | tr -d '\t' | tr '\n' ' ') 
  if [ -n "$profiles" ]; then
    for pr in "${profiles_to_set[@]}"; do
      if [[ $profiles =~ " $pr " ]]; then
        echo "Profile found"
        pactl set-card-profile $card_name $pr
        if [ $? -eq 0 ]; then
          logger -t connect_bluetooth "BT Headset $dev_name profile $pr activeted"
          notify-send -t 1 "BT Headset $dev_name profile $pr activeted"
          return
        fi 
      fi
    done
  fi
}

function connect_device() {
  local DEV_MAC=$1
  STATUS=$(getBTDevConnectState $DEV_MAC)
  logger -t connect_bluetooth "Device $DEV_MAC status is $STATUS"
  if [ "$STATUS" = "no" ] || [ "$STATUS" = "" ]; 
  then
    bluetoothctl connect $DEV_MAC
    sleep $SLEEP_TIME
    STATUS=$(getBTDevConnectState $DEV_MAC)
    logger -t connect_bluetooth "Device $DEV_MAC status after connect is $STATUS"
  fi
  if [ "$STATUS" = "yes" ]; then
    setA2DPProfile $DEV_MAC
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



