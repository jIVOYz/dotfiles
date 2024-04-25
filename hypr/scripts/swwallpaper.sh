#!/bin/bash

DIR=/home/ilya/.config/swww/$1
PICS=($(ls ${DIR}))

RANDOMPICS=${PICS[$RANDOM % ${#PICS[@]}]}

if [[ $(pidof swaybg) ]]; then
	pkill swaybg
fi

swww query || swww init

#change-wallpaper using swww
swww img ${DIR}/${RANDOMPICS} --transition-fps 30 --transition-type 3 --transition-duration 3
