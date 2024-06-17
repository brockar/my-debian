#!/bin/bash
EXT_LIST=(
	freon@UshakovVasilii_Github.yahoo.com
	blur-my-shell@aunetx
	ControlBlurEffectOnLockScreen@pratap.fastmail.fm
	appindicatorsupport@rgcjonas.gmail.com
	azwallpaper@azwallpaper.gitlab.com
	dash-to-dock@micxgx.gmail.com
	gnome-ui-tune@itstime.tech
	pano@elhan.io
	user-theme@gnome-shell-extensions.gcampax.github.com
)
for i in "${EXT_LIST[@]}"; do
	busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}
done
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
