#! /bin/sh

WIDTH=-200
HEIGHT=-200
posX=$(($BLOCK_X - $WIDTH / 2))
posY=$(($BLOCK_Y - $HEIGHT))
yad --calendar \
		--width=$WIDTH --height=$HEIGHT \
		--undecorated --fixed \
		--close-on-unfocus --no-buttons \
		--posx=$posX --posy=$(($posY - 10)) \
		> /dev/null
