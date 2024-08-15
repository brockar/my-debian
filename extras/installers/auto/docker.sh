usr=$(id -u -n 1000)
dir=$(pwd)
#############################################################################################################
## DOCKER and Docker Desktop
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
curl -sSL https://get.docker.com | sh

## Docker compose
curl -SL https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo useradd $usr -G sudo
sudo usermod -a -G docker $usr

## Docker Desktop
# read https://docs.docker.com/desktop/install/debian/

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

sudo nala install curl wget
curl -sSL https://get.docker.com | sh
sudo  dockerd-rootless-setuptool.sh install
sudo sh -eux <<EOF
apt-get install -y uidmap
EOF

sudo  dockerd-rootless-setuptool.sh install
sudo sudo  dockerd-rootless-setuptool.sh install
dockerd-rootless-setuptool.sh install
