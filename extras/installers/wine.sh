#!/bin/bash
#Check if user is root
if [ $(id -u) -ne 0 ]; then
	echo "Please run as root"
	exit
fi
## WINE
# dpkg --print-architecture
# dpkg --print-foreign-architectures
# si devuelve i386 esta bien, si no, ejecutar
# dpkg --add-architecture i386
# wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
# wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
# apt install --install-recommends winehq-stable
