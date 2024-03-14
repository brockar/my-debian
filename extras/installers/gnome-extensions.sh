#!/bin/bash
EXT_LIST=(
	blur-my-shell@aunetx
	dash-to-dock@micxgx.gmail.com
	clipboard-indicator@tudmotu.com
	freon@UshakovVasilii_Github.yahoo.com
	trayIconsReloaded@selfmade.pl
	gnome-ui-tune@itstime.tech
	emoji-copy@felipeftn
)
for i in "${EXT_LIST[@]}"; do
	busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}
done
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
