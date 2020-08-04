#!/bin/bash

NSTAT="$(xset -q | grep Num | awk '{print $8}')"
if [[ $NSTAT == "on" ]]
then
	echo "Num On"
fi
exit 0
