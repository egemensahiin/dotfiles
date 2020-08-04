#!/bin/bash

# bos string
BOS=""

# pacman ve aur paketlerini guncelle:
yay -Syu

# pip paketlerini guncelle:
read -p 'PyPi paketleri guncellensin mi? [y/N]: ' SECENEK
case "$SECENEK" in
	y|Y) for i in $(pip list -o | awk 'NR > 2 {print $1}');do pip install -U $i;done;;
	n|N|${BOS}) echo "PyPi paketleri güncellenmedi.";;
	?) read -p 'PyPi paketleri guncellensin mi? [y/N]: ' SECENEK;;
esac
