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
sudo nala install htop wget gpg rclone prusa-slicer thunderbird zoxide trash-cli -y

flatpak install flathub md.obsidian.Obsidian com.discordapp.Discord -y
#org.vim.Vim io.neovim.nvim

# Thorium
wget https://dl.thorium.rocks/debian/dists/stable/thorium.list
sudo mv thorium.list /etc/apt/sources.list.d/
sudo apt update
sudo apt install thorium-browser

# VS Code
sudo apt-get install wget gpg
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
	sudo apt install qemu-kvm virt-manager virtinst libvirt-clients bridge-utils libvirt-daemon-system -y
	sudo systemctl enable --now libvirtd
	sudo systemctl start libvirtd

	sudo usermod -aG kvm $usr
	sudo usermod -aG libvirt $usr
fi

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
sudo cp $dir/nala-sources.list /etc/apt/sources.list.d/nala-sources.list

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
#sudo cp $dir/rcloneod.service /etc/systemd/system/rcloneod.service
#sudo cp $dir/rcloneobs.service /etc/systemd/system/rcloneobs.service

#sudo systemctl daemon-reload
#sudo systemctl enable rcloneod.service
#sudo systemctl start rcloneod.service

#sudo systemctl daemon-reload
#sudo systemctl enable rcloneobs.service
#sudo systemctl start rcloneobs.service

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
# ssh-keygen -t rsa -C "your_email@example.com"
# Put the ssh.pub in github
# ssh -T git@github.com

#############################################################################################################
## ERROR en el script de Chris Titus
# '/root/.bashrc' -> '/home/debian/Documents/myscript/debian-titus/mybash/.bashrc'
# ln: failed to create symbolic link '/root/.config/starship.toml': No such file or directory

## MIRAR LO DE LIGHTDM q onda o sacar eso

#############################################################################################################
## NVIM
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo ln -s $dir/nvim.appimage /usr/local/bin/nvim

# ## LazyVIM
# # required
# mv ~/.config/nvim{,.bak}

# # optional but recommended
# mv ~/.local/share/nvim{,.bak}
# mv ~/.local/state/nvim{,.bak}
# mv ~/.cache/nvim{,.bak}

# git clone https://github.com/LazyVim/starter ~/.config/nvim

# rm -rf ~/.config/nvim/.git

## Font
# I put it on /debian-titus/install.sh
# Iosevka nerd font

## Clipboard for lazyVim
# sudo nala install xclip -y

## Lazy git
#cd $dir
#LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
#curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
#tar xf lazygit.tar.gz lazygit
#sudo install lazygit /usr/local/bin

#############################################################################################################
## Download CTT Script
#git clone https://github.com/ChrisTitusTech/debian-titus
cd debian-titus
sudo ./install.sh

cd $dir
cd debian-titus/mybash/
sudo ./setup.sh

cd $dir

#############################################################################################################
echo "Finished script"
echo "======================"
echo "Reboot your system"
