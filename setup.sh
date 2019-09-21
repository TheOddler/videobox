#!/bin/bash

# Helpful links:
#    raspi-config source: https://github.com/RPi-Distro/raspi-config

# Privilidges required
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

# Enable ssh
echo "Enabling ssh..."
raspi-config nonint do_ssh 0 # 0 = enable

# Expand filesystem so it uses the whole sd card
echo "Expanding filesystem..."
raspi-config nonint do_expand_rootfs

# Updates
echo "Updating aptget..."
apt-get -q -y update
apt-get -q -y dist-upgrade

# Install omxplayer
echo "Installing omxplayer..."
apt-get -q -y install omxplayer

# Install samba
echo "Installing samba..."
apt-get -q -y install samba samba-common-bin
mkdir -p -m 1777 /home/pi/share/Video
echo "Setting up share..."
if grep -Fxq "[share]" /etc/samba/smb.conf
then
	echo "Share already setup."
else
	cat <<-EOT >> /etc/samba/smb.conf

	[share]
	Comment = Pi shared folder
	Path = /home/pi/share
	Browseable = yes
	Writeable = Yes
	only guest = no
	create mask = 0777
	directory mask = 0777
	Public = yes
	Guest ok = yes
	EOT
fi
echo "Please enter a password for the samba share:"
until smbpasswd -a pi
do
	echo "Try again please (press ctrl+c twice fast to skip)."
	sleep 1
done
echo "Ok, restarting samba..."
/etc/init.d/samba restart

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
