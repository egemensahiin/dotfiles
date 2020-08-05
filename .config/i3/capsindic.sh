#!/bin/bash

CSTAT="$(xset -q |grep Caps | awk '{print $4}')"
if [[ $CSTAT == "on" ]]
then 
	echo "Caps On"
fi
exit 0
