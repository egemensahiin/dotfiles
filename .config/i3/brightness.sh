#!/bin/bash

BRI="$(brightnessctl | grep Current | cut -d "(" -f2 | cut -d "%" -f1)"

echo " ${BRI}%"
# echo "BRI: ${BRI}%"

case $BLOCK_BUTTON in
 4) i3-msg -q "exec brightnessctl set 10%+ & exec pkill -SIGRTMIN+10 i3blocks" ;; # scroll up
 5) i3-msg -q "exec brightnessctl --min-value=750 set 10%- & exec pkill -SIGRTMIN+10 i3blocks" ;; # scroll down, decrease
esac

exit 0
