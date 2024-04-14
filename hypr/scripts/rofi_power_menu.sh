!#/bin/bash

styles="#window {location: northeast;width: 250px; height: 180px;margin: 8px 12px;} listview {lines: 1;} element {padding: 0 0;} inputbar {enabled: false;}"

selected=$(printf "  Power off\n  Restart\n  Lock" | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary -theme-str "$styles")

case "$selected" in
"  Power off")
	shutdown -h now
	;;
"  Restart")
	shutdown -r now
	;;
"  Lock")
	hyprlock
	;;
*)
	exit 1
	;;
esac
