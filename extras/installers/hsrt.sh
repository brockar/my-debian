#!/bin/bash
# https://github.com/dvorka/hstr?tab=readme-ov-file
#Check if user is root
if [ $(id -u) -ne 0 ]; then
	echo "Please run as root"
	exit
fi
sudo apt install hstr
hstr --show-configuration >>~/.bashrc
