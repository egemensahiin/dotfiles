#!/bin/bash

# touchpad'in ismi
TOUCHPAD="$(xinput --list --name-only | grep Touchpad)"
# touchpad durumunu kontrol et
STAT=$(xinput list-props "$TOUCHPAD" | grep "Device Enabled" | awk '{print $NF}')

if [[ "$STAT" -eq 0 ]]
then
				xinput --enable "$TOUCHPAD"
else
				xinput --disable "$TOUCHPAD"
fi

exit 0
