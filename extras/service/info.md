Put the services under /etc/systemd/system/

and add a crontab -e entry

@hourly rclone copy /home/brockar/Documents/rclone/gcloud/ gcloud:

# @hourly rclone copy /path/from/host cloud:

