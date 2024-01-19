Put the services under /etc/systemd/system/

and add a crontab -e entry

@hourly /usr/bin/rclone copy /home/brockar/Documents/rclone/gcloud/ gcloud:

# @hourly /usr/bin/rclone copy /path/from/host cloud:

