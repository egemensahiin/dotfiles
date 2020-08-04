#!/bin/bash

SONG_CODE=$(xdotool search --class Spotify | tail -n 1)
SONG_NAME=$(xdotool getwindowname ${SONG_CODE})
if [[ $SONG_NAME != "" ]]
then
  echo " ${SONG_NAME}"
fi
