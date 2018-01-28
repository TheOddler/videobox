#!/bin/bash

if read -r -s -n 1 -t 10 -p "Starting video in 10 seconds. Press enter to abort." key
then
    echo ""
    echo "Aborted."
else
    echo ""
    echo "Starting video..."
    /boot/videoloop.sh start
    echo "Done."
fi
