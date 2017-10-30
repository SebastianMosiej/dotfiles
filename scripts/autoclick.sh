#!/bin/bash
ACTIVE_FILE="/tmp/.autoclick"

if hash xdotool 2>/dev/null; then
  continue
else
  echo >&2 "Lack of xdotool command. Install xdotool packet"
  notify-send -u critical "Lack of xdotool command"
  exit 1
fi

if [[ -f "${ACTIVE_FILE}" ]]; then
  rm ${ACTIVE_FILE}
  notify-send -h string:fgcolor:#ff1010 "Deactivating autoclicker"
else
  touch ${ACTIVE_FILE}
  notify-send -h string:fgcolor:#10ff10 "Activating autoclicker"
fi


while [[ -f "${ACTIVE_FILE}"  ]]; do
xdotool click 1
sleep 0.0002
done
