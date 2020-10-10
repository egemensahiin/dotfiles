#!/bin/sh
udiskie &
feh --bg-fill ~/Pictures/wallpapers/wallp6.jpg &
nm-applet &
blueman-tray &
xidlehook --not-when-fullscreen --not-when-audio --timer 300 "i3lock -e -i /home/egemen/Pictures/wallpapers/wallp15.png && xset dpms force off" normal &
picom -c -r 12 -l -15 -t -15 -i 0.75 --opacity-rule 100:"class_g = 'i3lock'" --opacity-rule 100:"class_g = 'Rofi'" --blur-method kawase --blur-strength 5 --blur-size 10 --blur-deviation 5.0 --backend glx & 
optimus-manager-qt &
