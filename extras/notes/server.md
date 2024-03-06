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

`sudo update grub`

