#!/bin/bash

function send_notification() {
	volume=$(pamixer --get-volume)
	dunstify -a "Change volume" -u low -r 9944 -h int:value:"$volume" -i "volume-$1" "Volume ${volume}%" -t 1500
}

function send_notification_spotify() {
	spotify_volume=$(playerctl --player="spotify" volume | awk '{ printf "%.0f\n", $0 * 100 }')
	dunstify -a " Spotify" -u low -r 9944 -h int:value:"$spotify_volume" -i "volume-$1" " Spotify volume ${spotify_volume}%" -t 1500
}
case $1 in
up)
	if [[ "$2" = "spotify" ]]; then
		playerctl -p spotify volume 0.05+
		send_notification_spotify up
		exit 1
	fi
	pamixer -u
	pamixer -i 5 --allow-boost
	send_notification $1
	;;
down)
	if [[ "$2" = "spotify" ]]; then
		playerctl -p spotify volume 0.05-
		send_notification_spotify down
		exit 1
	fi
	pamixer -u
	pamixer -d 5 --allow-boost
	send_notification $1
	;;
mute)
	pamixer -t
	if [[ $(pamixer --get-volume) ]]; then
		dunstify -i volume-mute -a "󰓃 Volume" -t 1500 -r 9944 -u low "Muted"
	else
		send_notification up
	fi
	;;
esac
