to screen off 
`apt install vbetool`
`doas/sudo vbetool dpms off`
`doas/sudo vbetool dpms on`
 
to close screen and dont turn off 
```bash
sudo nano /etc/systemd/logind.conf
```
and change 
`#HandleLidSwitch=suspend`
to 
HandleLidSwitch=ignore
