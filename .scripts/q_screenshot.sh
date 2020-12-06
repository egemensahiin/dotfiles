#!/bin/bash

SAVE="/home/egemen/Pictures/Screenshots"

if [[ ! -d $SAVE ]]
then
	mkdir "$SAVE"
fi

FILE="${SAVE}/Screenshot$(date +%Y%m%d%H%M%S)"

NUM=1

while [[ -f ${FILE} ]]
do
	FILE="${FILE}(${NUM})"
	NUM=$(( NUM + 1 ))
done

FILE_NAME="${FILE}.png"

maim | tee ${FILE_NAME} | xclip -selection clipboard -t image/png

notify-send -i "$FILE_NAME" \
			"Screenshot saved as
$(basename $FILE_NAME)."

exit 0
