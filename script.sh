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
# TO DO - No anda
## Put your user as sudo
sudo usermod -aG sudo $usr

## Install Nala and Git
sudo apt install nala -y
sudo nala install git -y

#############################################################################################################
## Grub Theme
echo "Installing Grub Theme"
echo "===================="
echo "Select VIMIX"
echo "===================="

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
	echo "It isn't gnome or kde"
fi
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#############################################################################################################
## Install Apps
sudo nala install htop wget gpg rclone thunderbird zoxide trash-cli preload timeshift gparted -y

flatpak install flathub md.obsidian.Obsidian com.discordapp.Discord com.prusa3d.PrusaSlicer -y
#org.vim.Vim io.neovim.nvim

# VS Code
sudo apt-get install wget gpg curl
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https
sudo apt update
sudo apt install code

# Firefox
sudo nala purge firefox-esr* -y
flatpak install org.mozilla.firefox -y

#############################################################################################################
## QEMU and KVM
echo -e "Install QEMU? \n\n1. YES \n2. NO"
read respuesta

if [ "$respuesta" -eq 1 ]; then
	echo "Installing QEMU..."
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
## DOCKER and Docker Desktop
# Docker Engine
# for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
# Add Docker's official GPG key:
# sudo apt-get update
# sudo apt-get install ca-certificates curl gnupg
# sudo install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
# echo \
#   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#   "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update
# sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Docker compose
# curl -SL https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
# sudo useradd $USER -G sudo
# sudo usermod -a -G docker $USER

# Docker Desktop
# sudo usermod -aG kvm $USER
# sudo apt remove docker-desktop
# rm -r $HOME/.docker/desktop
# sudo rm /usr/local/bin/com.docker.cli
# sudo apt purge docker-desktop
# sudo apt install gnome-terminal
# wget -qO- https://desktop.docker.com/linux/main/amd64/docker-desktop-4.26.1-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64&_gl=1*1dgg7ch*_ga*MjY5MTE2MjYxLjE3MDI3NDcwNzk.*_ga_XJWPQMJYHQ*MTcwMjc0NzA3OS4xLjEuMTcwMjc1MjI1Mi4zMC4wLjA.
# sudo apt-get install ./docker-desktop-*.deb

# Look this line / how to improve
#
#
#

# To move docker volumes to another disks
# service docker stop
# sudo nvim /lib/systemd/system/docker.service
# in Exec add
# --data-root=/path/to/move
# rsync -aP /var/lib/docker/ /new/PATH
# mv /var/lib/docker /var/lib/docker.old
# ln -s /new/path /var/lib/docker
# service docker start
# docker run --rm hello-world
# rm -rf /var/lib/docker.old

# https://stackoverflow.com/questions/59345566/move-docker-volume-to-different-partition

#############################################################################################################
## CLEAN
echo -e "Remove some default apps and games?\n\n1. YES \n2. NO\n"
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
# sudo nala fetch
sudo cp /etc/apt/sources.list.d/nala-sources.list /etc/apt/sources.list.d/nala-sources.list.bak
rm /etc/apt/sources.list.d/nala-sources.list
sudo cp $dir/extras/nala-sources.list /etc/apt/sources.list.d/nala-sources.list

#############################################################################################################
## To do later
# Sing in on vs code
# Sign in on obsidian
# Sign in on rclone Google Drive and One Drive
# add crontab -e

# Tweaks > Cursor > Icons
#"Terminal > Preferences > Text > Custom font > MesloLGS Nerd Font"

# Poner cosas de vm (vm-tools, etc).

##
## RCLONE
# gcloud as copy / sync (it takes some time the first backup)
# onedrive as mount (dont copy all files on machine)
#sudo cp $dir/service/rclonegcloud.service /etc/systemd/system/rclonegcloud.service
#sudo cp $dir/service/rcloneonedrive.service /etc/systemd/system/rcloneonedrive.service

#sudo systemctl daemon-reload
#sudo systemctl enable rclonegcloud.service
#sudo systemctl start rclonegcloud.service

#sudo systemctl daemon-reload
#sudo systemctl enable rcloneonedrive.service
#sudo systemctl start rcloneonedrive.service

#mkdir ~/Documents/rclone/gcloud/
#mkdir ~/Documents/rclone/onedrive/
###
# VM Ware Shared
#mkdir /home/$usr/shares
#vmhgfs-fuse .host:/ /home/$usr/shares -o subtype=vmhgfs-fuse

#############################################################################################################
## Git
# https://kbroman.org/github_tutorial/
# git config --global user.name "Your name here"
# git config --global user.email "your_email@example.com"
# git config --global color.ui true
# ssh-keygen -t rsa -C "your_email"
# or
# ssh-keygen -t ed25519 -C "email"
# Put the ssh.pub in github
# ssh -T git@github.com
# To copy
# xclip < brockargh.pub

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

#FALTA COSAS

## Font
# I put it on /debian-titus/install.sh
# Iosevka nerd font

## Clipboard for lazyVim
sudo nala install xclip -y

## Lazy git
cd $dir
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

#############################################################################################################
## Download CTT Script
#git clone https://github.com/ChrisTitusTech/debian-titus
cd debian-titus
sudo bash ./install.sh

cd $dir
cd debian-titus/mybash/
sudo bash ./setup.sh

cd $dir

#############################################################################################################
echo "Finished script"
echo "======================"
echo "Reboot your system"

#############################################################################################################
## TO DO
# Si es laptop no instalar preload timeshift ni QEMU e instalar tlp.
# echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile
# Poner scripts opcionales (nvidia, tlp (notebook), etc)
