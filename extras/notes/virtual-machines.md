# VM Ware Shared
if are u in vmware and shared folders
sudo apt install vm-tools
mkdir /home/$usr/shares
vmhgfs-fuse .host:/ /home/$usr/shares -o subtype=vmhgfs-fuse

# qemu 
if u are on qemu
sudo nala install open-vm-tools spice-vdagent
