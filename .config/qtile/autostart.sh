#!/bin/sh
udiskie &
feh --bg-scale ~/Pictures/wallpapers/wallp5.jpg &
nm-applet &
blueman-tray &
xidlehook --not-when-fullscreen --not-when-audio --timer 300 "i3lock -e -i /home/egemen/Pictures/wallpapers/wallp15.jpg" normal &
picom -c -r 12 -l 0 -t 0 -i 0.75 --opacity-rule 100:"class_g = 'i3lock'" --opacity-rule 100:"class_g = 'Rofi'" --blur-method kawase --blur-strength 5 --blur-size 10 --blur-deviation 5.0 --backend glx --corner-radius 10 --rounded-corners-exclude "class_g = 'i3bar'" &
optimus-manager-qt &
