#!/bin/sh

THEMES_FOLDER="~/.config/hypr/themes"

selected="$(ls "$HOME/.config/hypr/themes" | sort | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary)"

if [ -z $selected ]; then
	exit 1
else
	~/.config/hypr/scripts/switch_theme.sh $selected
fi
