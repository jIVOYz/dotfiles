#!/bin/bash

function send_notification() {
	volume=$(pamixer --get-volume)
	dunstify -a "Change volume" -u low -r 9944 -h int:value:"$volume" -i "volume-$1" "Volume ${volume}%" -t 1500
}

case $1 in
up)
	pamixer -u
	pamixer -i 5 --allow-boost
	send_notification $1
	;;
down)
	pamixer -u
	pamixer -d 5 --allow-boost
	send_notification $1
	;;
mute)
	pamixer -t
	if [[ $(pamixer --get-volume) ]]; then
		dunstify -i volume-mute -a "changevolume" -t 1500 -r 9944 -u low "Muted"
	else
		send_notification up
	fi
	;;
esac
