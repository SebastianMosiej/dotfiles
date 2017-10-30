#!/bin/bash 
#-vx

TARGET_VCODEC='libx264'
TARGET_ACODEC='aac'

TIMESTAMP_FORMAT="drawtext=fontfile=Verdana.ttf:fontsize=20:expansion=normal:text='%{pts\\:gmtime\\:$seconds}':r=30:x=(w-tw)-40:y=h-(2*lh):fontcolor=white:box=1:boxcolor=0x000000@1"

which ffprobe > /dev/null || (echo "Lack of 'ffprobe'. Install it";exit)
which ffmpeg > /dev/null || (echo "Lack of 'ffmpeg'. Install it";exit)

if [[ ! -e out ]];then
  echo 'Creating out directiory'
  mkdir out
fi

function get_file_vcodec() {
  vcodec=`ffprobe -v error -select_streams v:0 -show_entries stream=codec_name \
    -of default=noprint_wrappers=1:nokey=1 $1`
}
function get_file_creation_seconds() {
  local TZ=""
  time=`ffprobe $1 2>&1 | grep creation_time -m1 | cut -d : -f 2- | cut -d' ' -f 2-`
  if [[ -z $time ]]; then
    time=`stat -c %y $i`
  else
    TZ="GMT"
  fi
  seconds=`date -d "$time $TZ" +%s`
  time=`date -d"$time $TZ" +'%Y-%m-%d_%H:%M:%S' | tr ":-" "__"`
}

function convert_mov_to_mp4() {
  local filename=`basename $1`
  local extension="${filename##*.}"
  filename="${filename%.*}"

  get_file_creation_seconds $1
  filename=$time"_${filename%.*}"

  echo "Recoding file $1 - start at $seconds" &>>log
  ffmpeg -i $1 -acodec $TARGET_ACODEC -vcodec $TARGET_VCODEC\
    -vf "scale=1280:720,setdar=16:9,drawtext=fontfile=Verdana.ttf:fontsize=20:expansion=normal:text='%{pts\\:localtime\\:$seconds}':r=30:x=(w-tw)-40:y=h-(2*lh):fontcolor=white:box=1:boxcolor=0x000000@1"\
    -r 25 -y -strict experimental out/$filename.mp4 &>>log
    #-vf "scale=1280:720,setdar=16:9" \
}


function add_timestamp(){
  local file=$1
  get_file_creation_seconds $file
  local filename=`basename $1`
  filename=$time"_$filename"

  #PTS
  # arg 1 -> format -> flt, hms, gmtime, localtime
  # arg 2 -> offset added to pts time

  echo "Adding timestamp $1" &>>log
  ffmpeg -i $file\
    -vf "drawtext=fontfile=Verdana.ttf:fontsize=20:expansion=normal:text='%{pts\\:localtime\\:$seconds}':r=30:x=(w-tw)-40:y=h-(2*lh):fontcolor=white:box=1:boxcolor=0x000000@1"\
    -strict -2 -y out/$filename &>>log
}

mov_files=(`find -P . -maxdepth 1 -xdev \
  -iname '*.MOV' -o -iname '*.MTS' -o -iname '*.AVI' | sort`)
movie_files=(`find -P . -maxdepth 1 -xdev -iname '*.MP4' | sort`)

index=1
files_count=${#movie_files[@]}
echo "" > log
for i in "${movie_files[@]}"
do
  echo -ne " [$index/$files_count] Processing file $i\r"
  add_timestamp $i
  ((index++))
done

if [[ ${#mov_files[@]} -gt 0 ]]; then
  echo "Converting MOV file to MP4"
  index=1
  files_count=${#mov_files[@]}
  for i in  "${mov_files[@]}"
  do
  echo -ne " [$index/$files_count] Converting file $i\r"
    convert_mov_to_mp4 $i 
    ((index++))
  done
fi
echo -e "\nCompleted"

