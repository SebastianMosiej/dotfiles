import glob
import os
import subprocess
import time
# import progressbar

# get all movie files from current folder
# get creation timestamop from file
# trigger conversion

OUTPUT_DIRECTORY = "out"
FILES_TO_CONCATE_LIST = "mylist.txt"
TARGET_VCODEC = 'libx264'
TARGET_ACODEC = 'aac'
OUTPUT_FORMAT = "-hide_banner -c:a $TARGET_ACODEC -c:v $TARGET_VCODEC -ac 2 -ar 48000\
              -r 30 -strict -2 -s 1280x720 -profile:v high422 -pix_fmt yuvj422p -video_track_timescale 60000 -y"
OUTPUT_FORMAT1 = "-hide_banner -c:a aac -c:v libx264 -ac 2 -ar 48000\
              -r 30 -strict -2 -s 1280x720 -profile:v high422 -pix_fmt yuvj422p -video_track_timescale 60000 -y"
BRIGHTNESS = ""
# BRIGHTNESS1 = ", eq=brightness=0.20"
TIME_CORRECTIONS = ""


def get_time_creation(file_path):
    CREATION_PATTERN = "creation_time"
    p = subprocess.run(["ffprobe", file_path], capture_output=True)
    file_metadata = str(p.stderr).split("\\r\\n")
    creation_timestamp = None
    for line in file_metadata:
        pos = line.find(CREATION_PATTERN)
        if pos != -1:
            pattern = line[pos+len(CREATION_PATTERN):]
            pass
    if creation_timestamp is None:
        creation_timestamp = os.path.getmtime(file_path)
        str_modified = time.ctime(os.path.getmtime(file_path))

    return creation_timestamp


def add_timestamp_to_mts(file_path):
    FFPROBE_PATTERN = "rotate"
    creation_timestamp = get_time_creation(file_path)
    output_dir, ext = os.path.split(file_path)
    output_dir = os.path.join(output_dir, OUTPUT_DIRECTORY)
    file_name, ext = os.path.splitext(os.path.basename(file_path))
    # test for rotation
    p = subprocess.run(["ffprobe", file_path], capture_output=True)
    file_metadata = str(p.stderr).split("\\r\\n")
    rotation = None
    ROTATE = ""
    for line in file_metadata:
        pos = line.find(FFPROBE_PATTERN)
        if pos != -1:
            pattern = line[pos+len(FFPROBE_PATTERN):]
            pass
    try:
        os.makedirs(output_dir)
    except FileExistsError:
        pass
    output_filename = os.path.join(output_dir, file_name+".mp4")
    call = "ffmpeg -i \""+file_path+"\" "+BRIGHTNESS+" -vf "+ROTATE+" drawtext=fontfile=Verdana.ttf:fontsize=40:expansion=normal"
    call += ":text='%{pts\\:localtime\\:"+str(creation_timestamp)+"}':r=30:x=(w-tw)-40:y=h-(2*lh):fontcolor=white:box=1:"
    # call += "boxcolor=0x000000@1"+BRIGHTNESS+" "+OUTPUT_FORMAT1+" "+out\\"+file_name+".mp4 &>>log"
    call += "boxcolor=0x000000@1"+BRIGHTNESS+" "+OUTPUT_FORMAT1+" \""+output_filename+"\""
            # +" &>>log"
    # p = subprocess.run(["ffmpeg -i"+file_path+BRIGHTNESS+" -vf "+ROTATE+" drawtext=fontfile=Verdana.ttf:fontsize=40:expansion=normal"+
    # ":text='%{pts\\:localtime\\:"+creation_timestamp+"}':r=30:x=(w-tw)-40:y=h-(2*lh):fontcolor=white:box=1:"+
    #                     "boxcolor=0x000000@1$BRIGHTNESS1"+OUTPUT_FORMAT+" out/$"+file_name"+.mp4 &>>log", capture_output=True)
    p = subprocess.run(call, capture_output=True)
    if p.returncode != 0:
        print("Error during file recoding")
    output = str(p.stderr).split("\\r\\n")


def add_timestamp_to_file(file_path):
    creation_time = get_time_creation(file_path)
    pass


def process():
    file_list = glob.glob("*.mov")
    for file in file_list:
        add_timestamp_to_file(file_list)
    file_list = glob.glob("*.mts")
    print("Found {} MTS files".format(len(file_list)))
    # bar = progressbar.SimpleProgress()
    count = 1
    for file in file_list:
        file_name = os.path.basename(file)
        printProgress(count, len(file_list), file_name)
        # print("\r[{}/{}] Processing file '{}'".format(count, len(file_list), file_name))
        add_timestamp_to_mts(file)
        count+=1

    file_list = glob.glob("*.avi")
    print("Found {} AVI files".format(len(file_list)))
    # bar = progressbar.SimpleProgress()
    count = 1
    for file in file_list:
        file_name = os.path.basename(file)
        printProgress(count, len(file_list), file_name)
        # print("\r[{}/{}] Processing file '{}'".format(count, len(file_list), file_name))
        add_timestamp_to_mts(file)
        count+=1

def concate_clips():
    print("Concating movie files")
    file_list = glob.glob(os.path.join(OUTPUT_DIRECTORY, "*.mp4"))
    file_list.sort()
    with open(os.path.join(OUTPUT_DIRECTORY, FILES_TO_CONCATE_LIST), 'w') as f:
        for file in file_list:
            file = file[len(OUTPUT_DIRECTORY)+1:]
            f.write(f"file '{file}'\n")
    os.chdir(OUTPUT_DIRECTORY)
    call = f"ffmpeg -f concat -i {FILES_TO_CONCATE_LIST} -c copy detektyw.mp4"
    p = subprocess.run(call, capture_output=True)
    if p.returncode != 0:
        print("Error during file concating")
    output = str(p.stderr).split("\\r\\n")
    os.chdir("..")


def printProgress(iteration, total, suffix=''):
    format_str = "'\r[{:0"+str(len(str(total)))+"d}/{}] Processing '{}'"
    print(format_str.format(iteration, total, suffix), end='')
    # Print New Line on Complete
    if iteration == total:
        print()

if __name__ == "__main__":
    print("Will process all movie files")
    process()
    concate_clips()
