# Personalization
## Keyboards shortcuts
Settings > Keyboard > View and Customize Shortcuts

### Launchers
Home Folder = Super + E
Launch web browser = Super + W
Search = Alt + Space
Settings = Super + I

### Navigation
Switch Applications = Super + Tab
Switch windows = Alt + Tab

### System
Show the overview = Disable

### Windows
Activate the windows menu = Disable

### Custom Shortcuts
flameshot gui = Shift + Super + S (if doesn't work, try `script --command "flameshot gui" /dev/null`)
gnome-terminal = Super +  Shift + X
kitty = Super + X
simplemoji --show-search -t medium = Super + .

## Extensions
Clipboard Indicator
TopHat
[Tray Icons: Reloaded](https://extensions.gnome.org/extension/2890/tray-icons-reloaded)
[Gnome 4x UI Improvements](https://extensions.gnome.org/extension/4158/gnome-40-ui-improvements/)
[Blur my Sell](https://extensions.gnome.org/extension/3193/blur-my-shell/)
[Freon](https://extensions.gnome.org/extension/841/freon/) (Temperatures)
Dash to dock

## Theme
[adw-gtk3](https://github.com/lassekongo83/adw-gtk3)

# GRUB
/etc/default/grub
#GRUB_GFXMODE=auto
to
GRUB_GFXMODE="1368x768"

and

sudo update-grub

## Order on /boot/grub/grub.cfg

# Fonts
`~/.config/fontconfig/fonts.conf`
https://forum.endeavouros.com/t/tip-enable-colour-emojis/6210

