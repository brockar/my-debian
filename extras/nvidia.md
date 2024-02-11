# Nvidia with Secure boot
Look the steps for u distro version [here](https://wiki.debian.org/NvidiaGraphicsDrivers#Debian_Unstable_.22Sid.2(https://wiki.debian.org/NvidiaGraphicsDrivers#Debian_Unstable_.22Sid.22)2).

General: 
1. Just add "contrib non-free non-free-firmware" components to /etc/apt/sources.list
for example 
```
# Debian Sid
deb http://deb.debian.org/debian/ sid main contrib non-free non-free-firmware
```

2. Update the list of available packages, then we can install the nvidia-driver package, plus the necessary firmware: 
```
apt update
apt install nvidia-driver firmware-misc-nonfree
```

## Enroll keys (if u have secure boot)
To enroll a key:
`sudo mokutil --import /var/lib/dkms/mok.pub # prompts for one-time password`
/var/lib/dkms/


Write a password

At next reboot, the device firmware should launch it's MOK manager and prompt the user to review the new key and confirm it's enrollment, using the one-time password. Any kernel modules (or kernels) that have been signed with this MOK should now be loadable.

To verify the MOK was loaded correctly: 
```
sudo mokutil --test-key /var/lib/shim-signed/mok/MOK.der
# /var/lib/shim-signed/mok/MOK.der is already enrolled
```


# if Failed to start nvidia persistence daemon
`sudo apt purge nvidia-*`
`sudo apt install nvidia-kernels-dkms`

and the first part of the page.


# Extra - Undervolt
`sudo vim /etc/systemd/system/nvidia-powerlimit.service`

put:

```
[Unit]
Description=set nvidia power limit
[Service]
Type=oneshot
ExecStartPre=/usr/bin/nvidia-smi --persistence-mode=1
ExecStart=/usr/bin/nvidia-smi --power-limit=125
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target
```

`sudo chmod 644 /etc/systemd/system/nvidia-powerlimit.service`
`sudo systemctl daemon-reload`
`sudo systemctl enable nvidia-powerlimit.service`
`sudo reboot now`

---

sources:
- https://wiki.debian.org/NvidiaGraphicsDrivers#Debian_Unstable_.22Sid.22
- https://wiki.debian.org/SecureBoot#MOK_-_Machine_Owner_Key
- https://gist.github.com/padakuro/38c588dcc743092f7f98ba7720685e50
- https://docs.kinetica.com/7.1/install/nvidia_deb/
