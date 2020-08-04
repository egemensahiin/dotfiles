#!/bin/sh
udiskie &
feh --bg-scale ~/Pictures/wallpapers/wallp1.png &
nm-applet &
blueman-tray &
xidlehook --not-when-fullscreen --not-when-audio --timer 300 "i3lock -e -i /home/egemen/Pictures/wallpapers/wallp5.png" normal &
xcompmgr &
optimus-manager-qt &
