!#/bin/bash

styles="#window {location: northeast;width: 220px; height: 180px;margin: 8px 12px;} mainbox {} inputbar {enabled: false;}"
volume="pamixer get volue"
selected=$(printf "Toggle Mute  " | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary -theme-str "$styles")

case "$selected" in
"Toggle Mute  ")
	pamixer -t
	;;
*)
	exit 1
	;;
esac
