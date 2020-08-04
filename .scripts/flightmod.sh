#!/bin/bash

WIFI_STAT="$(nmcli radio wifi)" # enabled or disabled
BLUE_STAT="$(bluetoothctl show | grep Powered | awk '{print $NF}')" # yes or no

if [[ $WIFI_STAT == "enabled" || $BLUE_STAT == "yes" ]]
then
		nmcli radio wifi off
		bluetoothctl power off
else
		nmcli radio wifi on
		bluetoothctl power on
fi

exit 0
