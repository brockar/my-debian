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
sudo nala install gnome-software-plugin-flatpak -y
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
	sudo nala remove gnome-games -y
	##gnome software
	sudo nala remove gnome-sound-recorder gnome-text-editor gnome-maps shotwell sane-airscan evolution rhythmbox transmission totem gnome-music -y #transmission-gtk transmission-common
	sudo nala autoremove -y
fi

#############################################################################################################
### Install Apps
sudo nala update && sudo nala upgrade -y

for pkg in wget gpg curl rclone thunderbird zoxide trash-cli preload timeshift gparted gnome-shell-extension-manager htop btop tree tldr helvum; do
	sudo nala install $pkg -y
done

flatpak install flathub md.obsidian.Obsidian com.discordapp.Discord com.prusa3d.PrusaSlicer io.github.vikdevelop.SaveDesktop com.rtosta.zapzap org.videolan.VLC -y

## Firefox
$dir/extras/installers/firefox-deb.sh
## Brave
$dir/extras/installers/brave.sh
## Vs Code
$dir/extras/installers/code.sh
## NVIM
$dir/extras/installers/nvim.sh

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

## Docker
echo -e "\n\n\nInstall Docker?\n\n1. YES \n2. NO [Default]\n"
read respuesta
if [ "$respuesta" -eq 1 ]; then
	$dir/extras/installers/docker.sh
fi

#############################################################################################################
### PERSONALIZATION

## CTT Script
#git clone https://github.com/ChrisTitusTech/debian-titus
$dir/debian-titus/install.sh
$dir/debian-titus/mybash/setup.sh
$dir/debian-titus/scripts/usenala

## Grub Theme
echo "Install Grub Theme"
echo "=================================="
echo "My favorite is VIMIX, choose one"
echo "=================================="
#git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes
cd $dir/Top-5-Bootloader-Themes
sudo ./install.sh

$dir/extras/installers/adw-gtk3.sh
$dir/extras/installers/gnome-cust.sh
#############################################################################################################
echo -e "\n\n\nFinished script"
echo "======================"
echo "Reboot your system"
#############################################################################################################
