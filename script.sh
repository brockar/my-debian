#!/bin/bash

#Check if user is root
if [ $(id -u) -ne 0 ]; then
	echo "Please run as root"
	exit
fi
#vars
usr=$(id -u -n 1000)
dir=$(pwd)
home=/home/$usr

# Update and Upgrade
sudo apt update && sudo apt upgrade -y
## Put your user as sudo
sudo usermod -aG sudo $usr
## Install Nala and Git
sudo apt install nala git -y

## nala fetch source lists
#sudo nala fetch
#############################################################################################################
## Install System apps
# Flatpak
# sudo nala install flatpak -y (not necesary)
# If the shell is gnome
if [ $XDG_CURRENT_DESKTOP == "GNOME" ]; then
	sudo nala install gnome-software-plugin-flatpak -y
elif [ $XDG_CURRENT_DESKTOP == "KDE" ]; then
	sudo nala install plasma-discover-backend-flatpak -y
else
	echo -e "\n\n\nIt isn't gnome or kde"
fi
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#############################################################################################################
### CLEAN
echo -e "\n\n\nRemove some default apps and games?\n\n1. YES [Default]\\n2. NO \n"
read respuesta
if [ "$respuesta" -eq 2 ]; then
	echo "no app is being removed. xd"
else
	echo "Removing apps..."
	##games
	#sudo nala remove gnome-mines gnome-robots gnome-sudoku gnome-taquin gnome-tetravex chees egnome-2048 gnome-klotski gnome-mahjongg gnome-nibbles gnome-chess swell-foop tali five-or-more four-in-a-row aisleriot hitori lightsoff quadrapassel -y
	sudo nala remove gnome-games -y
	##gnome software
	sudo nala remove gnome-sound-recorder gnome-text-editor gnome-maps shotwell sane-airscan evolution rhythmbox transmission-common transmission transmission-gtk totem gnome-music -y
	sudo nala autoremove -y
fi

#############################################################################################################
### Install Apps
sudo nala update && sudo nala upgrade -y
#doesn't work well
sudo nala install wget gpg curl rclone thunderbird zoxide trash-cli preload timeshift gparted gnome-shell-extension-manager htop btop tree tldr audacity helvum -y
flatpak install flathub md.obsidian.Obsidian com.discordapp.Discord com.prusa3d.PrusaSlicer io.github.vikdevelop.SaveDesktop com.rtosta.zapzap org.videolan.VLC -y

## Vs Code
$dir/extras/installers/code.sh

## Firefox
$dir/extras/installers/firefox-deb.sh

## Brave
$dir/extras/installers/brave.sh

## QEMU and KVM
echo -e "\n\n\nInstall QEMU? \n\n1. YES \n2. NO [Default]"
read respuesta
if [ "$respuesta" -eq 1 ]; then
	echo "\nInstalling QEMU..."
	sudo nala install qemu-kvm virt-manager virtinst spice-vdagent libvirt-clients bridge-utils libvirt-daemon-system -y
	sudo systemctl enable --now libvirtd
	sudo systemctl start libvirtd

	sudo usermod -aG kvm $usr
	sudo usermod -aG libvirt $usr
fi

## NVIM
$dir/extras/installers/nvim.sh

#############################################################################################################
## Docker
echo -e "\n\n\nInstall Docker?\n\n1. YES \n2. NO [Default]\n"
read respuesta
if [ "$respuesta" -eq 1 ]; then
	$dir/extras/installers/docker/docker.sh
fi
#############################################################################################################
## CTT Script
#git clone https://github.com/ChrisTitusTech/debian-titus
$dir/debian-titus/install.sh
$dir/debian-titus/mybash/setup.sh
$dir/debian-titus/scripts/usenala
#############################################################################################################
## Grub Theme
echo "Install Grub Theme"
echo "=================================="
echo "My favorite is VIMIX, choose one"
echo "=================================="

#git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes
cd $dir/Top-5-Bootloader-Themes
sudo ./install.sh

#############################################################################################################

echo -e "\n\n\nFinished script"
echo "======================"
echo "Reboot your system"

#############################################################################################################
