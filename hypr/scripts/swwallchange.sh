#!/bin/env bash

wallpaper_folder=$HOME/.config/swww/$1
wallpaper_location="$(ls "$wallpaper_folder" | sort | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary)"

if [[ -d $wallpaper_folder/$wallpaper_location ]]; then
	wallpaper_temp="$wallpaper_location"
elif [[ -f $wallpaper_folder/$wallpaper_location ]]; then
	swww img "$wallpaper_folder"/"$wallpaper_temp"/"$wallpaper_location"
else
	exit 1
fi

