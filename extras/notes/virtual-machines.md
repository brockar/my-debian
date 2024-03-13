# VM Ware Shared
if are u in vmware and shared folders
sudo apt install vm-tools
mkdir /home/$usr/shares
vmhgfs-fuse .host:/ /home/$usr/shares -o subtype=vmhgfs-fuse

# qemu 
if u are on qemu
sudo nala install open-vm-tools spice-vdagent

#https://www.youtube.com/watch?v=vYQ9Bkv7VG4
#Create volumes with phisical disk
#sudo fdisk -l
#To view volumes and create a partition
#sudo pvcreate /dev/sdXX
#XX is the volume to do a phisical volume(?
