<https://tuxrootsite.wordpress.com/2022/07/21/create-desktop-shortcut-for-an-appimage-on-linux/>
Download icon image.png/svg
chmod u+x your_app.AppImage
sudo mkdir /opt/your_app
sudo mv ~/Downloads/your_app.AppImage /opt/your_app/your_app.AppImage
sudo mv ~/Downloads/your_app.png /opt/your_app/your_app.png

sudo nvim ~/.local/share/applications/your_app.desktop

# Note: Only Type and Name are required

```

[Desktop Entry]
Type=Application
Version=1.0
# The name of the application
Name=jMemorize
# The executable of the application, possibly with arguments
Exec=jmemorize
# The name of the icon that will be used to display this entry
Icon=jmemorize
# Describes whether this application needs to be run in a terminal or not
Terminal=false
```

or

```
[Desktop Entry]
# The type as listed above
Type=Application
# The version of the desktop entry specification to which this file complies
Version=1.0
# The name of the application
Name=jMemorize
# A comment which can/will be used as a tooltip
Comment=Flash card based learning tool
# The path to the folder in which the executable is run
Path=/opt/jmemorise
# The executable of the application, possibly with arguments
Exec=jmemorize
# The name of the icon that will be used to display this entry
Icon=jmemorize
# Describes whether this application needs to be run in a terminal or not
Terminal=false
# Describes the categories in which this entry should be shown
Categories=Education;Languages;Java;
```

```
update-desktop-database ~/.local/share/applications
```

```
desktop-file-validate beeper.desktop
```

```
xdg-desktop-menu install beeper.desktop --novendor
```
