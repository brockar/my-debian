#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
	echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
	exit 1
fi

builddir=$(pwd)/debian-titus
username=$(id -u -n 1000)

# Making .config and Moving config files and background to Pictures
#
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Pictures/backgrounds
cp -R $builddir/dotconfig/* /home/$username/.config/
cp $builddir/bg.jpg /home/$username/Pictures/backgrounds/
mv user-dirs.dirs /home/$username/.config
chown -R $username:$username /home/$username

# Installing Essential Programs
nala install feh kitty thunar lxpolkit x11-xserver-utils unzip build-essential libx11-dev libxft-dev libxinerama-dev -y #pulseaudio pavucontrol
# Installing Other less important Programs
nala install flameshot psmisc mangohud lxappearance papirus-icon-theme fonts-noto-color-emoji -y

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Installing fonts
cd $builddir
nala install fonts-font-awesome -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts
mv $builddir/dotfonts/fontawesome/otfs/*.otf /home/$username/.fonts/
chown $username:$username /home/$username/.fonts/*

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip ./Iosevka.zip

# Install Nordzy cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors
./install.sh
cd $builddir
rm -rf Nordzy-cursors

#############################################################################################################
# Enable graphical login and change target from CLI to GUI
#systemctl enable lightdm
#systemctl set-default graphical.target

# Beautiful bash
# git clone https://github.com/ChrisTitusTech/mybash
#cd $builddir
#cd mybash
#sudo bash $builddir/mybash/setup.sh
#cd $builddir
# Use nala
#sudo bash $builddir/scripts/usenala
