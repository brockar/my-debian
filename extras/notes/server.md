# to screen off

`apt install vbetool`
`sudo vbetool dpms off`
`sudo vbetool dpms on`

# to close screen and dont turn off

```bash
sudo nano /etc/systemd/logind.conf
```

and change
`#HandleLidSwitch=suspend`
to
`HandleLidSwitch=ignore`

# Grub

`sudo vim /etc/default/grub`
GRUB_TIMEOUT=0
GRUB_CMDLINE_LINUX_DEFAULT="quiet spash"

`sudo update-grub`

# SMB

<https://ubuntu.com/tutorials/install-and-configure-samba#3-setting-up-samba>

# Red

<https://jlsmorilloblog.wordpress.com/2017/06/25/montar-carpeta-de-red-en-linux/>
<https://odiseageek.es/posts/montar-unidades-smb-o-cifs-en-linux-con-mount-o-fstab/>

# mount ssh as local folder

sudo mount svang:/mnt/disk1/data/media/ /home/ubuntu/docker/jelly/svdisk1
