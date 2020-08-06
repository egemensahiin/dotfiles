#!/bin/bash

VOL="$(ponymix | grep sink -A 2 | grep Volume | awk '{print $3}' | cut -d "%" -f1)"
MUTED="$(ponymix | grep sink -A 2 | grep Muted)"

if [[ $MUTED != "" ]]
then
	echo "Muted"
else
	if [[ $VOL -gt 70 ]]
	then
		SYM=" "
	elif [[ $VOL -ge 30 ]]
	then
		SYM=" "
	elif [[ $VOL -gt 0 ]]
	then
		SYM=" "
	elif [[ $VOL -eq 0 ]]
	then
		SYM=" "
	fi
	echo "${SYM}${VOL}%"
fi

case $BLOCK_BUTTON in
 1) i3-msg -q "exec ponymix toggle & exec pkill -SIGRTMIN+10 i3blocks" ;;
 3) i3-msg -q "exec pavucontrol" ;;
 4) i3-msg -q "exec ponymix --max-volume 100 increase 5 & exec pkill -SIGRTMIN+10 i3blocks" ;; # scroll up
 5) i3-msg -q "exec ponymix --max-volume 100 decrease 5 & exec pkill -SIGRTMIN+10 i3blocks" ;; # scroll down, decrease
esac

exit 0

