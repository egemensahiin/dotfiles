#!/bin/bash

SAVE="/home/egemen/Pictures/Screenshots"

[ ! -d $SAVE ] && mkdir "$SAVE"

FILE="${SAVE}/Screenshot$(date +%Y%m%d%H%M%S)"

FILE_NAME="${FILE}.png"

# -- CHECK HERE: It seemed very simple but it isn't work, idk why.
# NUM=1
# 
# while [[ -f "${FILE_NAME}" ]]
# do
# 	FILE_NAME="${FILE}(${NUM}).png"
# 	NUM=$(( NUM + 1 ))
# done

maim | tee ${FILE_NAME} | xclip -selection clipboard -t image/png

i3-nagbar -t warning -f "Inconsolata Regular 9" -m "Screenshot saved as $(basename ${FILE_NAME})." -B 'Delete' "rm ${FILE_NAME}" 
sleep 3s
pkill i3-nagbar

exit 0
