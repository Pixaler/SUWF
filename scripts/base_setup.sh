##!/bin/bash
#
# Update system
## Remove Ubuntu Pro ads
sudo rm /etc/apt/apt.conf.d/20apt-esm-hook.conf

## Update system 
sudo apt update && sudo apt dist-upgrade -y
sudo reboot

# Disk
sudo apt install ntfs-3g
echo "/dev/sda1 /mnt/storage ntfs-3g nosuid,nodev,nofail,x-gvfs-show 0 0" | sudo tee -a /etc/fstab

