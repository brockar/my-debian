# Services

## crontrab (recommend)

add a `crontab -e` entry

```bash
@reboot /bin/rclone sync -P gcloud: /home/brockar/Documents/gcloud/ --transfers=40 --exclude=/home/brockar/Documents/gcloud/Obsidian/.obsidian
*/15 * * * * /bin/rclone sync -P /home/brockar/Documents/gcloud/ gcloud: --transfers=40 --exclude=/home/brockar/Documents/gcloud/Obsidian/.obsidian
```

The structure is
when_run command sync/copy from to --simultaneously_transfer --exclude_config(can remove this)

## Systemd

use the .services
