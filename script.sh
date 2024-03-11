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
sudo nala install flatpak -y
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
### Install Apps
sudo nala update && sudo nala upgrade
sudo nala install htop wget gpg rclone thunderbird zoxide trash-cli preload timeshift gparted helvum gnome-shell-extension-manager btop tree tldr audacity -y

flatpak install flathub md.obsidian.Obsidian com.discordapp.Discord com.prusa3d.PrusaSlicer io.github.vikdevelop.SaveDesktop com.rtosta.zapzap org.videolan.VLC -y

## VS Code
sudo nala install wget gpg curl
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo nala install apt-transport-https
sudo nala update
sudo nala install code

## Firefox
sudo nala purge firefox-esr* -y
sudo bash $dir/extras/installers/firefox-deb.sh

## Brave
nala install apt-transport-https curl -y
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list
nala update
nala install brave-browser -y

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

# https://www.youtube.com/watch?v=vYQ9Bkv7VG4
# Create volumes with phisical disk
# sudo fdisk -l
# To view volumes and create a partition
# sudo pvcreate /dev/sdXX
# XX is the volume to do a phisical volume(?

## WINE
# dpkg --print-architecture
# dpkg --print-foreign-architectures
# si devuelve i386 esta bien, si no, ejecutar
# dpkg --add-architecture i386
# wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
# wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
# apt install --install-recommends winehq-stable

#############################################################################################################
### CLEAN
echo -e "\n\n\nRemove some default apps and games?\n\n1. YES \n2. NO [Default]\n"
read respuesta
if [ "$respuesta" -eq 1 ]; then
	echo "Removing apps..."
	#games
	#sudo nala remove gnome-mines gnome-robots gnome-sudoku gnome-taquin gnome-tetravex gnome-2048 gnome-klotski gnome-mahjongg gnome-nibbles gnome-chess swell-foop tali five-or-more four-in-a-row aisleriot hitori lightsoff quadrapassel -y
	sudo nala remove gnome-games gnome-games-support gnome-games-support-cor
	sudo nala autoremove
	#gnome software
	sudo nala remove gnome-sound-recorder gnome-text-editor gnome-maps shotwell sane-airscan cheese evolution rhythmbox transmission-common transmission-gtk totem gnome-music -y
else
	echo "no app is being removed. xd"
fi

#############################################################################################################
## NVIM
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
#sudo ln -s $dir/nvim.appimage /usr/local/bin/nvim
sudo mv $dir/nvim.appimage /usr/local/bin/nvim

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
echo -e "\n\n\nInstall Docker?\n\n1. YES \n2. NO [Default]\n"
read respuesta
if [ "$respuesta" -eq 1 ]; then
	sudo bash $dir/extras/installers/docker/docker.sh
fi
#############################################################################################################
## Download CTT Script
#git clone https://github.com/ChrisTitusTech/debian-titus
sudo bash $dir/debian-titus/install.sh
sudo bash $dir/debian-titus/mybash/setup.sh
sudo bash $dir/debian-titus/scripts/usenala
#############################################################################################################
echo -e "\n\n\nFinished script"
echo "======================"
echo "Reboot your system"

#############################################################################################################
