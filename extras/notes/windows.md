# AutoStart docker

echo '# Start Docker daemon automatically when logging in if not running.' >> ~/.bashrc
echo 'RUNNING=`ps aux | grep dockerd | grep -v grep`' >> ~/.bashrc
echo 'if [ -z "$RUNNING" ]; then' >> ~/.bashrc
echo ' sudo dockerd > /dev/null 2>&1 &' >> ~/.bashrc
echo ' disown' >> ~/.bashrc
echo 'fi' >> ~/.bashrc

/etc/wsl.conf
[boot]
command= service docker start

# Install docker

sudo apt update && sudo apt upgrade
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt install --no-install-recommends apt-transport-https ca-certificates curl gnupg2

update-alternatives --config iptables # And select iptables-legacy

. /etc/os-release
curl -fsSL https://download.docker.com/linux/${ID}/gpg | sudo tee /etc/apt/trusted.gpg.d/docker.asc

echo "deb [arch=amd64] https://download.docker.com/linux/${ID} ${VERSION_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER

#https://dev.to/bowmanjd/install-docker-on-windows-wsl-without-docker-desktop-34m9

# WSL Port Forward (un bardo)

#https://superuser.com/questions/1582234/make-ip-address-of-wsl2-static  
#https://dev.to/vishnumohanrk/wsl-port-forwarding-2e22  
#https://learn.microsoft.com/en-us/windows/wsl/networking

run `sudo apt install net-tools`

## Mode 1

netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=8080 connectaddress=(wsl hostname -I).split(" ")[0]

on rtorrent.ps1:
$wsl_ip = (wsl hostname -I).split(" ")[0]
Write-Host "WSL Machine IP: ""$wsl_ip"""
netsh interface portproxy add v4tov4 listenport=8080 connectport=8080 connectaddress=$wsl_ip

on Admin Powershell:
$trigger = New-JobTrigger -AtStartup -RandomDelay 00:00:15
Register-ScheduledJob -Trigger $trigger -FilePath C:\Users\marti\rtorrent.ps1 -Name RouteRTorrent

## Mode 2

make and `network.ps1` and add

```
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  $arguments = "& '" + $myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

$remoteport = bash.exe -c "ifconfig eth0 | grep 'inet '"
$found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';

if ($found) {
  $remoteport = $matches[0];
}
else {
  Write-Output "IP address could not be found";
  exit;
}

$ports = @(80,9696,7878,5055,8989,8081,8191);

for ($i = 0; $i -lt $ports.length; $i++) {
  $port = $ports[$i];
  Invoke-Expression "netsh interface portproxy delete v4tov4 listenport=$port";
  Invoke-Expression "netsh advfirewall firewall delete rule name=$port";

  Invoke-Expression "netsh interface portproxy add v4tov4 listenport=$port connectport=$port connectaddress=$remoteport";
  Invoke-Expression "netsh advfirewall firewall add rule name=$port dir=in action=allow protocol=TCP localport=$port";
}

Invoke-Expression "netsh interface portproxy show v4tov4";
```

after that, run the script with Admin Powershell `./network.ps1`

# Autostart WSL

on Win + R => shell:common startup
create a file.vbs with
set ws=wscript.CreateObject("wscript.shell")
ws.run "wsl -d Debian", 0

Or the name of your distro
or u can create a deb.bat
wsl.exe -d Debian

# SSH

## Admin powershell

Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
Get-Service ssh-agent

---
