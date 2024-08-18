# crontrab (recommend)
add a `crontab -e` entry
```
@reboot /bin/rclone sync -P gcloud: /home/brockar/Documents/rclone/gcloud/ --transfers=40 --exclude=/home/brockar/Documents/rclone/Obsidian/.obsidian
@reboot /bn/rclone copy -P gcloud: /home/brockar/Documents/rclone/gcloud/ --transfers=40 --exclude=/home/brockar/Documents/rclone/Obsidian/.obsidian
*/15 * * * * /bin/rclone sync -P /home/brockar/Documents/rclone/gcloud/ gcloud: --transfers=40 --exclude=/home/brockar/Documents/rclone/Obsidian/.obsidian
*/15 * * * * /bin/rclone copy -P /home/brockar/Documents/rclone/gcloud/ gcloud: --transfers=40 --exclude=/home/brockar/Documents/rclone/Obsidian/.obsidian
```
The structure is 
when_run command sync/copy from to --simultaneously_transfer --exclude_config(can remove this)

# Systemd
use the .services
