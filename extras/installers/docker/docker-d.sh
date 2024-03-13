usr=$(id -u -n 1000)
dir=$(pwd)

#Docker Desktop
sudo usermod -aG kvm $usr
sudo apt remove docker-desktop
rm -r $HOME/.docker/desktop
sudo rm /usr/local/bin/com.docker.cli
sudo apt purge docker-desktop
wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.26.1-amd64.deb?utm_source=docker &
utm_medium=webreferral &
utm_campaign=docs-driven-download-linux-amd64
sudo apt-get install ./docker-desktop-*.deb
sudo rm docker-desktop-*.deb

#TO-DO wget doesn't work on debian testing

