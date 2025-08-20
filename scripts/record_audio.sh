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
BT_CARD_MAC=""
BT_CARD_MACS=("88:C9:E8:76:6A:76")

#find which BT_CARD is connected
for mac in "${BT_CARD_MACS[@]}"; do
  if $(bluetoothctl info $mac | grep -q "Connected: yes"); then 
    BT_CARD_MAC=$mac
    break;
  fi
done

if [ -z "$BT_CARD_MAC" ]; then
  echo "None of mentioned BT audio devices are connected. Aborting..."
  exit 0
fi

BT_CARD_NAME="bluez_card.$(echo $BT_CARD_MAC | tr ':' '_')"
BT_SOURCE_NAME="bluez_input.$(echo $BT_CARD_MAC | tr ':' '_').headset-head-unit"
BT_A2DP_PROFILE="a2dp-sink-aac"

PIDFILE="/tmp/audio_recording.pid" 

trap 'pactl set-card-profile $BT_CARD_NAME $BT_A2DP_PROFILE' SIGTERM

function transcribe_audio_note_1() {
  local with_gpu="" #"--gpus all"
  local device_type="cpu"  #cpu or cuda
  local audio_file=$1
  local audio_file_dir=$(dirname $(realpath $audio_file))
  local model="turbo" #large
  local models_dir="${2:-$HOME/dev/whisper/models}"
  docker run $with_gpu --rm -v ${models_dir}:/root/.cache/whisper -v $audio_file_dir:$audio_file_dir \
    openai-whisper whisper \
    $audio_file --device $device_type --model $model --language Polish --output_dir $audio_file_dir --output_format txt
} 

function stop_recording() {
    local pid=$(cat "$PIDFILE")
    if [ -n "$(ps -p $pid -o pid=  2> /dev/null)" ]; then
      sleep 0.5
      kill -TERM $pid 
      sleep 0.5
      if [ -n "$(ps -p $pid -o pid= 2> /dev/null)" ]; then
        kill -KILL $pid 
        sleep 0.5
      fi
      recording=$(basename $(ls ~/audio_notes/*.mp3 -t | head -n1) 2> /dev/null)
      logger -t record audio "Stop recording to $recording_dir/$recording (PID: $pid)"
      notify-send -t 2000 "Audio note recording stopped"
      rm $PIDFILE
      $PACTL set-card-profile $BT_CARD_NAME $BT_A2DP_PROFILE
      if [ -n $recording ]; then
        transcribe_audio_note_1 $recording_dir/$recording
        logger -t record audio "Transcription finished"
        notify-send -t 2000 "Transcription finished"
      fi
      exit
    fi
    exit
}

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
    stop_recording
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
      # Basic recording
      rec $recording_dir/$note_filename &
      # Record with automatic silence detection
      #rec $recording_dir/$note_filename silence 1 0.1 1%

      local pid=$(pgrep -n -x rec)
      echo $pid > "$PIDFILE"
      echo "Recording with rec started: $recording_dir/$note_filename (PID: $pid)"
      logger -t record audio "Recording with rec started: $recording_dir/$note_filename (PID: $pid)"
      notify-send -t 2000 "Audio note recording started ..."
    fi
  elif [ $use_parec -eq 1 ]; then
    $PAREC --format=s16le | $LAME -r -V2 - "$recording_dir/$note_filename"  &
    local pid=$(pgrep -n -x parec)
    # Save PID
    echo $pid > "$PIDFILE"
    echo "Recording with parec started: $recording_dir/$note_filename (PID: $pid)"
    logger -t record audio "Recording with parec started: $recording_dir/$note_filename (PID: $pid)"
    notify-send -t 2000 "Audio note recording started ..."
  elif [ $use_arecord -eq 1 ]; then
    # Basic microphone recording to MP3
    #$ARECORD -f cd -t raw | $LAME -r -V2 - $recording_dir/$note_filename
    
    # Voice recording optimized for speech
    $ARECORD -f S16_LE -c1 -r22050 -t raw | $LAME -r -s 22.05 -m m -b 64 - $recording_dir/$note_filename &
    local pid=$(pgrep -n -x arecord)
    echo $pid > "$PIDFILE"
    echo "Recording with arecord started: $recording_dir/$note_filename (PID: $pid)"
    logger -t record audio "Recording with arecord started: $recording_dir/$note_filename (PID: $pid)"
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

