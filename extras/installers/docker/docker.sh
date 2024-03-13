usr=$(id -u -n 1000)
dir=$(pwd)
#############################################################################################################
## DOCKER and Docker Desktop
# Docker Engine
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

## TO-DO doesnt work in testing.
# Add the repository to Apt sources:
# echo \
#   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#   "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#sudo apt-get update
#sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# sudo apt install docker.io -y
# for Debian Testing

## Docker compose
sudo curl -SL https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo useradd $usr -G sudo
sudo usermod -a -G docker $usr

## Docker Desktop
echo -e "Install Docker Desktop?\n\n1. YES \n2. NO\n"
read respuesta
if [ "$respuesta" -eq 1 ]; then
	sudo bash $dir/extras/installers/docker/docker-d.sh
fi

##  To move docker volumes to another disks
# sudo service docker stop
# sudo systemctl stop docker.socket
# sudo nvim /lib/systemd/system/docker.service
# in ExecStart add
# --data-root=/path/to/move
# sudo rsync -aP /var/lib/docker/ /new/PATH
# mv /var/lib/docker /var/lib/docker.old
# ln -s /new/path /var/lib/docker
# service docker start
# docker run --rm hello-world
# rm -rf /var/lib/docker.old

# https://stackoverflow.com/questions/59345566/move-docker-volume-to-different-partition
