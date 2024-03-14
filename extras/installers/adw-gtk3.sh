#!/bin/bash
# Download the latest version of adw-gtk3
repo_url="https://api.github.com/repos/{owner}/{repo}/releases/latest"
repo_url=${repo_url/\{owner\}/lassekongo83}
repo_url=${repo_url/\{repo\}/adw-gtk3}
release_url=$(curl -s "$repo_url" | jq -r ".assets[] | select(.name | endswith(\".tar.xz\")) | .browser_download_url")
wget -O adw-gtk3.tar.xz "$release_url"

sudo tar -xf adw-gtk3.tar.xz -C /usr/share/themes
flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
rm adw-gtk3.tar.xz
