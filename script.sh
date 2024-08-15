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
apt update && apt upgrade -y

## Install Nala and Git
apt install nala git -y

#############################################################################################################
## Install System apps
# Flatpak
nala install flatpak -y (not necesary)
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
    nala install gnome-software-plugin-flatpak -y
elif [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
    apt install plasma-discover-backend-flatpak
else
    echo "No se pudo determinar el entorno de escritorio."
fi

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#############################################################################################################
## CLEAN Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  $dir/extras/installers/gnome/clean_gnome.sh
  echo "u can install some customizations and extensions for gnome if u run the script "
  echo "extras/installers/gnome/gnome-cust.sh and adw-gtk3.sh and gnome-ext.sh"
fi

#############################################################################################################
### Install Apps
nala update && nala upgrade -y

for pkg in wget gpg curl rclone thunderbird zoxide trash-cli preload pipewire wireplumber pavucontrol helvum build-essential htop btop tree tldr ; do
  nala install $pkg -y
done

flatpak install flathub md.obsidian.Obsidian com.discordapp.Discord com.prusa3d.PrusaSlicer io.github.vikdevelop.SaveDesktop com.rtosta.zapzap org.videolan.VLC -y

## Firefox
$dir/extras/installers/auto/firefox-deb.sh
## Brave
$dir/extras/installers/auto/brave.sh
## Vs Code
$dir/extras/installers/auto/code.sh
## NVIM
$dir/extras/installers/auto/nvim.sh

## Enable wireplumber
sudo -u $username systemctl --user enable wireplumber.service

## QEMU and KVM
echo -e "\n\n\nInstall QEMU? \n\n1. YES \n2. NO [Default]"
read respuesta
if [ "$respuesta" -eq 1 ]; then
  echo "\nInstalling QEMU..."
  nala install qemu-kvm virt-manager virtinst spice-vdagent libvirt-clients bridge-utils libvirt-daemon-system -y
  systemctl enable --now libvirtd
  systemctl start libvirtd

  usermod -aG kvm $usr
  usermod -aG libvirt $usr
fi

## Docker
echo -e "\n\n\nInstall Docker?\n\n1. YES \n2. NO [Default]\n"
read respuesta
if [ "$respuesta" -eq 1 ]; then
  $dir/extras/installers/auto/docker.sh
fi

#############################################################################################################
### PERSONALIZATION

## CTT Script
#git clone https://github.com/ChrisTitusTech/debian-titus
$dir/debian-titus/install.sh
$dir/debian-titus/mybash/setup.sh

## Grub Theme
echo "Install Grub Theme"
echo "=================================="
echo "My favorite is VIMIX, choose one"
echo "=================================="
#git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes
cd $dir/Top-5-Bootloader-Themes
./install.sh

#############################################################################################################
echo "======================"
echo -e "\n\n\U can look for more apps in the extras folder \nand read some notes about the system in the notes folder"
echo "======================"

echo -e "\n\n\nFinished script"
echo "======================"
echo "Reboot your system"
#############################################################################################################
