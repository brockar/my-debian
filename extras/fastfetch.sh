#/bin/bash
if [ $(id -u) -ne 0]; then
	echo "Please run as root"
	exit
fi

wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.8.3/fastfetch-linux-x86_64.deb
sudo apt install ./fastfetch-linux-x86_64.deb

sudo rm ./fastfetch-linux-x86_64.deb
