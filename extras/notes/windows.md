# AutoStart docker
echo '# Start Docker daemon automatically when logging in if not running.' >> ~/.bashrc
echo 'RUNNING=`ps aux | grep dockerd | grep -v grep`' >> ~/.bashrc
echo 'if [ -z "$RUNNING" ]; then' >> ~/.bashrc
echo '    sudo dockerd > /dev/null 2>&1 &' >> ~/.bashrc
echo '    disown' >> ~/.bashrc
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

# https://dev.to/bowmanjd/install-docker-on-windows-wsl-without-docker-desktop-34m9

# Network (un bardo)
# https://superuser.com/questions/1582234/make-ip-address-of-wsl2-static
# https://learn.microsoft.com/en-us/windows/wsl/networking

netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=8080 connectaddress=(wsl hostname -I).split(" ")[0]

on rtorrent.ps1:
$wsl_ip = (wsl hostname -I).split(" ")[0]
Write-Host "WSL Machine IP: ""$wsl_ip"""
netsh interface portproxy add v4tov4 listenport=8080 connectport=8080 connectaddress=$wsl_ip

on Admin Powershell:
$trigger = New-JobTrigger -AtStartup -RandomDelay 00:00:15
Register-ScheduledJob -Trigger $trigger -FilePath C:\Users\marti\rtorrent.ps1 -Name RouteRTorrent


on Win + R => shell:common startup
create a file.vbs with 
set ws=wscript.CreateObject("wscript.shell")
ws.run "wsl -d Debian", 0

Or the name of your distro

or u can create a deb.bat 
wsl.exe -d Debian

