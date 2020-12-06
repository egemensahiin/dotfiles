#!/bin/bash
# run this script on boot as root (with crontab)
xidlehook --timer 10 "echo 0 > /sys/devices/platform/tuxedo_keyboard/state" "echo 1 > /sys/devices/platform/tuxedo_keyboard/state"
