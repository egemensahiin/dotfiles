#!/bin/sh
udiskie &
feh --bg-fill ~/Pictures/wallpapers/wallp6.jpg &
nm-applet &
blueman-tray &
xset dpms 0 0 0 ; xset -dpms ; xset s noblank ; xset s noexpose ; xset s 0 0 &
xidlehook --not-when-fullscreen --not-when-audio --timer 300 "/home/egemen/.scripts/locker.sh" normal & 
xidlehook --not-when-fullscreen --not-when-audio --timer 150 "xset dpms force off" normal &
picom --shadow --shadow-radius=12 --shadow-offset-x=-15 --shadow-offset-y=-15 --inactive-opacity=0.75 --opacity-rule 100:"class_g = 'qutebrowser'" --opacity-rule 100:"class_g = 'VirualBox Machine'" --opacity-rule 100:"class_g = 'i3lock'" --opacity-rule 100:"class_g = 'Rofi'" --blur-method kawase --blur-strength 5 --blur-size 10 --blur-deviation 5.0 --backend glx & 
# --opacity-rule 100:"class_g = 'firefox'" append to picom setings when you need it 
optimus-manager-qt &
