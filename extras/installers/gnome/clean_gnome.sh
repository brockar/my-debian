echo -e "\n\n\nRemove some default apps and games?\n\n1. YES [Default]\\n2. NO \n"
read respuesta
if [ "$respuesta" -eq 2 ]; then
  echo "no app is being removed. xd"
else
  echo "Removing apps..."
  ##games
  nala remove gnome-games -y
  ##gnome software
  nala remove gnome-sound-recorder gnome-text-editor gnome-maps shotwell sane-airscan evolution rhythmbox transmission totem gnome-music -y #transmission-gtk transmission-common
  nala autoremove -y
fi