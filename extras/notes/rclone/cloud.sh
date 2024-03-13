usr=$(id -u -n 1000)
dir=$(pwd)
##################################################
## RCLONE
# Create rclone syncs with gcloud and onedrive names or modify the services in ../service/
# gcloud as copy/sync (it takes some time the first backup)
# onedrive as mount (dont copy all files on machine)

mkdir /home/$usr/Documents/rclone/gcloud/
mkdir /home/$usr/Documents/rclone/onedrive/

sudo cp ./rcloneonedrive.service /etc/systemd/system/
sudo cp ./rclonegcloud.service /etc/systemd/system/

sudo systemctl daemon-reload

sudo systemctl enable rcloneonedrive.service
sudo systemctl start rcloneonedrive.service

sudo systemctl enable rclonegcloud.service
sudo systemctl start rclonegcloud.service

sudo systemctl daemon-reload
