#!/bin/bash

HDMI_STAT=$(xrandr | grep HDMI-1 | cut -d " " -f 2)
ACTIVE_PRO=$(pacmd list-cards | grep 'active profile' | awk -F "<" '{print $2}' | awk -F ">" '{print $1}')

case $HDMI_STAT in
	disconnected)
		pactl set-card-profile 0 output:analog-stereo+input:analog-stereo
		;;
	connected)
		if [[ $ACTIVE_PRO == "output:analog-stereo+input:analog-stereo" ]]
		then
			pactl set-card-profile 0 output:hdmi-stereo-extra1+input:analog-stereo
		elif [[ $ACTIVE_PRO == "output:hdmi-stereo-extra1+input:analog-stereo" ]]
		then
			pactl set-card-profile 0 output:analog-stereo+input:analog-stereo
		fi
		;;
esac

exit 0
