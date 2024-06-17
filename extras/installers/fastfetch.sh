#!/bin/bash
if [ $(id -u) -ne 0]; then
	echo "Please run as root"
	exit
fi

wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.15.0/fastfetch-linux-amd64.deb
sudo apt install ./fastfetch-linux-amd64.deb
sudo rm ./fastfetch-linux-amd64.deb
