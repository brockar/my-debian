#!/bin/bash
# https://linux.m2osw.com/transform-gnome-settings-command-lines
gsettings set org.gnome.desktop.interface cursor-theme 'Nordzy-cursors'
gsettings set org.gnome.desktop.interface icon-theme 'Nordzy-icons'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface monospace-font-name 'MesloLGS Nerd Font Mono 11'
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'
#gsettings set org.gnome.settings-daemon.plugins.media-keys www ['<Super>w']
#Doesn't work create a custom shortcut
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>i']"
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"
gsettings set org.gnome.settings-daemon.plugins.media-keys search "['<Alt>space']"
#gsettings set org.gnome.shell.keybindings toggle-message-tray @as "[]"

