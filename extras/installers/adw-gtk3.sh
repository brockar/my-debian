#!/bin/bash
# https://github.com/lassekongo83/adw-gtk3
# Definir la URL base del repositorio de GitHub
repo_url="https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest/"
# Extraer la URL del archivo .deb de la última versión
deb_url=$(curl -s "$repo_url" | grep "*\.tar.xz" | cut -d : -f 2,3 | tr -d \")
# Descargar el archivo .deb
wget "$deb_url"*
sudo tar -xf adw-gtk3*.tar.xz /usr/share/themes/
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
rm adw*.tar.xz -rf
