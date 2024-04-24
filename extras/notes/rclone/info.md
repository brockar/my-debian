run cloud.sh 

and add a crontab -e entry

@hourly /usr/bin/rclone copy /home/brockar/Documents/rclone/gcloud/ gcloud:
# --exclude=/home/.../.obsidian
#@hourly /usr/bin/rclone copy /path/from/host cloud:

