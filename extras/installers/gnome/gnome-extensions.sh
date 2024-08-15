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
	just-perfection-desktop@just-perfection
	user-theme@gnome-shell-extensions.gcampax.github.com
	Rounded_Corners@lennart-k
	caffeine@patapon.info
	quick-settings-tweaks@qwreey
	tilingshell@ferrarodomenico.com
	weatheroclock@CleoMenezesJr.github.io
)
for i in "${EXT_LIST[@]}"; do
	busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}
done
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
