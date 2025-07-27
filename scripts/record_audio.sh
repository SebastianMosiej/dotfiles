#!/bin/bash

function fail_with_msg() {
    logger -t record_audio "$1"
    echo "$1" >&2
    exit 1
}

PACTL=$(which pactl || fail_with_msg "Cannot find pactl. Install pulseaudio-utils package. Aborting")
REC=$(which rec || fail_with_msg "Cannot find rec. Install sox package. Aborting")
LAME=$(which lame || fail_with_msg "Cannot find lame. Install lame package. Aborting")
PAREC=$(which parec || fail_with_msg "Cannot find lame. Install pulseaudio-utils package. Aborting")

ARECORD=$(which arecord || fail_with_msg "Cannot find arecord. Install alsa-utils package. Aborting")
BT_CARD_MAC="88:C9:E8:76:6A:76"
BT_CARD_NAME="bluez_card.$(echo $BT_CARD_MAC | tr ':' '_')"
BT_SOURCE_NAME="bluez_input.$(echo $BT_CARD_MAC | tr ':' '_').headset-head-unit"
BT_A2DP_PROFILE="a2dp-sink-aac"

PIDFILE="/tmp/audio_recording.pid" 

trap 'pactl set-card-profile $BT_CARD_NAME $BT_A2DP_PROFILE' SIGTERM

function main() {

  local bt_handfree_profile=$($PACTL list cards | grep "$BT_CARD_NAME" -A 40 | grep Profiles -A 10 | grep "head.*:" | grep msbc | cut -d ':' -f 1 | xargs)
  local recording_dir="$HOME/audio_notes/"
  local note_filename="audio_note_$(date +"%Y_%m_%d_%H_%M").mp3"

  local use_rec=0
  local use_parec=1
  local use_arecord=0

  if [ ! -d $recording_dir ]; then
    mkdir -p $recording_dir
  fi

  #stop recording in progress
  if [ -f "$PIDFILE" ]; then
    local pid=$(cat "$PIDFILE")
    if [ -n "$(ps -p $pid -o pid=  2> /dev/null)" ]; then
      sleep 0.5
      kill -TERM $pid 
      sleep 0.5
      if [ -n "$(ps -p $pid -o pid= 2> /dev/null)" ]; then
        kill -KILL $pid 
        sleep 0.5
      fi
      #from /proc/pid/ can get file name to which 
      logger -t record audio "Stop recording to $recording_dir/$note_filename (PID: $pid)"
      notify-send -t 2000 "Audio note recording stopped"
      rm $PIDFILE
      $PACTL set-card-profile $BT_CARD_NAME $BT_A2DP_PROFILE
      exit
    fi
    exit
  fi

  #set BT card profile for recording
  $PACTL set-card-profile $BT_CARD_NAME $bt_handfree_profile
  #set recording volume to 104%
  $PACTL set-source-volume $BT_SOURCE_NAME 1dB
  #start recording
  if [ $use_rec -eq 1 ]; then 
    if [ dpkg-query -s libsox-fmt-mp3 >/dev/null 2>&1 ]; then 
      logger -t record audio "Lack of sox mp3 support. Install libsox-fmt-mp3. Aborting"
      fail_with_msg "Lack of sox mp3 support. Install libsox-fmt-mp3. Aborting"
    else
      logger -t record audio "Recording audio note with rec to $recording_dir/$note_filename"
      #
      # Basic recording
      rec $recording_dir/$note_filename
      # Record with automatic silence detection
      #rec $recording_dir/$note_filename silence 1 0.1 1%

      local pid=$(pgrep -n -x rec)
      echo $pid > "$PIDFILE"
      echo "Recording started: $recording_dir/$note_filename (PID: $pid)"
      logger -t record audio "Recording started: $recording_dir/$note_filename (PID: $pid)"
      notify-send -t 2000 "Audio note recording started ..."
    fi
  elif [ $use_parec -eq 1 ]; then
    $PAREC --format=s16le | $LAME -r -V2 - "$recording_dir/$note_filename"  &
    local pid=$(pgrep -n -x parec)
    # Save PID
    echo $pid > "$PIDFILE"
    echo "Recording started: $recording_dir/$note_filename (PID: $pid)"
    logger -t record audio "Recording started: $recording_dir/$note_filename (PID: $pid)"
    notify-send -t 2000 "Audio note recording started ..."
  elif [ $use_arecord -eq 1 ]; then
    logger -t record audio "Recording audio note with arecord to $recording_dir/$note_filename"
    # Basic microphone recording to MP3
    #$ARECORD -f cd -t raw | $LAME -r -V2 - $recording_dir/$note_filename
    
    # Voice recording optimized for speech
    $ARECORD -f S16_LE -c1 -r22050 -t raw | $LAME -r -s 22.05 -m m -b 64 - $recording_dir/$note_filename
    local pid=$(pgrep -n -x arecord)
    echo $pid > "$PIDFILE"
    echo "Recording started: $recording_dir/$note_filename (PID: $pid)"
    logger -t record audio "Recording started: $recording_dir/$note_filename (PID: $pid)"
    notify-send -t 2000 "Audio note recording started ..."
  fi
}

# ==========================
# ENTRY POINT
# ==========================
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # Run main
  main $@
else
  logger -t record_audio "Script started from OTHER script"
fi

