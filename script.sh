#!/bin/bash

#Check if user is root
if [ $(id -u) -ne 0 ]; then
	echo "Please run as root"
	exit
fi
usr=$(id -u -n 1000)
dir=$(pwd)

# Update and Upgrade
sudo apt update && sudo apt upgrade -y
## Put your user as sudo
sudo usermod -aG sudo $usr
## Install Nala and Git
sudo apt install nala git -y

## nala fetch source lists
sudo nala fetch
#############################################################################################################
## Grub Theme
echo "Install Grub Theme"
echo "=================================="
echo "My favorite is VIMIX, choose one"
echo "=================================="

#git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes
cd Top-5-Bootloader-Themes
sudo ./install.sh
cd $dir
#############################################################################################################
## Install System apps
# Flatpak
sudo apt install flatpak -y
# If the shell is gnome
if [ $XDG_CURRENT_DESKTOP == "GNOME" ]; then
	apt install gnome-software-plugin-flatpak -y
elif [ $XDG_CURRENT_DESKTOP == "KDE" ]; then
	apt install plasma-discover-backend-flatpak -y
else
	echo -e "\n\n\nIt isn't gnome or kde"
fi
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
#############################################################################################################
### Install Apps
sudo nala install htop wget gpg rclone thunderbird zoxide trash-cli preload timeshift gparted -y
flatpak install flathub md.obsidian.Obsidian com.discordapp.Discord com.prusa3d.PrusaSlicer -y

## VS Code
sudo apt-get install wget gpg curl
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

## Firefox
sudo nala purge firefox-esr* -y
flatpak install org.mozilla.firefox -y

## Brave
nala install apt-transport-https curl -y
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list
nala update
nala install brave-browser -y

## QEMU and KVM
echo -e "\n\n\nInstall QEMU? \n\n1. YES \n2. NO"
read respuesta
if [ "$respuesta" -eq 1 ]; then
	echo "\nInstalling QEMU..."
	sudo nala install qemu-kvm virt-manager virtinst spice-vdagent libvirt-clients bridge-utils libvirt-daemon-system -y
	sudo systemctl enable --now libvirtd
	sudo systemctl start libvirtd

	sudo usermod -aG kvm $usr
	sudo usermod -aG libvirt $usr
fi

# https://www.youtube.com/watch?v=vYQ9Bkv7VG4
# Create volumes with phisical disk
# sudo fdisk -l
# To view volumes and create a partition
# sudo pvcreate /dev/sdXX
# XX is the volume to do a phisical volume(?

#############################################################################################################
### CLEAN
echo -e "\n\n\nRemove some default apps and games?\n\n1. YES \n2. NO\n"
read respuesta
if [ "$respuesta" -eq 1 ]; then
	echo "Removing apps..."
	#games
	sudo nala remove gnome-mines gnome-robots gnome-sudoku gnome-taquin gnome-tetravex gnome-2048 gnome-klotski gnome-mahjongg gnome-nibbles gnome-chess swell-foop tali five-or-more four-in-a-row aisleriot hitori lightsoff quadrapassel -y
	#gnome software
	sudo nala remove gnome-sound-recorder gnome-text-editor gnome-maps shotwell sane-airscan cheese evolution rhythmbox -y

else
	echo "no app is being removed. xd"
fi

#############################################################################################################
## NVIM
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo ln -s $dir/nvim.appimage /usr/local/bin/nvim

# ## LazyVIM
# # required
mv ~/.config/nvim{,.bak}
# # optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
## Clipboard for lazyVim
sudo nala install xclip -y
## Lazy git
cd $dir
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

#############################################################################################################
## Docker
echo -e "\n\n\nInstall Docker?\n\n1. YES \n2. NO\n"
read respuesta
if [ "$respuesta" -eq 1 ]; then
	sudo bash ./extras/docker.sh
fi
#############################################################################################################
## Download CTT Script
#git clone https://github.com/ChrisTitusTech/debian-titus
cd debian-titus
sudo bash ./install.sh

cd $dir
cd debian-titus/mybash/
sudo bash ./setup.sh
#############################################################################################################
echo -e "\n\n\nFinished script"
echo "======================"
echo "Reboot your system"

#############################################################################################################
## TO DO
# Si es laptop no instalar preload timeshift ni QEMU e instalar tlp.
# echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile
# Poner scripts opcionales (nvidia, tlp (notebook), etc)
#
# Animated Wallpaper
# wget https://github.com/cheesecakeufo/komorebi/releases/download/v2.1/komorebi-2.1-64-bit.deb
# sudo apt install komorebi*.deb

##################################################
# Sing in on vs code
# Sign in on obsidian
# Sign in on rclone Google Drive and One Drive
# Tweaks:
# 	-Cursor -Icons -Themes -Fonts
