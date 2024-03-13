#!/bin/bash
#Check if user is root
if [ $(id -u) -ne 0 ]; then
	echo "Please run as root"
	exit
fi
usr=$(id -u -n 1000)
dir=$(pwd)

sudo nala tlp -y
sudo nala purge thimeshift -y
# Install Battery Health Charging extension
