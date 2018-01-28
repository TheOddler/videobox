# Video box

Some scripts for a simple raspberry pi video box.

## Usage

1. Install raspbian on an sd card
2. Copy all files to the boot partition on the sd card
3. Start the pi with the sd card
    * Make sure it is connected to the internet
4. Log in
5. Run `sudo /boot/setup.sh`
    * Wait for it to finish
    * Enter a samba password when asked
6. Now on the network the pi should show up, place your video in the /share/Video folder

Now on boot the pi will play the video.
