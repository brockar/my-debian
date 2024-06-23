# Disable Swap
sudo vim /etc/fstab

comment with # the line that contains "swap".


# Install zram
	
sudo apt install zram-tools

sudo vim /etc/default/zramswap

ALGO=zstd

PERCENTAGE=50

Done!
