#!/bin/bash 
#-vx

TARGET_VCODEC='libx264'
TARGET_ACODEC='aac'
OUTPUT_FORMAT="-hide_banner -c:a $TARGET_ACODEC -c:v $TARGET_VCODEC -ac 2 -ar 48000\
              -r 30 -strict -2 -s 1280x720 -profile:v high422 -pix_fmt yuvj422p -video_track_timescale 60000 -y"

which ffprobe > /dev/null || (echo "Lack of 'ffprobe'. Install it";exit)
which ffmpeg > /dev/null || (echo "Lack of 'ffmpeg'. Install it";exit)
stat Verdana.ttf &>> /dev/null || (echo "Lack of Verdana.ttf in the same folder.";exit)

if [[ ! -e out ]];then
  echo 'Creating out directiory'
  mkdir out
fi

function get_file_creation_seconds() {
  local TZ=""
  time=`ffprobe $1 2>&1 | grep creation_time -m1 | cut -d : -f 2- | cut -d' ' -f 2-`
  if [[ -z $time ]]; then
    time=`stat -c %y $i`
  else
    if [[ ${time:26:1} -eq 'Z' ]]; then
      time=${time::-1}
    fi
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
  ffmpeg -i $1\
    -vf "setdar=16:9,drawtext=fontfile=Verdana.ttf:fontsize=20:expansion=normal:text='%{pts\\:localtime\\:$seconds}':r=30:x=(w-tw)-40:y=h-(2*lh):fontcolor=white:box=1:boxcolor=0x000000@1"\
    $OUTPUT_FORMAT out/$filename.mp4 &>>log
}

function convert_avi_to_mp4() {
  local filename=`basename $1`
  local extension="${filename##*.}"
  filename="${filename%.*}"

  get_file_creation_seconds $1
  filename=$time"_${filename%.*}"

  echo "Recoding file $1 - start at $seconds" &>>log
  ffmpeg -i $1\
    -vf "setdar=16:9,drawtext=fontfile=Verdana.ttf:fontsize=20:expansion=normal:text='%{pts\\:localtime\\:$seconds}':r=30:x=(w-tw)-40:y=h-(2*lh):fontcolor=white:box=1:boxcolor=0x000000@1"\
    $OUTPUT_FORMAT out/$filename.mp4 &>>log
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
    $OUTPUT_FORMAT out/$filename &>>log
}

mov_files=(`find -P . -maxdepth 1 -xdev -iname '*.MOV' -o -iname '*.MTS' | sort`)
avi_files=(`find -P . -maxdepth 1 -xdev -iname '*.AVI' | sort`)
movie_files=(`find -P . -maxdepth 1 -xdev -iname '*.MP4' | sort`)

index=1
files_count=${#movie_files[@]}
echo "" > log
echo "Adding timestamp to MP4 movies"
for i in "${movie_files[@]}"
do
  echo -ne " [$index/$files_count] Processing file $i\r"
  add_timestamp $i
  ((index++))
done
echo ""

if [[ ${#avi_files[@]} -gt 0 ]]; then
  echo
  echo "Converting AVI files to MP4"
  index=1
  files_count=${#avi_files[@]}
  for i in  "${avi_files[@]}"
  do
    echo -ne " [$index/$files_count] Converting file $i\r"
    convert_avi_to_mp4 $i 
    ((index++))
  done
fi

if [[ ${#mov_files[@]} -gt 0 ]]; then
  echo ""
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
