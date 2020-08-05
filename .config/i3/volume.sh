#!/bin/bash

VOL="$(ponymix | grep sink -A 2 | grep Volume | awk '{print $3}' | cut -d "%" -f1)"
MUTED="$(ponymix | grep sink -A 2 | grep Muted)"

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

if [[ $MUTED != "" ]]
then
	echo "Muted"
elif [[ $VOL -eq 0 ]]
then
	echo "$SYM"
elif [[ $VOL -gt 0 ]]
then
	echo "${SYM}${VOL}%"
fi
else
	echo "${SYM}${VOL}%"
fi

exit 0

