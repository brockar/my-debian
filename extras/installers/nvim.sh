#!/bin/bash
#Check if user is root
if [ $(id -u) -ne 0 ]; then
	echo "Please run as root"
	exit
fi
#############################################################################################################
## NVIM
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo ln -s nvim.appimage /usr/local/bin/nvim
#sudo mv $dir/nvim.appimage /usr/local/bin/nvim

# ## LazyVIM
# # required
mv $home/.config/nvim{,.bak}
# # optional but recommended
mv $home/.local/share/nvim{,.bak}
mv $home/.local/state/nvim{,.bak}
mv $home/.cache/nvim{,.bak}

git clone https://github.com/LazyVim/starter $home/.config/nvim
rm -rf $home/.config/nvim/.git
## Clipboard for lazyVim
sudo nala install xclip -y
## Lazy git
cd $dir
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz