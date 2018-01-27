#!/bin/bash
### BEGIN INIT INFO
# Provides: omxplayer
# Required-Start:
# Required-Stop:
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Displays video file in a loop using omxplayer
# Description:
### END INIT INFO

# Video (replace with the path and file name of your video)
video_path="/home/pi/share/Video/$(ls /home/pi/share/Video/ | head -n 1)"

# Start displaying the video loop
case "$1" in
    start) # Start displaying the video loop 
        omxplayer -o both "$video_path" -b --loop --no-osd
        echo "Video Playback Started"
    ;;

    stop) # Stop displaying video loop 
        sudo killall omxplayer.bin
        echo "Video Playback Stopped"
    ;;

    repair) # Restart video loop if it died
        if !(ps -a | grep omx -q)
        then
        sudo killall omxplayer.bin
        omxplayer -o both "$video_path" -b --loop --no-osd
        echo "The Video is now running"
        fi
    ;;

    *)
        echo "Usage: /etc/init.d/videoloop {start|stop|repair}"
        exit 1
    ;;
esac
