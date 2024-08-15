#!/bin/bash
echo "LAZYVIM"
usr=$(id -u -n 1000)
dir=$(pwd)
home=/home/$usr
#############################################################################################################
## NVIM
sudo rm /usr/local/bin/nvim -f
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo ln -s $dir/nvim.appimage /usr/local/bin/nvim
#sudo mv nvim.appimage /usr/local/bin/nvim

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
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" $dir/

tar xf $dir/lazygit.tar.gz $dir/lazygit
sudo install $dir/lazygit /usr/local/bin
rm $dir/lazygit.tar.gz
