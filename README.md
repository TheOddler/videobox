# Video box

Some scripts for a simple raspberry pi video box.

## Usage

1. Install raspbian on an sd card
2. Copy all files to the boot partition on the sd card
3. Start the pi with the sd card
   - Make sure it is connected to the internet
4. Log in
5. Run `sudo /boot/firmware/setup.sh`
   - Maybe you'll have to set permissions: `sudo chmod +x /boot/firmware/setup.sh`
   - Enter a samba password when asked
   - This can take a while...
6. Shutdown the pi `sudo shutdown now`
7. Insert the sd card back into your own computer, and place videos in the **rootfs**'s Videos folder.
   - If you're on mac you'll need to install some extFS for Mac so you can read the linux partitions: https://www.paragon-software.com/home/extfs-mac/#
8. Put sd card back into the pi and start

Now on boot the pi will play the videos.

# Enable headless SSH and WiFi

1. Create an empty file called `ssh` in the boot directory
2. Create a file called `wpa_supplicant.conf` in the boot directory with content:
   ```
   country=BE
   ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
   update_config=1
   network={
       ssid="WIFI NETWORK NAME"
       psk="WIFI PASSWORD"
   }
   ```

# sudo: unable to execute ./setup.sh: No such file or directory

Make sure the line-endings of the files are `LF` so Linux understands them.
