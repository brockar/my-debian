# GPU 
about:config
layers.acceleration.force-enabled "true"
media.ffmpeg.vaapi.enabled "true"
media.ffvpx.enabled "false"
gfx.webrender.all="true"


add to launcher
/usr/share/applications/firefox.desktop
Exec=env MOZ_X11_EGL=1 firefox %u

# adwaita theme
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash

# optimization
browser.tabs.loadDivertedInBackground "true"
browser.tabs.loadInBackground "false"

https://dev.to/msugakov/taking-firefox-memory-usage-under-control-on-linux-4b02
https://wiki.debian.org/Firefox#Hardware_Video_Acceleration
