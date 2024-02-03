#!/bin/bash

# Helpful links:
#    raspi-config source: https://github.com/RPi-Distro/raspi-config

# Privilidges required
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

# Updates
echo "Updating aptget..."
apt-get -q -y update

# Install vlc
echo "Installing vlc..."
apt-get -q -y install vlc

# Enable autologin to CLI
echo "Enabling autologin..."
raspi-config nonint do_boot_behaviour B2 # B2 is CLI automatic login

# Make sure startup_script is run at login
echo "Setting startup_script to run at login..."
if grep -Fq "/boot/startup_script.sh" /home/pi/.bashrc
then
	echo "Startup script already running at login."
else
	sudo bash -c 'cat <<-EOT >> /home/pi/.bashrc

	/boot/startup_script.sh
	EOT'
fi

# Updating permissions
echo "Updating permissions..."
chmod 755 "/boot/startup_script.sh"
chmod 755 "/boot/videoloop.sh"

# Done
echo "Done :D"
echo ""
echo "IP info: (sudo ip addr show)"
ip addr show
echo ""
echo "Now you can add a video to the share/Video folder."
echo "Then restart the pi to start playing the video (sudo reboot)."
