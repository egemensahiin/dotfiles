#!/bin/bash

BRI="$(brightnessctl | grep Current | cut -d "(" -f2 | cut -d "%" -f1)"

echo " ${BRI}%"
# echo "BRI: ${BRI}%"

case $BLOCK_BUTTON in
 4) brightnessctl set 10%+ & pkill -SIGRTMIN+10 i3blocks ;; # scroll up
 5) brightnessctl --min-value=750 set 10%- & pkill -SIGRTMIN+10 i3blocks ;; # scroll down, decrease
esac

exit 0
