# GPU 
about:config
layers.acceleration.force-enabled "true"
media.ffmpeg.vaapi.enabled "true"
media.ffvpx.enabled "false"

add to launcher
/usr/share/applications/firefox.desktop
Exec= firefox %U MOZ_X11_EGL=1

# adwaita theme
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash

# optimization
browser.tabs.loadDivertedInBackground "true"
browser.tabs.loadInBackground "false"

https://dev.to/msugakov/taking-firefox-memory-usage-under-control-on-linux-4b02
