#!/bin/bash

HDMI_STAT=$(xrandr | grep HDMI-1-2 | cut -d " " -f 2)
ACTIVE_PRO=$(pacmd list-cards | grep 'active profile' | awk -F "<" '{print $2}' | awk -F ">" '{print $1}')

case $HDMI_STAT in
	disconnected)
		i3-msg -q "exec pactl set-card-profile 0 output:analog-stereo+input:analog-stereo & exec pkill -SIGRTMIN+10 i3blocks"
		;;
	connected)
		if [[ $ACTIVE_PRO == "output:analog-stereo+input:analog-stereo" ]]
		then
			i3-msg -q "exec pactl set-card-profile 0 output:hdmi-stereo-extra1+input:analog-stereo & exec pkill -SIGRTMIN+10 i3blocks"
		elif [[ $ACTIVE_PRO == "output:hdmi-stereo-extra1+input:analog-stereo" ]]
		then
			i3-msg -q "exec pactl set-card-profile 0 output:analog-stereo+input:analog-stereo & exec pkill -SIGRTMIN+10 i3blocks"
		fi
		;;
esac

pkill -SIGRTMIN+10 i3blocks

exit 0
