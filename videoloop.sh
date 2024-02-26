#!/usr/bin/env bash

# Video (replace with the path and file name of your video)
video_paths=(~/Videobox/ ~/Video ~/Videos ~/Video\'s)

echo "Using files in the following folders: ${video_paths[@]}"

# Start displaying the video loop
case "$1" in
    start) # Start displaying the video loop
        mpv --fs --loop-playlist=inf --ontop --no-resume-playback ${video_paths[@]}
        echo "Video Playback Started"
    ;;

    stop) # Stop displaying video loop 
        sudo killall mpv
        echo "Video Playback Stopped"
    ;;

    repair) # Restart video loop if it died
        if !(ps -a | grep omx -q)
        then
        sudo killall mpv
        mpv --fs --loop-playlist=inf --ontop --no-resume-playback ${video_paths[@]}
        echo "The Video is now running"
        fi
    ;;

    *)
        echo "Usage: /boot/firmware/videoloop {start|stop|repair}"
        exit 1
    ;;
esac
